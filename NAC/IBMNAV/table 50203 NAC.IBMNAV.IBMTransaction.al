
table 50203 "NAC.IBMNAV.IBMTransaction"
{

    fields
    {
        field(1;Code;Code[10])
        {
        }
        field(10;Description;Text[50])
        {
        }
        field(20;Blocked;Boolean)
        {
            
        }
    }

    keys
    {
        key(PK;Code)
        {
            Clustered = true;
        }
    }

    procedure SetupDefaults();
    var
        IBMTransactionCode : Record "NAC.IBMNAV.IBMTransaction";
    begin
        /// This procedure will setup all the default codes used for integrating transactions.

        /// ToDo: Add the additional codes here
        IBMTransactionCode.Init;
        IBMTransactionCode.Code := 'POPI';
        IBMTransactionCode.Description := 'Supplier Invoice in AMASIS';
        IBMTransactionCode.Blocked := false;
        if IBMTransactionCode.Insert(FALSE) = false then begin end;


    end;
}