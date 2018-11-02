xmlport 50204 "NAC.IBMNAV.IFTHIRDXMLP"
{
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Description = 'This xmlport is used to export information for IBM.';


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(NACIBMNAVIFTHIRD; "NAC.IBMNAV.IFTHIRD")
            {
                fieldelement(CompanyID; NACIBMNAVIFTHIRD."CompanyID")
                {
                }
                fieldelement(NAVNITCode; NACIBMNAVIFTHIRD."NAVNITCode")
                {
                }
                fieldelement(CompanyName; NACIBMNAVIFTHIRD."CompanyName")
                {
                }
                fieldelement(ContactName; NACIBMNAVIFTHIRD."ContactName")
                {
                }
                fieldelement(ContactEmail; NACIBMNAVIFTHIRD."ContactEmail")
                {
                }
                fieldelement(ContactTel; NACIBMNAVIFTHIRD."ContactTel")
                {
                }
                fieldelement(CompanyAddr1; NACIBMNAVIFTHIRD."CompanyAddr1")
                {
                }
                fieldelement(CompanyAddr2; NACIBMNAVIFTHIRD."CompanyAddr2")
                {
                }
                fieldelement(CompanyPostCode; NACIBMNAVIFTHIRD."CompanyPostCode")
                {
                }
                fieldelement(CompanyCountry; NACIBMNAVIFTHIRD."CompanyCountry")
                {
                }
                fieldelement(CompanyCity; NACIBMNAVIFTHIRD."CompanyCity")
                {
                }
                fieldelement(CompanyBlocked; NACIBMNAVIFTHIRD."CompanyBlocked")
                {
                }
                fieldelement(CompanyVATNo; NACIBMNAVIFTHIRD."CompanyVATNo")
                {
                }
                fieldelement(CompanyVATPostGrp; NACIBMNAVIFTHIRD."CompanyVATPostGrp")
                {
                }
                fieldelement(CompanyPaymentTerms; NACIBMNAVIFTHIRD."CompanyPaymentTerms")
                {
                }
                fieldelement(CompanyCurrency; NACIBMNAVIFTHIRD."CompanyCurrency")
                {
                }
            }
        }
    }
}
