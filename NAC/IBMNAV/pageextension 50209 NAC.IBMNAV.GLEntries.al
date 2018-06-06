pageextension 50209 "NAC.IBMNAV.GLEntries" extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("NAC.IBMNAV Transaction No.";"NAC.IBMNAV Transaction No.") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Transaction Code";"NAC.IBMNAV Transaction Code") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Sequence No.";"NAC.IBMNAV Sequence No.") {Visible=false; Editable=false;}
        }
    }    
}