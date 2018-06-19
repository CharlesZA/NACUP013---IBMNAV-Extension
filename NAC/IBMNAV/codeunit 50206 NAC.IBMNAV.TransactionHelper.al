/// NACUP013 - Business Integrations

/// Created codeunit to assist with incoming transaction data when creating general journal lines.codeunit


codeunit 50206 "NAC.IBMNAV.TransactionHelper"
{
    Description = 'Helper codeunit for processing general journal lines';
    trigger OnRun()
    begin
        
    end;

    procedure SetAccType(accType:Code[10]):Code[20]
    begin
        /// Integration specific stuff
        if accType = 'GL' then exit('G/L Account');
        if accType = 'CUSTOMER' then exit('Customer');
        if accType = 'VENDOR' then exit('Vendor');

        exit(accType);
    end;

    
}