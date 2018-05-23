
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

    /// This is just a test function and can be removed later
    procedure ProcessExportIFRETTest();
    var
        IFRETExport:XmlPort"NAC.IBMNAV.IFRETXMLP";
        txtOutStream:OutStream;
        blobHelper:Record"NAC.IBMNAV.ProcessBlob";
    begin
        IBMNAVSetup.get;
        IBMNAVSetup.TestField(DataStagingPath);
        IBMNAVSetup.TestField(DataStagingResponseFileName);

        if blobHelper.get() = false then begin
            blobHelper.init;
            blobHelper.Insert(false);
        end;

        blobHelper.CalcFields(TempBlob);
        blobHelper.TempBlob.CreateOutStream(txtOutStream);
        IFRETExport.SetDestination(txtOutStream);
        IFRETExport.Export();
        blobHelper.Modify(FALSE);
        blobHelper.ExportToServerFile(IBMNAVSetup.DataStagingPath + '\' + IBMNAVSetup.DataStagingResponseFileName,true);

        blobHelper.get();
        blobHelper.Delete(false);
    end;


    /// This is just a test function and can be removed later
    procedure ProcessImportIFBATTest();
    var
        IFBATImport:XmlPort"NAC.IBMNAV.IFBATXMLP";
        txtInStream:InStream;
        blobHelper:Record"NAC.IBMNAV.ProcessBlob";
    begin
        IBMNAVSetup.Get;
        IBMNAVSetup.TestField(DataStagingPath);
        IBMNAVSetup.TestField(DataStagingBatchFileName);

        if blobHelper.get() = false then begin
            blobHelper.Init;
            blobHelper.Insert(false);
        end;
        
        blobHelper.ImportFromServerFile(IBMNAVSetup.DataStagingPath + '\' + IBMNAVSetup.DataStagingBatchFileName);
        blobHelper.get();
        blobHelper.CalcFields(TempBlob);
        blobHelper.TempBlob.CreateInStream(txtInStream);

        IFBATImport.SetSource(txtInStream);
        IFBATImport.Import();

        blobHelper.Delete(FALSE);
        
        Message('complete');
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