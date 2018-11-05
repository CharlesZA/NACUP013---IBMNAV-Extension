/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50207 "NAC.IBMNAV.RateSync"
{
    Description = 'This codeunit runs the integration exchange rate sync.';
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
        DownloadDataFromIBM();
        PrepareNAVSendAndRecieveTables();
        ImportDownloadedDataIntoNAV();
        UpdateExchangeRates();

        CloseDialog();
    end;

    local procedure UpdateExchangeRates()
    begin
        // 3. Loop through and update participating companies.
    end;

    local procedure ImportDownloadedDataIntoNAV()
    var
        iFXRATEImport: XmlPort "NAC.IBMNAV.IFXRATEXMLP";
        txtInStream: InStream;
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
        txtIFBATID: Code[10];
    begin
        UpdateDialog('Importing Downloaded IBM Data in NAV');
        txtIFBATID := 'IFXRATE';
        IF processBlob.Get(txtIFBATID) then processBlob.Delete(FALSE);
        processBlob.init;
        processBlob.PrimaryKey := txtIFBATID;
        processBlob.Insert(false);

        processBlob.ImportFromServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFXRateDataStagingFileName);
        processBlob.get(txtIFBATID);
        processBlob.CalcFields(TempBlob);
        processBlob.TempBlob.CreateInStream(txtInStream);

        iFXRATEImport.SetSource(txtInStream);
        iFXRATEImport.Import();

        processBlob.Delete(FALSE);
    end;


    local procedure PrepareNAVSendAndRecieveTables()
    var
        iFXRATE: Record "NAC.IBMNAV.IFXRATE";
    begin
        iFXRATE.DeleteAll(false);
    end;


    local procedure DownloadDataFromIBM()
    begin
        UpdateDialog('Downloading Data from IBM');
        if dataTransfer.DataTransfer_Download(iBMNAVSetup.DataDefinitionPath + '\' + iBMNAVSetup.IFXRateDataDefinitionFileName) then begin
            /// Success
        end
        else begin
            /// Fail
            ERROR('Unable to download file from IBM Server.')
        end;
    end;


    /// This procedure makes sure that server staging files for this company have been removed. 
    local procedure CleanUpStagingFiles()
    var
        processBlob: Record "NAC.IBMNAV.ProcessBlob";
    begin
        UpdateDialog('Cleaning Up Staging Files');
        processBlob.EraseServerFile(iBMNAVSetup.DataStagingPath + '\' + iBMNAVSetup.IFXRateDataStagingFileName);
    end;


    /// This procedures tests setup fields
    local procedure VerifyIBMNAVSetup()
    begin
        UpdateDialog('Verifying Setup Information');
        iBMNAVSetup.GET;
        /// Data Definitions
        /// *ToDo: Add a check to see if these file actually exist on the server.
        iBMNAVSetup.TestField(DataDefinitionPath);
        iBMNAVSetup.TestField(IFXRateDataDefinitionFileName);
        /// Staging
        iBMNAVSetup.TestField(IFXRateDataStagingFileName);
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