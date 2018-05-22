/// This xmlport is used to export information for IBM. 


xmlport 50202 "NAC.IBMNAV.IFRETXMLP"
{
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '<TAB>';
    FieldSeparator = '<None>';
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Description='This xmlport is used to export information for IBM.';


    schema
    {
        textelement(Root)
        {
            tableelement(IFRET; "NAC.IBMNAV.IFRET")
            {
                fieldelement(IRID;IFRET.IRID) {}
                fieldelement(IRTID;IFRET.IRTID) {}
                fieldelement(IRSEQ;IFRET.IRSEQ) {}
                fieldelement(IRRESCD;IFRET.IRRESCD) {}
                fieldelement(IRRRESDS;IFRET.IRRESDS) {}
                fieldelement(IRDATE;IFRET.IRDATE) {}
                fieldelement(IRTIME;IFRET.IRTIME) {}
            }
        }
    }

}