

page 50202 "NAC.IBMNAV.SetupCard"
{
    PageType = Card;
    SourceTable = "NAC.IBMNAV.Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    Caption = 'NAC.IBMNAV Integration Setup Card';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'iSeries Definitions';
                field("Data Definition Path"; DataDefinitionPath) { }
                field("Data Definition Batch FileName"; DataDefinitionBatchFileName) { }
                field("Data Definition Response FileName"; DataDefinitionResponseFileName) { }
            }
            group(DataStagingArea)
            {
                Caption = 'Data Staging Area';
                field("Data Staging Path"; DataStagingPath) { }
                field("Data Staging Batch FileName"; DataStagingBatchFileName) { }
                field("Data Staging Response FileName"; DataStagingResponseFileName) { }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("General Journal Template"; GenJnlTemplate) { }
                field("General Journal Batch Code"; GenJnlBatchCode) { }
            }
            group(IFXRATE)
            {
                Caption = 'Exchange Rate Sync';
                field("Enable Exchange Rate Sync"; EnableIFXRATE) { }
                field("IFX Rate Data Definition"; IFXRateDataDefinitionFileName) { }
                field("IFX Rate Data Staging"; IFXRateDataStagingFileName) { }

            }
            group(IFXTHIRD)
            {
                Caption = 'Third Customer/Vendor Sync';
                field("Enable Third Sync"; EnableIFXTHIRD) { }
                field("IFX Third Data Definition"; IFXThirdDataDefinitionFileName) { }
                field("IFX Third Data Response"; IFXThirdDataResponseFileName) { }
                field("IFX Third Last Sync Date"; IFXThirdLastSyncDate) { }
                field("IFX Third Company ID"; IFXThirdCompanyID) { }

            }
            group(IFPMNT)
            {
                Caption = 'Payment Sync';
                field("Enable Payment Sync"; EnableIFPMNT) { }
                field("IF Pyment Company ID"; IFPMNTCompanyID) { }
                field("IF Payment Data Definition"; IFPMNTDataDefinitionFileName) { }
                field("IF Payment Data Response"; IFPMNTDataResponseFileName) { }
                field("IF Payment Last Sync Date"; IFPMNTLastSyncDate) { }
                field("IF Payment Last Entry No."; IFPMNTLastDetailEntryNo) { }
            }

        }
    }
    actions
    {
        area(processing)
        {
            action(SetupDefaults)
            {
                Caption = 'Setup Defaults';
                Image = Setup;
                trigger OnAction();
                begin
                    Rec.SetupDefaults();
                    rec.Modify(FALSE);
                    CurrPage.Activate(true);
                end;
            }
            action(UpdateTransactions)
            {
                Caption = 'Update Historical Transactions';
                Visible = true;
                trigger OnAction();
                var
                    IBMUpdate: Codeunit "NAC.IBMNAV.TransUpdate";
                begin
                    IBMUpdate.Run();
                end;
            }

            action(ProcessDownloadTest)
            {
                Caption = 'Process Download Test';
                Image = TestFile;
                Visible = false;
                trigger OnAction();
                var
                    IBMProcess: Codeunit "NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessDownloadTest();
                end;
            }
            action(ProcessImportIFBAT)
            {
                Caption = 'Test importing batch file';
                Visible = false;
                trigger OnAction();
                var
                    IBMProcess: Codeunit "NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessImportIFBATTest();
                end;
            }
            action(ProcessExportIFRET)
            {
                Caption = 'Test exporting return file';
                Visible = false;
                trigger OnAction();
                var
                    IBMProcess: Codeunit "NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessExportIFRETTest();
                end;
            }
            action(ProcessUploadTest)
            {
                Caption = 'Process Upload Test';
                Image = TestFile;
                Visible = false;
                trigger OnAction();
                var
                    IBMProcess: Codeunit "NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessUploadTest();
                end;
            }
            action(ClearTransactionEntries)
            {
                Caption = 'DEBUG: Clear Transactions';
                Visible = false;
                trigger OnAction();
                var
                    tranactionEntry: Record "NAC.IBMNAV.TransactionEntry";
                begin
                    tranactionEntry.deleteall(false);
                    Message('Entries have been cleared.');
                end;
            }
            action(ProcessManualTest)
            {
                Caption = 'Process Manual Integration';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    iBMProcess: Codeunit "NAC.IBMNAV.Process";
                begin
                    iBMProcess.Code();
                end;
            }
            action(ProcessIFXRATE)
            {
                Caption = 'Process Exchange Rate Sync';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    iBMRateSync: Codeunit "NAC.IBMNAV.RateSync";
                begin
                    iBMRateSync.Code();
                end;
            }
            action(ProcessIFPMNT)
            {
                Caption = 'Process Payments Sync';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    iBMPaymentSync: Codeunit "NAC.IBMNAV.PaymentSync";
                begin
                    iBMPaymentSync.Code();
                end;
            }

            action(ProcessIFXTHIRD)
            {
                Caption = 'Process THIRD Sync';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    iBMThirdSync: Codeunit "NAC.IBMNAV.ThridSync";
                begin
                    iBMThirdSync.Code();
                end;
            }
            action(LockRecord)
            {
                Caption = 'Lock Record';
                Image = Lock;
                trigger OnAction()
                begin
                    Rec.Locked := true;
                    Modify(false);
                end;
            }
            action(UnLockRecord)
            {
                Caption = 'Unlock Record';
                Image = ReOpen;
                trigger OnAction()
                begin
                    Rec.Locked := false;
                    Modify(false);
                end;
            }
        }
    }


    trigger OnOpenPage();
    begin
        // Make sure there is a record, otherwise create it and set defaults.
        if Rec.get() = false then begin
            Rec.INIt;
            Rec.SetupDefaults();
            Rec.Insert(FALSE);
        end;

    end;
}