xmlport 50206 "NAC.IBMNAV.IFPMNTXMLP"
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
            tableelement(NACIBMNAVIFPMNT; "NAC.IBMNAV.IFPMNT")
            {
                fieldelement(CompanyID; NACIBMNAVIFPMNT.CompanyID) { }
                fieldelement(TransactionCode; NACIBMNAVIFPMNT.TranactionCode) { }
                fieldelement(TransactionID; NACIBMNAVIFPMNT.TransactionID) { }
                fieldelement(NAVEntryNo; NACIBMNAVIFPMNT.NAVEntryNo) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.AMSDocumentNo) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.NAVNITCode) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.PostingDate) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.CurrencyCode) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.Amount) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.AmountLCY) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.PaymentReference) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.PaymentReferencyType) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.InvoiceFullyPaid) { }
            }
        }
    }
}
