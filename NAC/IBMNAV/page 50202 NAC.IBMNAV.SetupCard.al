

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
                Caption='General';
                field("Data Staging Path";DataStagingPath)
                {
                }
                field("Data Definition Path";DataDefinitionPath) 
                {
                }
                field("Data Batch FileName";DataBatchFileName)
                {
                }
                field("Data Response FileName";DataResponseFileName)
                {
                }
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
                trigger OnAction();
                var
                    IBMProcess:Codeunit"NAC.IBMNAV.Process";
                begin
                    IBMProcess.ProcessDownloadTest();
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