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
                textelement(textUPDDATE)
                {
                    trigger OnAfterAssignVariable()
                    var
                        day: Integer;
                        month: Integer;
                        year: Integer;
                    begin
                        Evaluate(day, CopyStr(textUPDDATE, 7, 2));
                        Evaluate(month, CopyStr(textUPDDATE, 4, 2));
                        Evaluate(year, CopyStr(textUPDDATE, 1, 2));
                        year += 2000;
                        NACIBMNAVIFXRATE.UPDDATE := DMY2Date(day, month, year);
                    end;
                }
                fieldelement(UPDTIME; NACIBMNAVIFXRATE."UPDTIME")
                {
                }
            }
        }
    }
}
