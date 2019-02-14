/// This table is the representation of the batch file from the IBM Server for NAV
/// Field naming is kept similar as on the IBM server for clarity

table 50214 "NAC.IBMNAV.IFPMNT"
{
    //DataClassification = CustomerContent;
    DataPerCompany = false;
    Description = 'This table represents the data batch file to be exported';

    fields
    {
        field(1; CompanyID; code[3]) { Description = 'Company ID in NAV'; Caption = 'Company Short Name'; }
        field(2; TranactionCode; code[10]) { Description = 'IBM Transaction Code'; Caption = 'IBM Transaction Code'; }
        field(3; TransactionID; Integer) { Description = 'IBM Transaction ID'; Caption = 'IBM Transaction ID'; }
        field(4; NAVEntryNo; Integer) { Description = 'NAV Detailed Ledger Entry No.'; Caption = 'NAV Detailed Ledger Entry No.'; }
        field(5; AMSDocumentNo; Code[20]) { Description = 'AMASIS Document No.'; Caption = 'AMASIS Document No.'; }
        field(6; NAVNITCode; code[36]) { Description = 'NAV Cust Vend No'; Caption = 'No.'; }


        field(10; PostingDate; Date) { Description = 'Posting Date of Detailed Entry'; Caption = 'Posting Date'; }
        field(11; CurrencyCode; code[10]) { Description = 'Currency of the Transaction'; Caption = 'Currency Code'; }

        field(12; Amount; Decimal) { Description = 'Transaction Amount'; Caption = 'Transaction Amount'; }
        field(13; AmountLCY; Decimal) { Description = 'Transaction Amount Local Currency'; Caption = 'Transaction Amount LCY'; }
        field(14; PaymentReference; code[20]) { Description = 'Transaction Document No.'; Caption = 'Payment Document No.'; }
        field(15; PaymentReferencyType; code[20]) { Description = 'Transaction Document Type'; Caption = 'Payment Document Type'; }
        field(16; InvoiceFullyPaid; Boolean) { Description = 'If Applied Invoice is fully Paid'; Caption = 'Invoice Fully Paid'; }

    }

    keys
    {
        key(PK; CompanyID, TranactionCode, TransactionID, NAVEntryNo, AMSDocumentNo, NAVNITCode)
        {
            Clustered = true;
        }
    }
}