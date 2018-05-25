/// This codeunit is called to posted batch information received from IBM. 
///
/// Its job is to post information in table 50205 NAC.IBMNAV.IFBAT to the general ledger
/// as well as write return information back to NAC.IBMNAV.IFRET
///
/// NOTE: This codeunit has commits in it.

codeunit 50203 "NAC.IBMNAV.Posting"
{
    var
        IFRET:Record"NAC.IBMNAV.IFRET";
        IFBAT:Record"NAC.IBMNAV.IFBAT";
        genJnlLine:Record"Gen. Journal Line";
        dialogWindow:Dialog;


    trigger OnRun()
    begin
        Code();
    end;

    local procedure Code()
    var
    begin
        OpenDialog();


        /// Loop through all the batch records
        /// Process, Post and Commit for each batch
        /// Write return information back on success or failure


        CloseDialog();
    end;

    /// Dialog for manual processing
    local procedure OpenDialog()
    begin
        if GuiAllowed() then begin
            dialogWindow.Open('NAC.IBMNAV Posting Activities\\Current Activity #1###############');
        end;
    end;
    local procedure UpdateDialog(progressText:Text[50])
    begin
        if GuiAllowed() then begin
            dialogWindow.Update(1,progressText);
        end;
    end;
    local procedure CloseDialog()
    begin
        if GuiAllowed() then begin
            dialogWindow.Close();
        end;
    end;

}