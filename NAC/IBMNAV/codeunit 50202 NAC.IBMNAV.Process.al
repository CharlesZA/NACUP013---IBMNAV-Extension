
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

        /// Verify Setups

        /// Download Data from IBM

        /// Save Data for this request into a table. 

        /// Go through transaction mini batches and post

        /// Create response file. 

        /// Send response back to IBM. 
            
    end;

    local procedure ProcessDataTransferToIBM();
    var
        
    begin
        
    end;
        
}