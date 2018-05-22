
table 50203 "NAC.IBMNAV.IBMTransactionType"
{
    //DataClassification=CustomerContent;
    DataPerCompany=true;
    Description='IBM Transaction that are supported for NAV posting';

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

    procedure SetupDefaults(companyName:Text[30]);
    var
    begin
        /// This procedure will setup all the default codes used for integrating transactions.
        AddSetupDefault('POREC','Purchase Receipt',TRUE,companyName);
        AddSetupDefault('POPI','Purchase Invoice',FALSE,companyName);
        AddSetupDefault('ROSCRAP','Repair Order - Scrapping',FALSE,companyName);
        AddSetupDefault('SOPI','Service Order',FALSE,companyName);
        AddSetupDefault('LOPI','Exchange Order',FALSE,companyName);
        AddSetupDefault('CORERET','Return to Supplier - Core Return',FALSE,companyName);
        AddSetupDefault('SUPRET','Return to Supplier',FALSE,companyName);
        AddSetupDefault('XFEROUT','Transfer - OUT',FALSE,companyName);
        AddSetupDefault('XFERIN','Transfer - IN',FALSE,companyName);
        AddSetupDefault('STKADJ','Stock Adjustment',FALSE,companyName);
        AddSetupDefault('VALADJ','Stock Value Adjustment',FALSE,companyName);
        AddSetupDefault('SCRAP','Stock Scrapping',FALSE,companyName);
        AddSetupDefault('WRTOFF','Stock - Write Off',FALSE,companyName);
        AddSetupDefault('ACRRF','Receipt from Aircraft Removal',FALSE,companyName);
        AddSetupDefault('ISSGEN','Issue for Internal Needs',FALSE,companyName);
        AddSetupDefault('ISSMRO','Issue to Line Maintenance / Work Pack',FALSE,companyName);
        AddSetupDefault('DNU','Draw not Used',FALSE,companyName);
        AddSetupDefault('LRSCRP','Local Repair - Scrap',FALSE,companyName);
        AddSetupDefault('COEINV','Delivery Note - Sales',FALSE,companyName);
        AddSetupDefault('COECRD','Delivery Note - Credit',FALSE,companyName);
        AddSetupDefault('SUNINV','Sundry - Invoice',FALSE,companyName);
        AddSetupDefault('SUNCRD','Sundry - Credit',FALSE,companyName);
        AddSetupDefault('MROINV','MRO - Invoice',FALSE,companyName);
        AddSetupDefault('MROCRD','MRO - Credit',FALSE,companyName);
    end;

    local procedure AddSetupDefault(defaultCode:Code[10];defaultDescription:Text[50];blocked:Boolean;companyName:Text[30]);
    var
        IBMTransactionCode : Record "NAC.IBMNAV.IBMTransactionType";   
    begin
        if companyName <> '' then IBMTransactionCode.ChangeCompany(companyName);
        IBMTransactionCode.Init;
        IBMTransactionCode.Code := defaultCode;
        IBMTransactionCode.Description := defaultDescription;
        IBMTransactionCode.Blocked := blocked;
        if IBMTransactionCode.Insert(FALSE) = false then begin end;
    end;
}