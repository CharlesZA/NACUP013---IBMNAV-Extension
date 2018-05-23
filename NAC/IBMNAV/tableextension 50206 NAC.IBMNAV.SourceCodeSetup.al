/// This object extends the source code table to include source code from IBM

tableextension 50206 "NAC.IBMNAV.SourceCodeSetup" extends "Source Code Setup"
{
    fields
    {
        field(50201;"NAC.IBMNAV";Code[10])
        {
            Caption='NAC.IBMNAV Transactions';
            TableRelation="Source Code";
        }
    }
}