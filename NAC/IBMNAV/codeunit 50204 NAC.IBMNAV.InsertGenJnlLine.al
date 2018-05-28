/// This codeunit used as a fail codeunit to insert general journal lines for NAC.IBMNAV 

codeunit 50204 "NAC.IBMNAV.InsertGenJnlLine"
{
    TableNo = "NAC.IBMNAV.IFBAT";
    var
        genJnlLine:Record"Gen. Journal Line";
        IBMNAVSetup:Record"NAC.IBMNAV.Setup";
        sourceCodeSetup:Record"Source Code Setup";
    trigger OnRun()
    begin
        IBMNAVSetup.get;
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

        /// Add validation fields here.

        genJnlLine.Modify;
    end;

}