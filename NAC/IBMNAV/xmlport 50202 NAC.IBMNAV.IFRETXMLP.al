/// This xmlport is used to export information for IBM. 


xmlport 50202 "NAC.IBMNAV.IFRETXMLP"
{
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Description='This xmlport is used to export information for IBM.';


    schema
    {
        textelement(Root)
        {
            tableelement(IFRET; "NAC.IBMNAV.IFRET")
            {
                fieldelement(IRID;IFRET.ID) {}
                fieldelement(IRTID;IFRET.TID) {}
                fieldelement(IRSEQ;IFRET.SEQ) {}
                fieldelement(IRRESCD;IFRET.RESCD) {}
                fieldelement(IRRRESDS;IFRET.RESDS) {}
                fieldelement(IRDATE;IFRET.DATE) {}
                fieldelement(IRTIME;IFRET.TIME) {}
            }
        }
    }

}