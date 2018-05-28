/// This codeunit used as a fail codeunit to insert general journal lines for NAC.IBMNAV 

codeunit 50204 "NAC.IBMNAV.InsertGenJnlLine"
{
    TableNo = "NAC.IBMNAV.IFBAT";
    var
        genJnlLine:Record"Gen. Journal Line";
        IBMNAVSetup:Record"NAC.IBMNAV.Setup";
        GLSetup:Record"General Ledger Setup";
        sourceCodeSetup:Record"Source Code Setup";
    trigger OnRun()
    begin
        IBMNAVSetup.get;
        GLSetup.get;
        sourceCodeSetup.get;

        genJnlLine.init;
        genJnlLine."Journal Template Name" := IBMNAVSetup.GenJnlTemplate;
        genJnlLine."Journal Batch Name" := IBMNAVSetup.GenJnlBatchCode;;
        genJnlLine."Line No." := rec.SEQ;
        genJnlLine.Insert;

        genJnlLine."NAC.IBMNAV Sequence No." := rec.SEQ;
        genJnlLine."NAC.IBMNAV Trancaction Code" := rec.TID;
        genJnlLine."NAC.IBMNAV Transaction No." := rec.ID;

        genJnlLine."Source Code" := sourceCodeSetup."NAC.IBMNAV";
        genJnlLine."System-Created Entry" := true;

        /// Add validation fields here.
        Evaluate(genJnlLine."Document Type",Rec.DOCTYP); 
        genJnlLine.validate("Document Type");

        genJnlLine.Validate("Document No.",rec.DOCNO);

        genJnlLine.Validate("Posting Date",rec.POSTDAT);
        genJnlLine.Validate("Document Date",rec.DOCDAT);

        Evaluate(genJnlLine."Account Type",rec.ACCTYP);
        genJnlLine.Validate("Account Type");

        genJnlLine.Validate("Account No.",rec.ACCTNO);

        genJnlLine.Validate("External Document No.",rec.EXTDOC);
        genJnlLine.Validate(Description,rec.TRND);

        if rec.CURR <> GLSetup."LCY Code" then begin
            genJnlLine.Validate("Currency Code",rec.CURR);
            genJnlLine.Validate("Currency Factor",rec.XRATE);
        end;

        genJnlLine.Validate(Amount,rec.VALUE);

        /// The VAT Product Posting Group       ----    May need to do something special here
        genJnlLine.Validate("VAT Prod. Posting Group",rec.VATGRP);


        genJnlLine.Modify();



        /// Dimensions
        if rec.DIM1 <> '' then if GLSetup."Shortcut Dimension 1 Code" <> '' then  genJnlLine.validate("Shortcut Dimension 1 Code",rec.DIM1);
        if rec.DIM2 <> '' then if GLSetup."Shortcut Dimension 2 Code" <> '' then  genJnlLine.validate("Shortcut Dimension 2 Code",rec.DIM2);

        if rec.DIM3 <> '' then if GLSetup."Shortcut Dimension 3 Code" <> '' then genJnlLine.ValidateShortcutDimCode(3,rec.DIM3);
        if rec.DIM4 <> '' then if GLSetup."Shortcut Dimension 4 Code" <> '' then genJnlLine.ValidateShortcutDimCode(4,rec.DIM3);
        if rec.DIM5 <> '' then if GLSetup."Shortcut Dimension 5 Code" <> '' then genJnlLine.ValidateShortcutDimCode(5,rec.DIM3);
        if rec.DIM6 <> '' then if GLSetup."Shortcut Dimension 6 Code" <> '' then genJnlLine.ValidateShortcutDimCode(6,rec.DIM3);
        if rec.DIM7 <> '' then if GLSetup."Shortcut Dimension 7 Code" <> '' then genJnlLine.ValidateShortcutDimCode(7,rec.DIM3);
        if rec.DIM8 <> '' then if GLSetup."Shortcut Dimension 8 Code" <> '' then genJnlLine.ValidateShortcutDimCode(8,rec.DIM3);


        genJnlLine.Modify();
    end;

}