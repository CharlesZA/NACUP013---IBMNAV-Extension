pageextension 50211 "NAC.IBMNAV.VendEntries" extends "Vendor Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("NAC.IBMNAV Transaction No.";"NAC.IBMNAV Transaction No.") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Transaction Code";"NAC.IBMNAV Trancaction Code") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Sequence No.";"NAC.IBMNAV Sequence No.") {Visible=false; Editable=false;}
        }
    }    
}