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
                textelement(textPostingDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        textPostingDate := Format(NACIBMNAVIFPMNT.PostingDate,8,'<Year,2>/<Month,2>/<Day,2>');
                    end;
                }

                fieldelement(CompanyID; NACIBMNAVIFPMNT.CurrencyCode) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.Amount) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.AmountLCY) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.PaymentReference) { }
                fieldelement(CompanyID; NACIBMNAVIFPMNT.PaymentReferencyType) { }

                textelement(textInvoicePaid)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if NACIBMNAVIFPMNT.InvoiceFullyPaid then
                            textInvoicePaid := '1'
                        else
                            textInvoicePaid := '0';
                    end;
                }
            }
        }
    }
}
