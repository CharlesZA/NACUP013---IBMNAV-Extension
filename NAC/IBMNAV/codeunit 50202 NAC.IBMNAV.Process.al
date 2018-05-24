
codeunit 50202 "NAC.IBMNAV.Process"
{
    Description = 'This codeunit runs the integration process.';
    TableNo= "Job Queue Entry";

    var
        dataTransfer :Codeunit "NAC.IBMNAV.ACL";
        IBMNAVSetup:Record"NAC.IBMNAV.Setup";
        

    trigger OnRun();
    begin
        Code();
    end;

    procedure Code()
    begin
        IBMNAVSetup.get;
        VerifyIBMNAVSetup();
        CleanUpStagingFiles();
        DownloadDataFromIBM();
        ImportDownloadedDataIntoNAV();

        /// COMMIT POINT :: Batches are commited as processed


        /// Go through transaction mini batches and post


        /// COMMIT POINT :: Batches are commited as processed

        ExportUploadDataForIBM();
        UploadDataToIBM();
        CleanUpStagingFiles();
    end;

    /// This procedure makes sure that server staging files have been removed. 
    local procedure CleanUpStagingFiles()
    begin
        /// ToDo: Add Server clean up code here...
    end;

    local procedure UploadDataToIBM()
    begin
        if dataTransfer.DataTransfer_Upload(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataDefinitionResponseFileName) then begin
            /// Success
        end            
        else begin
            /// Fail
        end;
    end;

    local procedure ExportUploadDataForIBM()
    var
        IFRETExport:XmlPort"NAC.IBMNAV.IFRETXMLP";
        txtOutStream:OutStream;
        ProcessBlob:Record"NAC.IBMNAV.ProcessBlob";
        txtIFRETID:Code[10];
    begin
        txtIFRETID := 'IFRET_DATA';
        IF ProcessBlob.Get(txtIFRETID) then ProcessBlob.Delete(FALSE);
        ProcessBlob.init;
        ProcessBlob.PrimaryKey := txtIFRETID;
        ProcessBlob.Insert(false);

        ProcessBlob.CalcFields(TempBlob);
        ProcessBlob.TempBlob.CreateOutStream(txtOutStream);
        IFRETExport.SetDestination(txtOutStream);
        IFRETExport.Export();
        ProcessBlob.Modify(FALSE);
        ProcessBlob.ExportToServerFile(IBMNAVSetup.DataStagingPath + '\' + IBMNAVSetup.DataStagingResponseFileName,true);

        ProcessBlob.get(txtIFRETID);
        ProcessBlob.Delete(false);
    end;

    local procedure ImportDownloadedDataIntoNAV()
    var
        IFBATImport:XmlPort"NAC.IBMNAV.IFBATXMLP";
        txtInStream:InStream;
        ProcessBlob:Record"NAC.IBMNAV.ProcessBlob";
        txtIFBATID:Code[10];
    begin
        txtIFBATID := 'IFBAT_DATA';
        IF ProcessBlob.Get(txtIFBATID) then ProcessBlob.Delete(FALSE);
        ProcessBlob.init;
        ProcessBlob.PrimaryKey := txtIFBATID;
        ProcessBlob.Insert(false);
        
        ProcessBlob.ImportFromServerFile(IBMNAVSetup.DataStagingPath + '\' + IBMNAVSetup.DataStagingBatchFileName);
        ProcessBlob.get(txtIFBATID);
        ProcessBlob.CalcFields(TempBlob);
        ProcessBlob.TempBlob.CreateInStream(txtInStream);

        IFBATImport.SetSource(txtInStream);
        IFBATImport.Import();

        ProcessBlob.Delete(FALSE);        
    end;

    local procedure DownloadDataFromIBM()
    begin
        if dataTransfer.DataTransfer_Download(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataDefinitionBatchFileName) then begin
            /// Success
        end    
        else begin
            /// Fail
        end;
    end;

    /// This procedures tests setup fields
    local procedure VerifyIBMNAVSetup()
    begin
        /// Data Definitions
        /// *ToDo: Add a check to see if these file actually exist on the server.
        IBMNAVSetup.TestField(DataDefinitionPath);
        IBMNAVSetup.TestField(DataDefinitionBatchFileName);
        IBMNAVSetup.TestField(DataDefinitionResponseFileName);
        /// Staging
        IBMNAVSetup.TestField(DataStagingPath);
        IBMNAVSetup.TestField(DataStagingResponseFileName);
        IBMNAVSetup.TestField(DataStagingBatchFileName);
    end;

    /// This is just a test function and can be removed later
    procedure ProcessExportIFRETTest();
    var
        IFRETExport:XmlPort"NAC.IBMNAV.IFRETXMLP";
        txtOutStream:OutStream;
        ProcessBlob:Record"NAC.IBMNAV.ProcessBlob";
    begin
        IBMNAVSetup.get();
        VerifyIBMNAVSetup();

        if ProcessBlob.get() = false then begin
            ProcessBlob.init;
            ProcessBlob.Insert(false);
        end
        else begin
            ProcessBlob.Delete(false);
            ProcessBlob.Init;
            ProcessBlob.Insert(false);
        end;

        ProcessBlob.CalcFields(TempBlob);
        ProcessBlob.TempBlob.CreateOutStream(txtOutStream);
        IFRETExport.SetDestination(txtOutStream);
        IFRETExport.Export();
        ProcessBlob.Modify(FALSE);
        ProcessBlob.ExportToServerFile(IBMNAVSetup.DataStagingPath + '\' + IBMNAVSetup.DataStagingResponseFileName,true);

        ProcessBlob.get();
        ProcessBlob.Delete(false);

        Message('complete');
    end;


    /// This is just a test function and can be removed later
    procedure ProcessImportIFBATTest();
    var
        IFBATImport:XmlPort"NAC.IBMNAV.IFBATXMLP";
        txtInStream:InStream;
        ProcessBlob:Record"NAC.IBMNAV.ProcessBlob";
    begin
        VerifyIBMNAVSetup();

        if ProcessBlob.get() = false then begin
            ProcessBlob.Init;
            ProcessBlob.Insert(false);
        end
        else begin
            ProcessBlob.Delete(false);
            ProcessBlob.init;
            ProcessBlob.Insert(false);
        end;
        
        ProcessBlob.ImportFromServerFile(IBMNAVSetup.DataStagingPath + '\' + IBMNAVSetup.DataStagingBatchFileName);
        ProcessBlob.get();
        ProcessBlob.CalcFields(TempBlob);
        ProcessBlob.TempBlob.CreateInStream(txtInStream);

        IFBATImport.SetSource(txtInStream);
        IFBATImport.Import();

        ProcessBlob.Delete(FALSE);
        
        
        Message('complete');
    end;

    /// This is just a test function and can be removed later
    procedure ProcessDownloadTest();
    var
        
    begin
        IBMNAVSetup.get;
        VerifyIBMNAVSetup();

        if dataTransfer.DataTransfer_Download(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataDefinitionBatchFileName) then
            Message('complete')
        else
            Message('something went amiss');
        
    end;

    /// This is just a test function and can be removed later
    procedure ProcessUploadTest();
    var
        
    begin
        IBMNAVSetup.get;
        VerifyIBMNAVSetup();

        if dataTransfer.DataTransfer_Upload(IBMNAVSetup.DataDefinitionPath + '\' + IBMNAVSetup.DataDefinitionResponseFileName) then
            Message('complete')
        else
            Message('something went amiss');
        
    end;        
}