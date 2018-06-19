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

        genJnlLine.Validate("External Document No.",rec.EXTDOC);
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
        if rec.DIM1 <> '' then if gLSetup."Shortcut Dimension 1 Code" <> '' then  genJnlLine.validate("Shortcut Dimension 1 Code",rec.DIM1);
        if rec.DIM2 <> '' then if gLSetup."Shortcut Dimension 2 Code" <> '' then  genJnlLine.validate("Shortcut Dimension 2 Code",rec.DIM2);

        if rec.DIM3 <> '' then if gLSetup."Shortcut Dimension 3 Code" <> '' then genJnlLine.ValidateShortcutDimCode(3,rec.DIM3);
        if rec.DIM4 <> '' then if gLSetup."Shortcut Dimension 4 Code" <> '' then genJnlLine.ValidateShortcutDimCode(4,rec.DIM3);
        if rec.DIM5 <> '' then if gLSetup."Shortcut Dimension 5 Code" <> '' then genJnlLine.ValidateShortcutDimCode(5,rec.DIM3);
        if rec.DIM6 <> '' then if gLSetup."Shortcut Dimension 6 Code" <> '' then genJnlLine.ValidateShortcutDimCode(6,rec.DIM3);
        if rec.DIM7 <> '' then if gLSetup."Shortcut Dimension 7 Code" <> '' then genJnlLine.ValidateShortcutDimCode(7,rec.DIM3);
        if rec.DIM8 <> '' then if gLSetup."Shortcut Dimension 8 Code" <> '' then genJnlLine.ValidateShortcutDimCode(8,rec.DIM3);


        genJnlLine.Modify();
    end;
}