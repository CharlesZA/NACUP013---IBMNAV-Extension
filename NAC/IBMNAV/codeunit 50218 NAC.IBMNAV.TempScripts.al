codeunit 50218 "NAC.IBMNAV.TempScripts"
{
    trigger OnRun()
    begin

    end;

    /// Sends an entry number to the general journal
    local procedure ReverseGLEntries(var vGLEntryNo: Integer)
    var
        glEntry: Record "g/l entry";
        genJnlLine: Record "Gen. Journal Line";
        iBMNAVSetup: Record "NAC.IBMNAV.Setup";
    begin

        iBMNAVSetup.get;

        if glEntry.get(vGLEntryNo) = false then exit;

        genJnlLine.init;
        genJnlLine."Journal Template Name" := iBMNAVSetup.GenJnlTemplate;
        genJnlLine."Journal Batch Name" := iBMNAVSetup.GenJnlBatchCode;

        genJnlLine."Line No." := vGLEntryNo;
        genJnlLine.Insert;

        genJnlLine.SetHideValidation(true);

        genJnlLine."NAC.IBMNAV Sequence No." := glEntry."NAC.IBMNAV Sequence No.";
        genJnlLine."NAC.IBMNAV Transaction Code" := glEntry."NAC.IBMNAV Transaction Code";
        genJnlLine."NAC.IBMNAV Transaction No." := glEntry."NAC.IBMNAV Transaction No.";

        //>> Record IBM Fields
        genJnlLine.TC := glEntry.TC;
        genJnlLine.DIM1 := glEntry.DIM1;
        genJnlLine.DIM2 := glEntry.DIM2;
        genJnlLine.DIM3 := glEntry.DIM3;
        genJnlLine.DIM4 := glEntry.DIM4;
        genJnlLine.DIM5 := glEntry.DIM5;
        genJnlLine.DIM6 := glEntry.DIM6;
        genJnlLine.DIM7 := glEntry.DIM7;
        genJnlLine.DIM8 := glEntry.DIM8;

        genJnlLine.DOCNO := glEntry.DOCNO;
        genJnlLine.ENV := glEntry.ENV;
        genJnlLine.POSTDAT := glEntry.POSTDAT;
        genJnlLine.DOCDAT := glEntry.DOCDAT;
        genJnlLine.DOCTYP := glEntry.DOCTYP;

        genJnlLine.ACCTNO := glEntry.ACCTNO;
        genJnlLine.ACCTYP := glEntry.ACCTYP;
        genJnlLine.TRND := glEntry.TRND;
        genJnlLine.EXTDOC := glEntry.EXTDOC;

        genJnlLine.CURR := glEntry.CURR;
        genJnlLine.XRATE := glEntry.XRATE;
        genJnlLine.VALUE := glEntry.VALUE;
        genJnlLine.VATGRP := glEntry.VATGRP;

        genJnlLine.TUSER := glEntry.TUSER;
        genJnlLine.TDATE := glEntry.TDATE;
        genJnlLine.TTIME := glEntry.TTIME;

        genJnlLine.PDF := glEntry.PDF;

        genJnlLine.ERR := glEntry.ERR;
        genJnlLine.RESCD := glEntry.RESCD;

        //<< Record IBM Fields

        genJnlLine."Source Code" := glEntry."Source Code";
        genJnlLine."System-Created Entry" := true;

        /// Add validation fields here.
        genJnlLine.validate("Document Type", glEntry."Document Type");

        genJnlLine.Validate("Document No.", glEntry."Document No.");

        genJnlLine.Validate("Posting Date", glEntry."Posting Date");
        genJnlLine.Validate("Document Date", glEntry."Document Date");

        genJnlLine.Validate("Account Type", genJnlLine."Account Type"::"G/L Account");

        genJnlLine.Validate("Account No.", glEntry."G/L Account No.");

        genJnlLine.Validate("External Document No.", glEntry."External Document No.");

        genJnlLine.Validate(Description, 'CORRECTION ENTRY');

        genJnlLine.Validate(Amount, glEntry.Amount * -1);

        genJnlLine."Gen. Posting Type" := genJnlLine."Gen. Posting Type"::" ";
        genJnlLine."Gen. Bus. Posting Group" := '';
        genJnlLine."Gen. Prod. Posting Group" := '';
        genJnlLine."VAT Bus. Posting Group" := '';
        genJnlLine."VAT Prod. Posting Group" := '';

        genJnlLine.Modify();

    end;

    var
        myInt: Integer;
}