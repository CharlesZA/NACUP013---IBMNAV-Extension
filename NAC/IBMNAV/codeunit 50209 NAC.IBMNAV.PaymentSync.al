/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50209 "NAC.IBMNAV.PaymentSync"
{
    Description = 'This codeunit runs the integration for sending customer payments back to IBM';
    TableNo = "Job Queue Entry";

    var
        dataTransfer: Codeunit "NAC.IBMNAV.ACL";
        iBMNAVSetup: Record "NAC.IBMNAV.Setup";

        dialogWindow: Dialog;
        dialogWindowOpen: Boolean;

    trigger OnRun()
    begin
        Code();
    end;

    procedure Code()
    begin
        OpenDialog();

        VerifyIBMNAVSetup();
        CleanUpStagingFiles();
        CalculatePayments();
        ExportUploadDataForIBM();
        UploadDataToIBM();

        CloseDialog();
    end;

    local procedure CalculatePayments()
    var
        company: Record Company;
        iBMSetupCompany: Record "NAC.IBMNAV.Setup";
        iFPMNT: Record "NAC.IBMNAV.IFPMNT";
        customerLedgerEntry: Record "Cust. Ledger Entry";
        detailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        lastProcessedEntryNo: Integer;
    begin
        iFPMNT.DeleteAll();
        // 1. Collection and populate table IFXTHIRD with eligable customers and vendor accross companies
        if company.FindFirst() then begin
            repeat
                iBMSetupCompany.ChangeCompany(company.Name);
                if iBMSetupCompany.get() then begin
                    if iBMSetupCompany.EnableIFPMNT then begin
                        // Collect Customers ENTRIES
                        if iBMSetupCompany.IFPMNTCompanyID <> '' then begin
                            customerLedgerEntry.ChangeCompany(company.Name);
                            detailedCustomerLedgerEntry.ChangeCompany(company.Name);

                            if iBMSetupCompany.IFPMNTLastDetailEntryNo <> 0 then begin
                                detailedCustomerLedgerEntry.SetFilter(detailedCustomerLedgerEntry."Entry No.", '>%1', iBMSetupCompany.IFPMNTLastDetailEntryNo);
                            end;

                            // Only want the applied entries
                            detailedCustomerLedgerEntry.SetRange(detailedCustomerLedgerEntry."Entry Type", detailedCustomerLedgerEntry."Entry Type"::Application);

                            if detailedCustomerLedgerEntry.IsEmpty() = false then begin
                                detailedCustomerLedgerEntry.find('-');
                                repeat
                                    lastProcessedEntryNo := detailedCustomerLedgerEntry."Entry No.";
                                    if customerLedgerEntry.get(detailedCustomerLedgerEntry."Cust. Ledger Entry No.") then begin
                                        // Check if applied entry comes from AMASIS by evaluating the transaction no.
                                        if customerLedgerEntry."NAC.IBMNAV Transaction No." <> 0 then begin
                                            iFPMNT.Init();

                                            iFPMNT.CompanyID := iBMSetupCompany.IFPMNTCompanyID;
                                            iFPMNT.TranactionCode := customerLedgerEntry."NAC.IBMNAV Transaction Code";
                                            iFPMNT.TransactionID := customerLedgerEntry."NAC.IBMNAV Transaction No.";
                                            iFPMNT.NAVEntryNo := detailedCustomerLedgerEntry."Entry No.";
                                            iFPMNT.AMSDocumentNo := customerLedgerEntry."Document No.";
                                            iFPMNT.NAVNITCode := customerLedgerEntry."Customer No.";

                                            iFPMNT.PostingDate := detailedCustomerLedgerEntry."Posting Date";
                                            iFPMNT.CurrencyCode := detailedCustomerLedgerEntry."Currency Code";
                                            iFPMNT.Amount := detailedCustomerLedgerEntry.Amount;
                                            iFPMNT.AmountLCY := detailedCustomerLedgerEntry."Amount (LCY)";
                                            iFPMNT.PaymentReference := detailedCustomerLedgerEntry."Document No.";
                                            iFPMNT.PaymentReferencyType := Format(detailedCustomerLedgerEntry."Document Type");
                                            iFPMNT.InvoiceFullyPaid := customerLedgerEntry.Open;

                                            if iFPMNT.Insert(false) then begin end;
                                        end;
                                    end;
                                until detailedCustomerLedgerEntry.Next() = 0;
                            end;

                            iBMSetupCompany.IFPMNTLastDetailEntryNo := lastProcessedEntryNo;
                            iBMSetupCompany.IFPMNTLastSyncDate := Today();
                            iBMSetupCompany.Modify(false);

                        end;
                    end;
                end;
            until company.next() = 0;
        end;
    end;

    local procedure UploadDataToIBM()
    begin
        UpdateDialog('Uploading Data to IBM');
        if dataTransfer.DataTransfer_Upload(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.IFPMNTDataDefinitionFileName) then begin
            /// Success
        end
        else begin
            /// Fail
            ERROR('Unable to Upload file to IBM Server.')
        end;
    end;


    local procedure ExportUploadDataForIBM()
    var
        iFPMNTExport: XmlPort "NAC.IBMNAV.IFPMNTXMLP";
        txtOutStream: OutStream;
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
        txtIFRETID: Code[10];
    begin
        UpdateDialog('Exporting Upload Data for IBM');
        txtIFRETID := 'IFPMNT';
        IF processBlob.Get(txtIFRETID) then processBlob.Delete(FALSE);
        processBlob.init;
        processBlob.PrimaryKey := txtIFRETID;
        processBlob.Insert(false);

        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateOutStream(txtOutStream);
        iFPMNTExport.SetDestination(txtOutStream);
        iFPMNTExport.Export();
        processBlob.Modify(FALSE);
        processBlob.ExportToServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFPMNTDataResponseFileName, true);

        processBlob.get(txtIFRETID);
        processBlob.Delete(false);
    end;


    /// This procedure makes sure that server staging files for this company have been removed. 
    local procedure CleanUpStagingFiles()
    var
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
    begin
        UpdateDialog('Cleaning Up Staging Files');
        processBlob.EraseServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFPMNTDataResponseFileName);
    end;


    /// This procedures tests setup fields
    local procedure VerifyIBMNAVSetup()
    begin
        UpdateDialog('Verifying Setup Information');
        iBMNAVSetup.GET;
        /// Data Definitions
        /// *ToDo: Add a check to see if these file actually exist on the server.
        iBMNAVSetup.TestField(DataDefinitionPath);
        iBMNAVSetup.TestField(IFPMNTDataDefinitionFileName);
        /// Staging
        iBMNAVSetup.TestField(DataStagingPath);
        iBMNAVSetup.TestField(IFPMNTDataResponseFileName);
    end;


    /// Dialog for manual processing
    local procedure OpenDialog()
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen = false then begin
                dialogWindow.Open('Processing NAC.IBMNAV\\Current Activity #1###############');
                dialogWindowOpen := true;
            end;
        end;
    end;

    local procedure UpdateDialog(progressText: Text[50])
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen then begin
                dialogWindow.Update(1, progressText);
            end;
        end;
    end;

    local procedure CloseDialog()
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen then begin
                dialogWindow.Close();
                dialogWindowOpen := false;
            end;
        end;
    end;

}