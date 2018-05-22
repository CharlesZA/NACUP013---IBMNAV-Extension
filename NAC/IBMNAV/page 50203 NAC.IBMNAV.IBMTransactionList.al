

page 50203 "NAC.IBMNAV.IBMTransactionList"
{
    PageType = List;
    SourceTable = "NAC.IBMNAV.IBMTransactionType";
    Editable = true;
    UsageCategory=Administration;
    Caption = 'NAC.IBMNAV IBM Transactions';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                    
                }
                field(Description;Description)
                {

                }
                field(Blocked;Blocked)
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
                    Rec.SetupDefaults(CompanyName);
                    CurrPage.Activate(true);
                end;
            }
        }
    }
}