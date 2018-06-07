/// This codeunit subscribes to events raised in the posting routine for IBMNAV
/// Its job is to transfer information on the general journal lines to gl, customer and vendor entries during the post process

codeunit 50205 "NAC.IBMNAV.PostingEventHandler"
{
    Description='NAC.IBMNAV Posting Event Handler';

    trigger OnRun()
    begin
    end;

/// LOCAL [External] [IntegrationEvent] OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf : TEMPORARY Record "G/L Entry";VAR GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', true, false)]
    local procedure OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf:Record"G/L Entry"temporary;VAR GenJournalLine : Record "Gen. Journal Line")
    begin
        TempGLEntryBuf."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        TempGLEntryBuf."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        TempGLEntryBuf."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";
    end;

/// LOCAL [External] [IntegrationEvent] OnAfterCopyCustLedgerEntryFromGenJnlLine(VAR CustLedgerEntry : Record "Cust. Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(VAR CustLedgerEntry:Record"Cust. Ledger Entry";GenJournalLine:Record"Gen. Journal Line")
    begin
        CustLedgerEntry."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        CustLedgerEntry."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        CustLedgerEntry."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";
    end;

/// LOCAL [External] [IntegrationEvent] OnAfterCopyVendLedgerEntryFromGenJnlLine(VAR VendorLedgerEntry : Record "Vendor Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(VAR VendorLedgerEntry:Record"Vendor Ledger Entry";GenJournalLine:Record"Gen. Journal Line")
    begin
        VendorLedgerEntry."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        VendorLedgerEntry."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        VendorLedgerEntry."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";
    end;
}