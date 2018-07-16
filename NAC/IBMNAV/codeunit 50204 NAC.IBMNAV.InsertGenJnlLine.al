/// This codeunit used as a fail codeunit to insert general journal lines for NAC.IBMNAV 

codeunit 50204 "NAC.IBMNAV.InsertGenJnlLine"
{
    TableNo = "NAC.IBMNAV.IFBAT";
    var
        genJnlLine:Record"Gen. Journal Line";
        iBMNAVSetup:Record"NAC.IBMNAV.Setup";
        gLSetup:Record"General Ledger Setup";
        sourceCodeSetup:Record"Source Code Setup";
        transactionHelper:Codeunit"NAC.IBMNAV.TransactionHelper";
    trigger OnRun()
    begin
        iBMNAVSetup.get;
        gLSetup.get;
        sourceCodeSetup.get;

        genJnlLine.init;
        genJnlLine."Journal Template Name" := iBMNAVSetup.GenJnlTemplate;
        genJnlLine."Journal Batch Name" := iBMNAVSetup.GenJnlBatchCode;;
        genJnlLine."Line No." := rec.SEQ;
        genJnlLine.Insert;

        genJnlLine.SetHideValidation(true);

        genJnlLine."NAC.IBMNAV Sequence No." := rec.SEQ;
        genJnlLine."NAC.IBMNAV Transaction Code" := rec.TID;
        genJnlLine."NAC.IBMNAV Transaction No." := rec.ID;

        genJnlLine."Source Code" := sourceCodeSetup."NAC.IBMNAV";
        genJnlLine."System-Created Entry" := true;

        /// Add validation fields here.
        Evaluate(genJnlLine."Document Type",Rec.DOCTYP); 
        genJnlLine.validate("Document Type");

        genJnlLine.Validate("Document No.",rec.DOCNO);

        genJnlLine.Validate("Posting Date",rec.POSTDAT);
        genJnlLine.Validate("Document Date",rec.DOCDAT);

        Evaluate(genJnlLine."Account Type", transactionHelper.SetAccType(rec.ACCTYP));
        genJnlLine.Validate("Account Type");

        genJnlLine.Validate("Account No.",rec.ACCTNO);

        IF genJnlLine."Document Type" in [genJnlLine."Document Type"::"Credit Memo", genJnlLine."Document Type"::Invoice] then begin
            genJnlLine.Validate("External Document No.",rec.DOCNO);
        end;

        genJnlLine.Validate(Description,rec.TRND);

        if rec.CURR <> gLSetup."LCY Code" then begin
            genJnlLine.Validate("Currency Code",rec.CURR);
            genJnlLine.Validate("Currency Factor",rec.XRATE);
        end;

        genJnlLine.Validate(Amount,rec.VALUE);

        /// The VAT Product Posting Group       ----    May need to do something special here
        genJnlLine.Validate("VAT Prod. Posting Group",rec.VATGRP);


        genJnlLine.Modify();



        /// Dimensions
        if rec.DIM1 <> '' then if gLSetup."Shortcut Dimension 1 Code" <> '' then begin
            OnBeforeValidateDimCode(1,rec.DIM1);  
            genJnlLine.validate("Shortcut Dimension 1 Code",rec.DIM1);
        end;

        if rec.DIM2 <> '' then if gLSetup."Shortcut Dimension 2 Code" <> '' then begin
            OnBeforeValidateDimCode(2,rec.DIM2);
            genJnlLine.validate("Shortcut Dimension 2 Code",rec.DIM2);
        end;

        if rec.DIM3 <> '' then if gLSetup."Shortcut Dimension 3 Code" <> '' then  begin
            OnBeforeValidateDimCode(3,rec.DIM3);
            genJnlLine.ValidateShortcutDimCode(3,rec.DIM3);
        end;
        if rec.DIM4 <> '' then if gLSetup."Shortcut Dimension 4 Code" <> '' then begin
            OnBeforeValidateDimCode(4,rec.DIM4);
            genJnlLine.ValidateShortcutDimCode(4,rec.DIM3);
        end;
        if rec.DIM5 <> '' then if gLSetup."Shortcut Dimension 5 Code" <> '' then begin
            OnBeforeValidateDimCode(5,rec.DIM5);
            genJnlLine.ValidateShortcutDimCode(5,rec.DIM3);
        end;
        if rec.DIM6 <> '' then if gLSetup."Shortcut Dimension 6 Code" <> '' then begin
            OnBeforeValidateDimCode(6,rec.DIM6);
            genJnlLine.ValidateShortcutDimCode(6,rec.DIM3);
        end;
        if rec.DIM7 <> '' then if gLSetup."Shortcut Dimension 7 Code" <> '' then begin
            OnBeforeValidateDimCode(7,rec.DIM7);
            genJnlLine.ValidateShortcutDimCode(7,rec.DIM3);
        end;
        if rec.DIM8 <> '' then if gLSetup."Shortcut Dimension 8 Code" <> '' then begin
            OnBeforeValidateDimCode(8, rec.DIM8);
            genJnlLine.ValidateShortcutDimCode(8,rec.DIM3);
        end;


        genJnlLine.Modify();
    end;

    /// Created event to take action on missing dimension values
    [IntegrationEvent(false,false)]
    procedure OnBeforeValidateDimCode(fieldNum:Integer;valueCode:Code[20]);
    begin
    end;
}