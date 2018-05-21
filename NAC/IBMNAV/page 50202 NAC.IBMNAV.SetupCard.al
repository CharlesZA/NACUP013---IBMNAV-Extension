

page 50202 "NAC.IBMNAV.SetupCard"
{
    PageType = Card;
    SourceTable = "NAC.IBMNAV.Setup";
    DeleteAllowed = false;
//    InsertAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption='General';
                field("Data Batch FileName";DataBatchFileName)
                {
                    
                    
                }
                field("Data Response FileName";DataResponseFileName)
                {

                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        if Rec.get() = false then begin
            Rec.INIt;
            Rec.Insert(FALSE);
        end;

    end;    
}