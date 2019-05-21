/// This codeunit subscribes to events raised in the posting routine for IBMNAV
/// Its job is to transfer information on the general journal lines to gl, customer and vendor entries during the post process

codeunit 50205 "NAC.IBMNAV.PostingEventHandler"
{
    Description='NAC.IBMNAV Posting Event Handler';

    trigger OnRun()
    begin
    end;

/// LOCAL [External] [IntegrationEvent] OnAfterCopyGLEntryFromGenJnlLine(VAR GLEntry : Record "G/L Entry";VAR GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(VAR GLEntry : Record "G/L Entry";VAR GenJournalLine : Record "Gen. Journal Line")
    begin
        GLEntry."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        GLEntry."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        GLEntry."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";

        GLEntry.TC := GenJournalLine.TC;
        GLEntry.DIM1 := GenJournalLine.DIM1;
        GLEntry.DIM2 := GenJournalLine.DIM2;
        GLEntry.DIM3 := GenJournalLine.DIM3;
        GLEntry.DIM4 := GenJournalLine.DIM4;
        GLEntry.DIM5 := GenJournalLine.DIM5;
        GLEntry.DIM6 := GenJournalLine.DIM6;
        GLEntry.DIM7 := GenJournalLine.DIM7;
        GLEntry.DIM8 := GenJournalLine.DIM8;

        GLEntry.DOCNO := GenJournalLine.DOCNO;
        GLEntry.ENV := GenJournalLine.ENV;
        GLEntry.POSTDAT := GenJournalLine.POSTDAT;
        GLEntry.DOCDAT := GenJournalLine.DOCDAT;
        GLEntry.DOCTYP := GenJournalLine.DOCTYP;

        GLEntry.ACCTNO := GenJournalLine.ACCTNO;
        GLEntry.ACCTYP := GenJournalLine.ACCTYP;
        GLEntry.TRND := GenJournalLine.TRND;
        GLEntry.EXTDOC := GenJournalLine.EXTDOC;

        GLEntry.CURR := GenJournalLine.CURR;
        GLEntry.XRATE := GenJournalLine.XRATE;
        GLEntry.VALUE := GenJournalLine.VALUE;
        GLEntry.VATGRP := GenJournalLine.VATGRP;

        GLEntry.TUSER := GenJournalLine.TUSER;
        GLEntry.TDATE := GenJournalLine.TDATE;
        GLEntry.TTIME := GenJournalLine.TTIME;

        GLEntry.PDF := GenJournalLine.PDF;

        GLEntry.ERR := GenJournalLine.ERR;
        GLEntry.RESCD := GenJournalLine.RESCD;

    end;

/// LOCAL [External] [IntegrationEvent] OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf : TEMPORARY Record "G/L Entry";VAR GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', true, false)]
    local procedure OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf:Record"G/L Entry"temporary;VAR GenJournalLine : Record "Gen. Journal Line")
    begin
        TempGLEntryBuf."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        TempGLEntryBuf."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        TempGLEntryBuf."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";

        TempGLEntryBuf.TC := GenJournalLine.TC;
        TempGLEntryBuf.DIM1 := GenJournalLine.DIM1;
        TempGLEntryBuf.DIM2 := GenJournalLine.DIM2;
        TempGLEntryBuf.DIM3 := GenJournalLine.DIM3;
        TempGLEntryBuf.DIM4 := GenJournalLine.DIM4;
        TempGLEntryBuf.DIM5 := GenJournalLine.DIM5;
        TempGLEntryBuf.DIM6 := GenJournalLine.DIM6;
        TempGLEntryBuf.DIM7 := GenJournalLine.DIM7;
        TempGLEntryBuf.DIM8 := GenJournalLine.DIM8;

        TempGLEntryBuf.DOCNO := GenJournalLine.DOCNO;
        TempGLEntryBuf.ENV := GenJournalLine.ENV;
        TempGLEntryBuf.POSTDAT := GenJournalLine.POSTDAT;
        TempGLEntryBuf.DOCDAT := GenJournalLine.DOCDAT;
        TempGLEntryBuf.DOCTYP := GenJournalLine.DOCTYP;

        TempGLEntryBuf.ACCTNO := GenJournalLine.ACCTNO;
        TempGLEntryBuf.ACCTYP := GenJournalLine.ACCTYP;
        TempGLEntryBuf.TRND := GenJournalLine.TRND;
        TempGLEntryBuf.EXTDOC := GenJournalLine.EXTDOC;

        TempGLEntryBuf.CURR := GenJournalLine.CURR;
        TempGLEntryBuf.XRATE := GenJournalLine.XRATE;
        TempGLEntryBuf.VALUE := GenJournalLine.VALUE;
        TempGLEntryBuf.VATGRP := GenJournalLine.VATGRP;

        TempGLEntryBuf.TUSER := GenJournalLine.TUSER;
        TempGLEntryBuf.TDATE := GenJournalLine.TDATE;
        TempGLEntryBuf.TTIME := GenJournalLine.TTIME;

        TempGLEntryBuf.PDF := GenJournalLine.PDF;

        TempGLEntryBuf.ERR := GenJournalLine.ERR;
        TempGLEntryBuf.RESCD := GenJournalLine.RESCD;

    end;

/// LOCAL [External] [IntegrationEvent] OnAfterCopyCustLedgerEntryFromGenJnlLine(VAR CustLedgerEntry : Record "Cust. Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(VAR CustLedgerEntry:Record"Cust. Ledger Entry";GenJournalLine:Record"Gen. Journal Line")
    begin
        CustLedgerEntry."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        CustLedgerEntry."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        CustLedgerEntry."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";

        CustLedgerEntry.TC := GenJournalLine.TC;
        CustLedgerEntry.DIM1 := GenJournalLine.DIM1;
        CustLedgerEntry.DIM2 := GenJournalLine.DIM2;
        CustLedgerEntry.DIM3 := GenJournalLine.DIM3;
        CustLedgerEntry.DIM4 := GenJournalLine.DIM4;
        CustLedgerEntry.DIM5 := GenJournalLine.DIM5;
        CustLedgerEntry.DIM6 := GenJournalLine.DIM6;
        CustLedgerEntry.DIM7 := GenJournalLine.DIM7;
        CustLedgerEntry.DIM8 := GenJournalLine.DIM8;

        CustLedgerEntry.DOCNO := GenJournalLine.DOCNO;
        CustLedgerEntry.ENV := GenJournalLine.ENV;
        CustLedgerEntry.POSTDAT := GenJournalLine.POSTDAT;
        CustLedgerEntry.DOCDAT := GenJournalLine.DOCDAT;
        CustLedgerEntry.DOCTYP := GenJournalLine.DOCTYP;

        CustLedgerEntry.ACCTNO := GenJournalLine.ACCTNO;
        CustLedgerEntry.ACCTYP := GenJournalLine.ACCTYP;
        CustLedgerEntry.TRND := GenJournalLine.TRND;
        CustLedgerEntry.EXTDOC := GenJournalLine.EXTDOC;

        CustLedgerEntry.CURR := GenJournalLine.CURR;
        CustLedgerEntry.XRATE := GenJournalLine.XRATE;
        CustLedgerEntry.VALUE := GenJournalLine.VALUE;
        CustLedgerEntry.VATGRP := GenJournalLine.VATGRP;

        CustLedgerEntry.TUSER := GenJournalLine.TUSER;
        CustLedgerEntry.TDATE := GenJournalLine.TDATE;
        CustLedgerEntry.TTIME := GenJournalLine.TTIME;

        CustLedgerEntry.PDF := GenJournalLine.PDF;

        CustLedgerEntry.ERR := GenJournalLine.ERR;
        CustLedgerEntry.RESCD := GenJournalLine.RESCD;

    end;

/// LOCAL [External] [IntegrationEvent] OnAfterCopyVendLedgerEntryFromGenJnlLine(VAR VendorLedgerEntry : Record "Vendor Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(VAR VendorLedgerEntry:Record"Vendor Ledger Entry";GenJournalLine:Record"Gen. Journal Line")
    begin
        VendorLedgerEntry."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        VendorLedgerEntry."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        VendorLedgerEntry."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";

        VendorLedgerEntry.TC := GenJournalLine.TC;
        VendorLedgerEntry.DIM1 := GenJournalLine.DIM1;
        VendorLedgerEntry.DIM2 := GenJournalLine.DIM2;
        VendorLedgerEntry.DIM3 := GenJournalLine.DIM3;
        VendorLedgerEntry.DIM4 := GenJournalLine.DIM4;
        VendorLedgerEntry.DIM5 := GenJournalLine.DIM5;
        VendorLedgerEntry.DIM6 := GenJournalLine.DIM6;
        VendorLedgerEntry.DIM7 := GenJournalLine.DIM7;
        VendorLedgerEntry.DIM8 := GenJournalLine.DIM8;

        VendorLedgerEntry.DOCNO := GenJournalLine.DOCNO;
        VendorLedgerEntry.ENV := GenJournalLine.ENV;
        VendorLedgerEntry.POSTDAT := GenJournalLine.POSTDAT;
        VendorLedgerEntry.DOCDAT := GenJournalLine.DOCDAT;
        VendorLedgerEntry.DOCTYP := GenJournalLine.DOCTYP;

        VendorLedgerEntry.ACCTNO := GenJournalLine.ACCTNO;
        VendorLedgerEntry.ACCTYP := GenJournalLine.ACCTYP;
        VendorLedgerEntry.TRND := GenJournalLine.TRND;
        VendorLedgerEntry.EXTDOC := GenJournalLine.EXTDOC;

        VendorLedgerEntry.CURR := GenJournalLine.CURR;
        VendorLedgerEntry.XRATE := GenJournalLine.XRATE;
        VendorLedgerEntry.VALUE := GenJournalLine.VALUE;
        VendorLedgerEntry.VATGRP := GenJournalLine.VATGRP;

        VendorLedgerEntry.TUSER := GenJournalLine.TUSER;
        VendorLedgerEntry.TDATE := GenJournalLine.TDATE;
        VendorLedgerEntry.TTIME := GenJournalLine.TTIME;

        VendorLedgerEntry.PDF := GenJournalLine.PDF;

        VendorLedgerEntry.ERR := GenJournalLine.ERR;
        VendorLedgerEntry.RESCD := GenJournalLine.RESCD;

    end;
}