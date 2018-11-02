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

        // 1. Collection and populate table IFXRATE with eligable customers and vendor accross companies

        // 2. Export table to submit to IBM

        // 3. Submit

        // 4. Clean on success.

        CloseDialog();
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