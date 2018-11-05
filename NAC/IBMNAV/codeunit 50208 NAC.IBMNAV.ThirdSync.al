/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50208 "NAC.IBMNAV.ThridSync"
{
    Description = 'This codeunit runs the integration for customer and vendor sync.';
    TableNo = "Job Queue Entry";

    var
        dataTransfer: Codeunit "NAC.IBMNAV.ACL";
        iBMNAVSetup: Record "NAC.IBMNAV.Setup";

        dialogWindow: Dialog;
        dialogWindowOpen: Boolean;

    trigger OnRun()
    begin
        OpenDialog();

        VerifyIBMNAVSetup();
        CleanUpStagingFiles();
        CalculateThirds();
        ExportUploadDataForIBM();
        UploadDataToIBM();

        CloseDialog();
    end;

    local procedure CalculateThirds()
    begin
        // 1. Collection and populate table IFXTHIRD with eligable customers and vendor accross companies
    end;

    local procedure UploadDataToIBM()
    begin
        UpdateDialog('Uploading Data to IBM');
        if dataTransfer.DataTransfer_Upload(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.IFXThirdDataDefinitionFileName) then begin
            /// Success
        end
        else begin
            /// Fail
            ERROR('Unable to Upload file to IBM Server.')
        end;
    end;


    local procedure ExportUploadDataForIBM()
    var
        iFTHIRDExport: XmlPort "NAC.IBMNAV.IFTHIRDXMLP";
        txtOutStream: OutStream;
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
        txtIFRETID: Code[10];
    begin
        UpdateDialog('Exporting Upload Data for IBM');
        txtIFRETID := 'IFTHIRD';
        IF processBlob.Get(txtIFRETID) then processBlob.Delete(FALSE);
        processBlob.init;
        processBlob.PrimaryKey := txtIFRETID;
        processBlob.Insert(false);

        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateOutStream(txtOutStream);
        iFTHIRDExport.SetDestination(txtOutStream);
        iFTHIRDExport.Export();
        processBlob.Modify(FALSE);
        processBlob.ExportToServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFXThirdDataResponseFileName, true);

        processBlob.get(txtIFRETID);
        processBlob.Delete(false);
    end;


    /// This procedure makes sure that server staging files for this company have been removed. 
    local procedure CleanUpStagingFiles()
    var
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
    begin
        UpdateDialog('Cleaning Up Staging Files');
        processBlob.EraseServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFXThirdDataResponseFileName);
    end;


    /// This procedures tests setup fields
    local procedure VerifyIBMNAVSetup()
    begin
        UpdateDialog('Verifying Setup Information');
        iBMNAVSetup.GET;
        /// Data Definitions
        /// *ToDo: Add a check to see if these file actually exist on the server.
        iBMNAVSetup.TestField(DataDefinitionPath);
        iBMNAVSetup.TestField(IFXThirdDataDefinitionFileName);
        /// Staging
        iBMNAVSetup.TestField(DataStagingPath);
        iBMNAVSetup.TestField(IFXThirdDataResponseFileName);
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

    local procedure UpdateDialog(progressText: Text[50])
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen then begin
                dialogWindow.Update(1, progressText);
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

}