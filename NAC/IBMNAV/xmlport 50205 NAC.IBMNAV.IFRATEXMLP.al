xmlport 50205 "NAC.IBMNAV.IFXRATEXMLP"
{
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Description = 'This xmlport is used to import information sent from IBM into nav';
    UseRequestPage = false;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(NACIBMNAVIFXRATE; "NAC.IBMNAV.IFXRATE")
            {
                fieldelement(BASECURRENCY; NACIBMNAVIFXRATE."BASECURRENCY")
                {
                }
                fieldelement(CURRENCY; NACIBMNAVIFXRATE."CURRENCY")
                {
                }
                fieldelement(RATE; NACIBMNAVIFXRATE."RATE")
                {
                }
                fieldelement(UPDDATE; NACIBMNAVIFXRATE."UPDDATE")
                {
                }
                fieldelement(UPDTIME; NACIBMNAVIFXRATE."UPDTIME")
                {
                }
            }
        }
    }
}
