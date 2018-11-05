/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50208 "NAC.IBMNAV.ThridSync"
{
    Description = 'This codeunit runs the integration for customer and vendor sync.';
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
        CalculateThirds();
        ExportUploadDataForIBM();
        UploadDataToIBM();

        CloseDialog();
    end;

    local procedure CalculateThirds()
    var
        company: Record Company;
        iBMSetupCompany: Record "NAC.IBMNAV.Setup";
        iFXThird: Record "NAC.IBMNAV.IFTHIRD";
        customer: Record Customer;
        vendor: Record Vendor;
    begin
        // 1. Collection and populate table IFXTHIRD with eligable customers and vendor accross companies
        if company.FindFirst() then begin
            iBMSetupCompany.ChangeCompany(company.Name);
            if iBMSetupCompany.get() then begin
                if iBMSetupCompany.EnableIFXTHIRD then begin
                    // Collect Customers and Vendors here...
                    if iBMSetupCompany.IFXThirdCompanyID <> '' then begin
                        if iBMSetupCompany.IFXThirdLastSyncDate <> Today() then begin

                            customer.ChangeCompany(company.Name);
                            vendor.ChangeCompany(company.Name);

                            // This is dirty I know... may need to add a key to the actual table at some point.
                            // customer.SetCurrentKey("Last Date Modified");
                            // vendor.SetcurrentKey("Last Date Modified");

                            customer.SetRange("Last Date Modified", iBMSetupCompany.IFXThirdLastSyncDate, Today());
                            vendor.SetRange("Last Date Modified", iBMSetupCompany.IFXThirdLastSyncDate, Today());

                            if customer.IsEmpty() = false then begin
                                customer.FindFirst();
                                repeat
                                    iFXThird.Init();

                                    iFXThird.CompanyID := iBMSetupCompany.IFXThirdCompanyID;
                                    iFXThird.NAVNITCode := customer."No.";

                                    iFXThird.CompanyAddr1 := copystr(customer.Address, 1, 36);
                                    iFXThird.CompanyAddr2 := CopyStr(customer."Address 2", 1, 36);
                                    iFXThird.CompanyBlocked := customer.Blocked;
                                    iFXThird.CompanyCity := customer.City;
                                    iFXThird.CompanyCountry := customer."Country/Region Code";
                                    iFXThird.CompanyCurrency := customer."Currency Code";
                                    iFXThird.CompanyName := CopyStr(customer.Name, 1, 36);
                                    iFXThird.CompanyPaymentTerms := customer."Payment Terms Code";
                                    iFXThird.CompanyPostCode := customer."Post Code";
                                    iFXThird.CompanyVATNo := customer."VAT Registration No.";
                                    iFXThird.CompanyVATPostGrp := customer."Gen. Bus. Posting Group";
                                    iFXThird.ContactEmail := customer."E-Mail";
                                    iFXThird.ContactName := copystr(customer.Contact, 1, 36);
                                    iFXThird.ContactTel := copystr(customer."Phone No.", 1, 25);

                                    if iFXThird.insert(false) then begin end;

                                until customer.Next() = 0;
                            end;

                            if vendor.IsEmpty() = false then begin
                                vendor.FindFirst();
                                repeat
                                    iFXThird.Init();

                                    iFXThird.CompanyID := iBMSetupCompany.IFXThirdCompanyID;
                                    iFXThird.NAVNITCode := vendor."No.";

                                    iFXThird.CompanyAddr1 := copystr(vendor.Address, 1, 36);
                                    iFXThird.CompanyAddr2 := CopyStr(vendor."Address 2", 1, 36);
                                    iFXThird.CompanyBlocked := vendor.Blocked;
                                    iFXThird.CompanyCity := vendor.City;
                                    iFXThird.CompanyCountry := vendor."Country/Region Code";
                                    iFXThird.CompanyCurrency := vendor."Currency Code";
                                    iFXThird.CompanyName := CopyStr(vendor.Name, 1, 36);
                                    iFXThird.CompanyPaymentTerms := vendor."Payment Terms Code";
                                    iFXThird.CompanyPostCode := vendor."Post Code";
                                    iFXThird.CompanyVATNo := vendor."VAT Registration No.";
                                    iFXThird.CompanyVATPostGrp := vendor."Gen. Bus. Posting Group";
                                    iFXThird.ContactEmail := vendor."E-Mail";
                                    iFXThird.ContactName := copystr(vendor.Contact, 1, 36);
                                    iFXThird.ContactTel := copystr(vendor."Phone No.", 1, 25);

                                    if iFXThird.insert(false) then begin end;

                                until vendor.Next() = 0;
                            end;

                            iBMSetupCompany.IFXThirdLastSyncDate := Today();
                            iBMSetupCompany.Modify(false);

                        end;
                    end;
                end;
            end;
        end;
    end;

    local procedure UploadDataToIBM()
    begin
        UpdateDialog('Uploading Data to IBM');
        if dataTransfer.DataTransfer_Upload(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.IFXThirdDataDefinitionFileName) then begin
            /// Success
        end
        else begin
            /// Fail
            ERROR('Unable to Upload file to IBM Server.')
        end;
    end;


    local procedure ExportUploadDataForIBM()
    var
        iFTHIRDExport: XmlPort "NAC.IBMNAV.IFTHIRDXMLP";
        txtOutStream: OutStream;
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
        txtIFRETID: Code[10];
    begin
        UpdateDialog('Exporting Upload Data for IBM');
        txtIFRETID := 'IFTHIRD';
        IF processBlob.Get(txtIFRETID) then processBlob.Delete(FALSE);
        processBlob.init;
        processBlob.PrimaryKey := txtIFRETID;
        processBlob.Insert(false);

        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateOutStream(txtOutStream);
        iFTHIRDExport.SetDestination(txtOutStream);
        iFTHIRDExport.Export();
        processBlob.Modify(FALSE);
        processBlob.ExportToServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFXThirdDataResponseFileName, true);

        processBlob.get(txtIFRETID);
        processBlob.Delete(false);
    end;


    /// This procedure makes sure that server staging files for this company have been removed. 
    local procedure CleanUpStagingFiles()
    var
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
    begin
        UpdateDialog('Cleaning Up Staging Files');
        processBlob.EraseServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFXThirdDataResponseFileName);
    end;


    /// This procedures tests setup fields
    local procedure VerifyIBMNAVSetup()
    begin
        UpdateDialog('Verifying Setup Information');
        iBMNAVSetup.GET;
        /// Data Definitions
        /// *ToDo: Add a check to see if these file actually exist on the server.
        iBMNAVSetup.TestField(DataDefinitionPath);
        iBMNAVSetup.TestField(IFXThirdDataDefinitionFileName);
        /// Staging
        iBMNAVSetup.TestField(DataStagingPath);
        iBMNAVSetup.TestField(IFXThirdDataResponseFileName);
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