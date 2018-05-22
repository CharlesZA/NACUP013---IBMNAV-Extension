
codeunit 50202 "NAC.IBMNAV.Process"
{
    Description = 'This codeunit runs the integration process.';
    TableNo= "Job Queue Entry";

    var
        dataTransfer :Codeunit "NAC.IBMNAV.ACL";
        IBMNAVSetup:Record"NAC.IBMNAV.Setup";
        

    trigger OnRun();
    begin
        
    end;

    procedure ProcessDownloadTest();
    var
        
    begin
        IBMNAVSetup.get;
        IBMNAVSetup.TestField(IBMNAVSetup.DataDefinitionBatchFileName);
        IBMNAVSetup.TestField(DataStagingPath);
        IBMNAVSetup.TestField(DataDefinitionPath);

        //dataTransfer.DataTransfer_Download(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataBatchFileName);

        if dataTransfer.DataTransfer_Download(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataDefinitionBatchFileName) then
            Message('complete')
        else
            Message('something went amiss');
        
    end;

    procedure ProcessUploadTest();
    var
        
    begin
        IBMNAVSetup.get;
        IBMNAVSetup.TestField(IBMNAVSetup.DataDefinitionResponseFileName);
        IBMNAVSetup.TestField(DataStagingPath);
        IBMNAVSetup.TestField(DataDefinitionPath);

        //dataTransfer.DataTransfer_Download(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataBatchFileName);

        if dataTransfer.DataTransfer_Upload(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataDefinitionResponseFileName) then
            Message('complete')
        else
            Message('something went amiss');
        
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