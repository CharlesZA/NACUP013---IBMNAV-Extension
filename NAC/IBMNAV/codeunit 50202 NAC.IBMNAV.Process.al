/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50202 "NAC.IBMNAV.Process"
{
    Description = 'This codeunit runs the integration process.';
    TableNo= "Job Queue Entry";

    var
        dataTransfer :Codeunit "NAC.IBMNAV.ACL";
        iBMNAVSetup:Record"NAC.IBMNAV.Setup";

        dialogWindow:Dialog;
        dialogWindowOpen:Boolean;
        

    trigger OnRun();
    begin
        Code();
    end;

    procedure Code()
    begin
        OpenDialog();
        
        VerifyIBMNAVSetup();
        CleanUpStagingFiles();
        DownloadDataFromIBM();
        PrepareNAVSendAndRecieveTables();
        ImportDownloadedDataIntoNAV();


        /// COMMIT POINT :: Batches are commited as processed
        Commit();


        Codeunit.Run(Codeunit::"NAC.IBMNAV.Posting");


        /// COMMIT POINT :: Batches are commited as processed
        Commit();


        ExportUploadDataForIBM();
        UploadDataToIBM();
        //CleanUpStagingFiles();    /// This is commented out for debugging purposes.

        CloseDialog();
    end;

    local procedure PrepareNAVSendAndRecieveTables()
    var
        iFRET:Record"NAC.IBMNAV.IFRET";
        iFBAT:Record"NAC.IBMNAV.IFBAT";
    begin
        iFBAT.DeleteAll(false);
        iFRET.DeleteAll(false);
    end;


    /// Dialog for manual processing
    local procedure OpenDialog()
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen = false then begin
                dialogWindow.Open('Processing NAC.IBMNAV\\Current Activity #1###############');
                dialogWindowOpen := true;
            end;
        end;
    end;
    local procedure UpdateDialog(progressText:Text[50])
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen then begin
                dialogWindow.Update(1,progressText);
            end;
        end;
    end;
    local procedure CloseDialog()
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen then begin
                dialogWindow.Close();
                dialogWindowOpen := false;
            end;
        end;
    end;

    /// This procedure makes sure that server staging files for this company have been removed. 
    local procedure CleanUpStagingFiles()
    var
        processBlob:Record"NAC.IBMNAV.ProcessBlob";
    begin
        UpdateDialog('Cleaning Up Staging Files');
        processBlob.EraseServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.DataStagingBatchFileName);
        processBlob.EraseServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.DataStagingResponseFileName);
    end;

    local procedure UploadDataToIBM()
    begin
        UpdateDialog('Uploading Data to IBM');
        if dataTransfer.DataTransfer_Upload(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.DataDefinitionResponseFileName) then begin
            /// Success
        end            
        else begin
            /// Fail
        end;
    end;

    local procedure ExportUploadDataForIBM()
    var
        iFRETExport:XmlPort"NAC.IBMNAV.IFRETXMLP";
        txtOutStream:OutStream;
        processBlob:Record"NAC.IBMNAV.ProcessBlob";
        txtIFRETID:Code[10];
    begin
        UpdateDialog('Exporting Upload Data for IBM');
        txtIFRETID := 'IFRET_DATA';
        IF processBlob.Get(txtIFRETID) then processBlob.Delete(FALSE);
        processBlob.init;
        processBlob.PrimaryKey := txtIFRETID;
        processBlob.Insert(false);

        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateOutStream(txtOutStream);
        iFRETExport.SetDestination(txtOutStream);
        iFRETExport.Export();
        processBlob.Modify(FALSE);
        processBlob.ExportToServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.DataStagingResponseFileName,true);

        processBlob.get(txtIFRETID);
        processBlob.Delete(false);
    end;

    local procedure ImportDownloadedDataIntoNAV()
    var
        iFBATImport:XmlPort"NAC.IBMNAV.IFBATXMLP";
        txtInStream:InStream;
        processBlob:Record"NAC.IBMNAV.ProcessBlob";
        txtIFBATID:Code[10];
    begin
        UpdateDialog('Importing Downloaded IBM Data in NAV');
        txtIFBATID := 'IFBAT_DATA';
        IF processBlob.Get(txtIFBATID) then processBlob.Delete(FALSE);
        processBlob.init;
        processBlob.PrimaryKey := txtIFBATID;
        processBlob.Insert(false);
        
        processBlob.ImportFromServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.DataStagingBatchFileName);
        processBlob.get(txtIFBATID);
        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateInStream(txtInStream);

        iFBATImport.SetSource(txtInStream);
        iFBATImport.Import();

        processBlob.Delete(FALSE);        
    end;

    local procedure DownloadDataFromIBM()
    begin
        UpdateDialog('Downloading Data from IBM');
        if dataTransfer.DataTransfer_Download(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.DataDefinitionBatchFileName) then begin
            /// Success
        end    
        else begin
            /// Fail
        end;
    end;

    /// This procedures tests setup fields
    local procedure VerifyIBMNAVSetup()
    begin
        UpdateDialog('Verifying Setup Information');
        iBMNAVSetup.GET;
        /// Data Definitions
        /// *ToDo: Add a check to see if these file actually exist on the server.
        iBMNAVSetup.TestField(DataDefinitionPath);
        iBMNAVSetup.TestField(DataDefinitionBatchFileName);
        iBMNAVSetup.TestField(DataDefinitionResponseFileName);
        /// Staging
        iBMNAVSetup.TestField(DataStagingPath);
        iBMNAVSetup.TestField(DataStagingResponseFileName);
        iBMNAVSetup.TestField(DataStagingBatchFileName);
        /// Posting
        iBMNAVSetup.TestField(GenJnlTemplate);
        iBMNAVSetup.TestField(GenJnlBatchCode);
    end;

    /// This is just a test function and can be removed later
    procedure ProcessExportIFRETTest();
    var
        iFRETExport:XmlPort"NAC.IBMNAV.IFRETXMLP";
        txtOutStream:OutStream;
        processBlob:Record"NAC.IBMNAV.ProcessBlob";
    begin
        iBMNAVSetup.get();
        VerifyIBMNAVSetup();

        if processBlob.get() = false then begin
            processBlob.init;
            processBlob.Insert(false);
        end
        else begin
            processBlob.Delete(false);
            processBlob.Init;
            processBlob.Insert(false);
        end;

        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateOutStream(txtOutStream);
        iFRETExport.SetDestination(txtOutStream);
        iFRETExport.Export();
        processBlob.Modify(FALSE);
        processBlob.ExportToServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.DataStagingResponseFileName,true);

        processBlob.get();
        processBlob.Delete(false);

        Message('complete');
    end;


    /// This is just a test function and can be removed later
    procedure ProcessImportIFBATTest();
    var
        iFBATImport:XmlPort"NAC.IBMNAV.IFBATXMLP";
        txtInStream:InStream;
        processBlob:Record"NAC.IBMNAV.ProcessBlob";
    begin
        VerifyIBMNAVSetup();

        if processBlob.get() = false then begin
            processBlob.Init;
            processBlob.Insert(false);
        end
        else begin
            processBlob.Delete(false);
            processBlob.init;
            processBlob.Insert(false);
        end;
        
        processBlob.ImportFromServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.DataStagingBatchFileName);
        processBlob.get();
        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateInStream(txtInStream);

        iFBATImport.SetSource(txtInStream);
        iFBATImport.Import();

        processBlob.Delete(FALSE);
        
        
        Message('complete');
    end;

    /// This is just a test function and can be removed later
    procedure ProcessDownloadTest();
    begin
        iBMNAVSetup.get;
        VerifyIBMNAVSetup();

        if dataTransfer.DataTransfer_Download(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.DataDefinitionBatchFileName) then
            Message('complete')
        else
            Message('something went amiss');
        
    end;

    /// This is just a test function and can be removed later
    procedure ProcessUploadTest();
    begin
        iBMNAVSetup.get;
        VerifyIBMNAVSetup();

        if dataTransfer.DataTransfer_Upload(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.DataDefinitionResponseFileName) then
            Message('complete')
        else
            Message('something went amiss');
        
    end;        
}