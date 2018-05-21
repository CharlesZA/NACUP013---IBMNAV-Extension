
codeunit 50202 "NAC.IBMNAV.Process"
{
    Description = 'This codeunit runs the integration process.';
    TableNo= "Job Queue Entry";

    var
        dataTransfer :Codeunit "NAC.IBMNAV.ACL";
        

    trigger OnRun();
    begin
        
    end;


    local procedure ProcessDataTransferFromIBM();
    var
        
    begin
        
    end;

    local procedure ProcessDataTransferToIBM();
    var
        
    begin
        
    end;
        
}