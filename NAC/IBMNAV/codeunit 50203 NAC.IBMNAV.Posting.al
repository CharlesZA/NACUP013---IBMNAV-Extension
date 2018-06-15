/// This codeunit is called to posted batch information received from IBM. 
///
/// Its job is to post information in table 50205 NAC.IBMNAV.IFBAT to the general ledger
/// as well as write return information back to NAC.IBMNAV.IFRET
///
/// NOTE: This codeunit has commits in it.

codeunit 50203 "NAC.IBMNAV.Posting"
{
    var
        iBMSetup:Record"NAC.IBMNAV.Setup";
        iFRET:Record"NAC.IBMNAV.IFRET";
        iFBAT:Record"NAC.IBMNAV.IFBAT";
        transactionType:Record"NAC.IBMNAV.TransactionType";
        transactionEntry:Record"NAC.IBMNAV.TransactionEntry";
        dialogWindow:Dialog;
        dialogWindowOpen:Boolean;


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

        if iFBAT.FindFirst() then begin
            repeat

                if firstLine then begin
                    firstLine := false;
                    transactionId := iFBAT.ID;
                end;

                UpdateDialog(strsubstno(subString,iFBAT.ID,iFBAT.TID,iFBAT.SEQ));

                if transactionId <> iFBAT.ID then begin
                    PostBatchInformation(tempIFBAT,tempIFRET);
                    tempIFBAT.DeleteAll(false);
                    tempIFRET.DeleteAll(false);

                    tempIFBAT.Init();
                    tempIFBAT.TransferFields(iFBAT);
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
                    tempIFBAT.TransferFields(iFBAT);
                    tempIFBAT.insert(FALSE);

                    tempIFRET.Init();
                    tempIFRET.ID := tempIFBAT.ID;
                    tempIFRET.TID := tempIFBAT.TID;
                    tempIFRET.SEQ := tempIFBAT.SEQ;
                    tempIFRET.RESDS := 'NOT PROCESSED';
                    tempIFRET.Insert(FALSE);
                end;

                transactionId := iFBAT.ID;
                
            Until iFBAT.next = 0;

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
        genJnlLine:Record"Gen. Journal Line";
        reasonCode:Code[10];
    begin

        /// Ensure the batch is clear
        iBMSetup.get;
        iBMSetup.TestField(GenJnlTemplate);
        iBMSetup.TestField(GenJnlBatchCode);
        genJnlLine.SetRange("Journal Template Name",iBMSetup.GenJnlTemplate);
        genJnlLine.SetRange("Journal Batch Name",iBMSetup.GenJnlBatchCode);
        genJnlLine.SetHideValidation(true);
        if genJnlLine.IsEmpty() = false then genJnlLine.DeleteAll(true);

        dataChecksPassed := true;
        reasonCode := 'SUCCESS';
        tempIFBAT.FindSet();
        repeat
            

            if dataChecksPassed then begin

                tempIFRET.get(tempIFBAT.ID,tempIFBAT.TID,tempIFBAT.SEQ);

                /// Checking Data for Errors
                if transactionType.get(iFBAT.TID) then begin
                    if transactionType.Blocked then begin
                        /// This is a fail
                        dataCheckFailDescription := 'TRANSACTION TYPE IS BLOCKED IN NAV';
                        dataChecksPassed := false;
                        reasonCode := 'FAIL';
                    end;
                end
                else begin
                    /// This is a fail
                    dataCheckFailDescription := 'TRANSACTION TYPE IS NOT SETUP IN NAV';
                    dataChecksPassed := false;
                    reasonCode := 'FAIL';
                end;

                /// check if transaction has already been posted. 
                IF dataChecksPassed then begin
                    if transactionEntry.get(tempIFBAT.ID,tempIFBAT.TID,tempIFBAT.SEQ) then begin
                        dataChecksPassed := false;
                        dataCheckFailDescription := 'TRANSACTION HAS ALREADY BEEN POSTED';
                        reasonCode := 'SUCCESS';
                    end;
                end;

                /// Write to general journal line here.....
                if dataChecksPassed then begin
                    commit;  /// This is here because of the way AL handles things unlike C\AL
                    if Codeunit.Run(Codeunit::"NAC.IBMNAV.InsertGenJnlLine",tempIFBAT) = FALSE then begin
                        if GetLastErrorText() <> '' then begin
                            dataChecksPassed := false;
                            reasonCode := 'FAIL';
                            dataCheckFailDescription := CopyStr(RemoveBadChars(GetLastErrorText()),1,128); /// Shortened to exclude carrage return
                            ClearLastError();
                        end;
                    end;
                end;
                

                if dataChecksPassed then begin
                    tempIFRET.RESCD := reasonCode;
                    tempIFRET.RESDS := '';
                    tempIFRET.DATE := Today();
                    tempIFRET.TIME := Time();
                    tempIFRET.Modify(false);
                end;

            end;
        until (tempIFBAT.next() = 0) or (dataChecksPassed = false);


        if dataChecksPassed then begin

            /// Post the batch code here
            iBMSetup.get;
            genJnlLine.SetRange("Journal Template Name",IBMSetup.GenJnlTemplate);
            genJnlLine.SetRange("Journal Batch Name",IBMSetup.GenJnlBatchCode);
            if genJnlLine.IsEmpty() = false then begin
                    genJnlLine.FindSet();
                    commit;
                    IF Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",genJnlLine) then begin
                        WriteTransactionHistoryInformation(tempIFBAT);
                        Commit; /// Ensures that duplicates cannot be processed
                    end
                    else begin
                        dataChecksPassed := false;
                        reasonCode := 'FAIL';
                        dataCheckFailDescription := CopyStr(RemoveBadChars(GetLastErrorText()),1,128);
                        ClearLastError();
                    end;
            end
            else begin
                dataChecksPassed := false;
                reasonCode := 'FAIL';
                dataCheckFailDescription := 'POST FAILED: NO JOURNALS CREATED';
            end;
        end;

        if dataChecksPassed = false then begin 
            tempIFRET.RESDS := dataCheckFailDescription;
            tempIFRET.Modify(false);
            tempIFRET.ModifyAll(RESCD,reasonCode,false);
            tempIFRET.ModifyAll(DATE,today(),false);
            tempIFRET.ModifyAll(TIME,Time(),false);
        end;       

        WriteFinalResponseInformation(tempIFRET);
    end;

    /// This function removes TAB, LF and CR from text. ie ErrorMessages
    local procedure RemoveBadChars(textWithBadChars:Text):Text
    var
        ch:text[3];
    begin
        ch[1] := 9; /// TAB
        ch[2] := 10; /// LF
        ch[3] := 13; /// CR
        Exit(DelChr(textWithBadChars,'=',ch));
    end;   

    local procedure WriteTransactionHistoryInformation(var tempIFBAT:Record"NAC.IBMNAV.IFBAT"temporary)
    begin
        if tempIFBAT.IsEmpty() = false then begin
            tempIFBAT.FindSet();
            repeat
                transactionEntry.Init();
                transactionEntry.TransferFields(tempIFBAT);
                transactionEntry.Insert();
            until tempIFBAT.Next = 0;
        end;
    end;

    local procedure WriteFinalResponseInformation(var tempIFRET:Record"NAC.IBMNAV.IFRET"temporary)
    begin
        if tempIFRET.IsEmpty() = false then begin
            tempIFRET.FindSet();
            repeat
                iFRET.init;
                iFRET.TransferFields(tempIFRET);
                iFRET.Insert();
            until tempIFRET.next = 0;
        end;
    end;

    /// Dialog for manual processing
    local procedure OpenDialog()
    begin
        if GuiAllowed() then begin
            if dialogWindowOpen = false then begin
                dialogWindow.Open('NAC.IBMNAV Posting Activities\\Current Activity #1###############');
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

}