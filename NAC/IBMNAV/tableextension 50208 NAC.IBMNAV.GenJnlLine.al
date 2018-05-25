/// Extension to table to store transaction reference information related to table NAC.IBMNAV.TransactionEntry

tableextension 50208 "NAC.IBMNAV.GenJnlLine" extends "Gen. Journal Line"
{
    Description='Extension to table to store transaction reference information related to table NAC.IBMNAV.TransactionEntry';
    
    fields
    {
        field(50201; "NAC.IBMNAV Transaction No."; Integer) 
        {
            Editable=false;
            Caption='IBM Transaction No.';
        }
        field(50202;"NAC.IBMNAV Trancaction Code";code[10])
        {
            Editable=false;
            Caption='IBM Transaction Code';
        }
        field(50203; "NAC.IBMNAV Sequence No.";Integer)
        {
            Editable=false;
            Caption='IBM Sequence No.';
        }
    }
    
}