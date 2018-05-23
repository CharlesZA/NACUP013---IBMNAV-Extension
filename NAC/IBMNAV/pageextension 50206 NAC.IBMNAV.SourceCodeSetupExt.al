pageextension 50206 "NAC.IBMNAV.SourceCodeSetupExt" extends "Source Code Setup"
{
    Description = 'Extends the Source Code Setup page';
    
    layout
    {
        addlast(General)
        {
            field("NAC.IBMNAV";"NAC.IBMNAV")
            {
                
            }
        }
    }
}