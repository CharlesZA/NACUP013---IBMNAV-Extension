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
        transactionType:Record"NAC.IBMNAV.TransactionType";
        dialogWindow:Dialog;


    trigger OnRun()
    begin
        Code();
    end;

    local procedure Code()
    var
        firstLine:Boolean;
        transactionId:Integer;
        tempIFBAT:Record"NAC.IBMNAV.IFBAT"temporary;
        tempIFRET:Record"NAC.IBMNAV.IFRET"temporary;
        subString:Text;
    begin
        OpenDialog();

        subString := 'Processing %1 %2 %3';
        firstLine := true;

        if IFBAT.FindFirst() then begin
            repeat

                if firstLine then begin
                    firstLine := false;
                    transactionId := IFBAT.ID;
                end;

                UpdateDialog(strsubstno(subString,IFBAT.ID,IFBAT.TID,IFBAT.SEQ));

                if transactionId <> IFBAT.ID then begin
                    PostBatchInformation(tempIFBAT,tempIFRET);
                    tempIFBAT.DeleteAll(false);
                    tempIFRET.DeleteAll(false);

                    tempIFBAT.Init();
                    tempIFBAT.TransferFields(IFBAT);
                    tempIFBAT.insert(FALSE);

                    tempIFRET.Init();
                    tempIFRET.ID := tempIFBAT.ID;
                    tempIFRET.TID := tempIFBAT.TID;
                    tempIFRET.SEQ := tempIFBAT.SEQ;
                    tempIFRET.RESDS := 'NOT PROCESSED';
                    tempIFRET.Insert(FALSE);

                end
                else begin
                    tempIFBAT.Init();
                    tempIFBAT.TransferFields(IFBAT);
                    tempIFBAT.insert(FALSE);

                    tempIFRET.Init();
                    tempIFRET.ID := tempIFBAT.ID;
                    tempIFRET.TID := tempIFBAT.TID;
                    tempIFRET.SEQ := tempIFBAT.SEQ;
                    tempIFRET.RESDS := 'NOT PROCESSED';
                    tempIFRET.Insert(FALSE);
                end;
            Until IFBAT.next = 0;

            PostBatchInformation(tempIFBAT,tempIFRET);    /// Last Batch
            tempIFBAT.DeleteAll(false);
            tempIFRET.DeleteAll(false);
        end;

        CloseDialog();
    end;

    local procedure PostBatchInformation(var tempIFBAT:Record"NAC.IBMNAV.IFBAT"temporary; var tempIFRET:Record"NAC.IBMNAV.IFRET"temporary)
    var
        dataChecksPassed:Boolean; 
        dataCheckFailDescription:Text[128]; 
    begin
        /// Save Temp History records to the transaction entry table.
        /// Clear Temp records.
        /// Pass or Fail write temp records to IFRET
        tempIFBAT.FindSet();
        repeat
            tempIFRET.get(tempIFBAT.ID,tempIFBAT.TID,tempIFBAT.SEQ);

            /// Checking Data for Errors
            dataChecksPassed := true;
            if transactionType.get(IFBAT.TID) then begin
                if transactionType.Blocked then begin
                    /// This is a fail
                    dataCheckFailDescription := 'TRANSACTION TYPE IS BLOCKED IN NAV';
                    dataChecksPassed := false;
                end;
            end
            else begin
                /// This is a fail
                dataCheckFailDescription := 'TRANSACTION TYPE IS NOT SETUP IN NAV';
                dataChecksPassed := false;
            end;

            /// Write to general journal line here.....
            

            if dataChecksPassed then begin
                tempIFRET.RESCD := 'SUCCESS';
                tempIFRET.RESDS := '';
                tempIFRET.DATE := Today();
                tempIFRET.TIME := Time();
                tempIFRET.Modify(false);
            end;
        until (tempIFBAT.next = 0) OR (dataChecksPassed = false);

        if dataChecksPassed = false then begin 
            tempIFRET.RESDS := dataCheckFailDescription;
            tempIFRET.Modify(false);
            tempIFRET.ModifyAll(RESCD,'FAIL',false);
            tempIFRET.ModifyAll(DATE,today(),false);
            tempIFRET.ModifyAll(TIME,Time(),false);
        end;

        if dataChecksPassed then begin

            /// Post the batch code here
            
        end;

        WriteFinalResponseInformation(tempIFRET);
    end;

    local procedure WriteFinalResponseInformation(var tempIFRET:Record"NAC.IBMNAV.IFRET"temporary)
    begin
        if tempIFRET.IsEmpty() = false then begin
            tempIFRET.FindSet();
            repeat
                IFRET.init;
                IFRET.TransferFields(tempIFRET);
                IFRET.Insert();
            until tempIFRET.next = 0;
        end;
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