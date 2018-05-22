
table 50203 "NAC.IBMNAV.IBMTransactionType"
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
        AddSetupDefault('POREC','Purchase Receipt',TRUE);
        AddSetupDefault('POPI','Purchase Invoice',FALSE);
        AddSetupDefault('ROSCRAP','Repair Order - Scrapping',FALSE);
        AddSetupDefault('SOPI','Service Order',FALSE);
        AddSetupDefault('LOPI','Exchange Order',FALSE);
        AddSetupDefault('CORERET','Return to Supplier - Core Return',FALSE);
        AddSetupDefault('SUPRET','Return to Supplier',FALSE);
        AddSetupDefault('XFEROUT','Transfer - OUT',FALSE);
        AddSetupDefault('XFERIN','Transfer - IN',FALSE);
        AddSetupDefault('STKADJ','Stock Adjustment',FALSE);
        AddSetupDefault('VALADJ','Stock Value Adjustment',FALSE);
        AddSetupDefault('SCRAP','Stock Scrapping',FALSE);
        AddSetupDefault('WRTOFF','Stock - Write Off',FALSE);
        AddSetupDefault('ACRRF','Receipt from Aircraft Removal',FALSE);
        AddSetupDefault('ISSGEN','Issue for Internal Needs',FALSE);
        AddSetupDefault('ISSMRO','Issue to Line Maintenance / Work Pack',FALSE);
        AddSetupDefault('DNU','Draw not Used',FALSE);
        AddSetupDefault('LRSCRP','Local Repair - Scrap',FALSE);
        AddSetupDefault('COEINV','Delivery Note - Sales',FALSE);
        AddSetupDefault('COECRD','Delivery Note - Credit',FALSE);
        AddSetupDefault('SUNINV','Sundry - Invoice',FALSE);
        AddSetupDefault('SUNCRD','Sundry - Credit',FALSE);
        AddSetupDefault('MROINV','MRO - Invoice',FALSE);
        AddSetupDefault('MROCRD','MRO - Credit',FALSE);
    end;

    local procedure AddSetupDefault(defaultCode:Code[10];defaultDescription:Text[50];blocked:Boolean);
    var
        IBMTransactionCode : Record "NAC.IBMNAV.IBMTransactionType";   
    begin
        IBMTransactionCode.Init;
        IBMTransactionCode.Code := defaultCode;
        IBMTransactionCode.Description := defaultDescription;
        IBMTransactionCode.Blocked := blocked;
        if IBMTransactionCode.Insert(FALSE) = false then begin end;
    end;
}