pageextension 50208 "NAC.IBMNAV.GenJournal" extends "General Journal"
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