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
                textelement(textResponseDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        textResponseDate := Format(IFRET.DATE,8,'<Year,2>/<Month,2>/<Day,2>');
                    end;
                }
                // fieldelement(IRDATE;IFRET.DATE) {}
                textelement(textResponseTime)
                {
                    trigger OnBeforePassVariable()
                    begin
                        textResponseTime := format(IFRET.TIME,8,'<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>');
                    end;
                }
                // fieldelement(IRTIME;IFRET.TIME) {}
            }
        }
    }

}