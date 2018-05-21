
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
    begin
        /// This procedure will setup all the default codes used for integrating transactions.

        /// ToDo: Add the additional codes here
        AddSetupDefault('POPI','Supplier invoice from AMASIS',false);
        AddSetupDefault('SOPI','Customer invoice from AMASIS',false);
        //AddSetupDefault('POPI','Supplier invoice from AMASIS',false); // and so forth

    end;

    local procedure AddSetupDefault(defaultCode:Code[10];defaultDescription:Text[50];blocked:Boolean);
    var
        IBMTransactionCode : Record "NAC.IBMNAV.IBMTransaction";   
    begin
        IBMTransactionCode.Init;
        IBMTransactionCode.Code := defaultCode;
        IBMTransactionCode.Description := defaultDescription;
        IBMTransactionCode.Blocked := blocked;
        if IBMTransactionCode.Insert(FALSE) = false then begin end;
    end;
}