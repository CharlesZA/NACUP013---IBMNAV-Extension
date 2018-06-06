/// This codeunit subscribes to events raised in the posting routine for IBMNAV
/// Its job is to transfer information on the general journal lines to gl, customer and vendor entries during the post process

/// LOCAL [External] [IntegrationEvent] OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf : TEMPORARY Record "G/L Entry";VAR GenJournalLine : Record "Gen. Journal Line")

codeunit 50205 "NAC.IBMNAV.PostingEventHandler"
{
    Description='Posting Event Handler';

    trigger OnRun()
    begin
        
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', true, false)]
    local procedure OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf:Record"G/L Entry"temporary;VAR GenJournalLine : Record "Gen. Journal Line")
    begin
        TempGLEntryBuf."NAC.IBMNAV Sequence No." := GenJournalLine."NAC.IBMNAV Sequence No.";
        TempGLEntryBuf."NAC.IBMNAV Transaction Code" := GenJournalLine."NAC.IBMNAV Transaction Code";
        TempGLEntryBuf."NAC.IBMNAV Transaction No." := GenJournalLine."NAC.IBMNAV Transaction No.";
    end;


}