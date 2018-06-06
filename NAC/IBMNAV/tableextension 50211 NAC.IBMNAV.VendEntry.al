/// Extension to table to store transaction reference information related to table NAC.IBMNAV.TransactionEntry

tableextension 50211 "NAC.IBMNAV.VendEntry" extends "Vendor Ledger Entry"
{
    Description='Extension to table to store transaction reference information related to table NAC.IBMNAV.TransactionEntry';
    
    fields
    {
        field(50201; "NAC.IBMNAV Transaction No."; Integer) 
        {
            Editable=false;
            Caption='IBM Transaction No.';
        }
        field(50202;"NAC.IBMNAV Transaction Code";code[10])
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