

page 50202 "NAC.IBMNAV.SetupCard"
{
    PageType = Card;
    SourceTable = "NAC.IBMNAV.Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    Caption='NAC.IBMNAV Integration Setup Card';

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
                trigger OnAction();
                begin
                    Rec.SetupDefaults();
                    rec.Modify(FALSE);
                    CurrPage.Activate(true);
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