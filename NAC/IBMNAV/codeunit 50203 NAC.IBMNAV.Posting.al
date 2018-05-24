/// This codeunit is called to posted batch information received from IBM. 
///
/// Its job is to post information in table 50205 NAC.IBMNAV.IFBAT to the general ledger
/// as well as write return information back to NAC.IBMNAV.IFRET

codeunit 50203 "NAC.IBMNAV.Posting"
{
    var
        IFRET:Record"NAC.IBMNAV.IFRET";
        IFBAT:Record"NAC.IBMNAV.IFBAT";
        GenJnlLine:Record"Gen. Journal Line";


    trigger OnRun()
    begin
        
    end;
}