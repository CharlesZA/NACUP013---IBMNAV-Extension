

page 50203 "NAC.IBMNAV.IBMTransactionList"
{
    PageType = List;
    SourceTable = "NAC.IBMNAV.IBMTransaction";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                    
                }
            }
        }
        area(factboxes)
        {
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
                    CurrPage.Activate(true);
                end;
            }
        }
    }
}