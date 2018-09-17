

page 50202 "NAC.IBMNAV.SetupCard"
{
    PageType = Card;
    SourceTable = "NAC.IBMNAV.Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    Caption='NAC.IBMNAV Integration Setup Card';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption='iSeries Definitions';
                field("Data Definition Path";DataDefinitionPath){}
                field("Data Definition Batch FileName";DataDefinitionBatchFileName){}
                field("Data Definition Response FileName";DataDefinitionResponseFileName){}
            }
            group(DataStagingArea)
            {
                Caption='Data Staging Area';                
                field("Data Staging Path";DataStagingPath){}
                field("Data Staging Batch FileName";DataStagingBatchFileName){}
                field("Data Staging Response FileName";DataStagingResponseFileName){}
            }   
            group(Posting)
            {
                Caption='Posting';
                field("General Journal Template";GenJnlTemplate){}
                field("General Journal Batch Code";GenJnlBatchCode){}
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
                Image=Setup;
                trigger OnAction();
                begin
                    Rec.SetupDefaults();
                    rec.Modify(FALSE);
                    CurrPage.Activate(true);
                end;
            }
            action(ProcessDownloadTest)
            {
                Caption='Process Download Test';
                Image=TestFile;
                Visible=false;
                trigger OnAction();
                var
                    IBMProcess:Codeunit"NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessDownloadTest();
                end;
            }
            action(ProcessImportIFBAT)
            {
                Caption='Test importing batch file';
                Visible=false;
                trigger OnAction();
                var
                    IBMProcess:Codeunit"NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessImportIFBATTest();
                end;
            }
            action(ProcessExportIFRET)
            {
                Caption='Test exporting return file';
                Visible=false;
                trigger OnAction();
                var
                    IBMProcess:Codeunit"NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessExportIFRETTest();
                end;
            }
            action(ProcessUploadTest)
            {
                Caption='Process Upload Test';
                Image=TestFile;
                Visible=false;
                trigger OnAction();
                var 
                    IBMProcess:Codeunit"NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessUploadTest();
                end;
            }
            action(ClearTransactionEntries)
            {
                Caption='DEBUG: Clear Transactions';
                Visible=false;
                trigger OnAction();
                var
                    tranactionEntry:Record"NAC.IBMNAV.TransactionEntry";
                begin
                    tranactionEntry.deleteall(false);
                    Message('Entries have been cleared.');
                end;
            }
            action(ProcessManualTest)
            {
                Caption='Process Manual Integration';
                Image=Post;
                Promoted=true;
                PromotedIsBig=true;
                trigger OnAction();
                var
                    iBMProcess:Codeunit"NAC.IBMNAV.Process";
                begin
                    iBMProcess.Code();
                end;
            }
            action(LockRecord)
            {
                Caption='Lock Record';
                Image=Lock;
                trigger OnAction()
                begin
                    Rec.Locked := true;
                    Modify(false);
                    CurrPage.Editable(rec.Locked);
                end;
            }
            action(UnLockRecord)
            {
                Caption='Unlock Record';
                Image=ReOpen;
                trigger OnAction()
                begin
                    Rec.Locked := false;
                    Modify(false);
                    CurrPage.Editable(rec.Locked);
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

        CurrPage.Editable(rec.Locked);
    end;    
}