/// This table is the representation of the batch file from the IBM Server for NAV
/// Field naming is kept similar as on the IBM server for clarity

table 50212 "NAC.IBMNAV.IFXTHIRD"
{
    //DataClassification = CustomerContent;
    DataPerCompany = false;
    Description = 'This table represents the data batch file received from IBM after it has been imported';

    fields
    {
        field(1; CompanyID; code[3]) { Description = 'Company ID in NAV'; Caption = 'Company Short Name'; }
        field(2; NAVNITCode; code[36]) { Description = 'NAV Cust Vend No'; Caption = 'No.'; }


        field(10; CompanyName; code[36]) { Description = 'NAV Cust Vend Name'; Caption = 'Name'; }
        field(11; ContactName; code[36]) { Description = 'NAV Cust Vend Contact'; Caption = 'Contact'; }
        field(12; ContactEmail; code[36]) { Description = 'NAV Cust Vend Email'; Caption = 'E-mail'; }
        field(13; ContactTel; code[36]) { Description = 'NAV Cust Vend Phone No'; Caption = 'Phone No.'; }
        field(14; CompanyAddr1; code[36]) { Description = 'NAV Cust Vend Address 1'; Caption = 'Address 1'; }
        field(15; CompanyAddr2; code[36]) { Description = 'NAV Cust Vend Address 2'; Caption = 'Address 2'; }
        field(16; CompanyPostCode; code[36]) { Description = 'NAV Cust Vend Post Code'; Caption = 'Post Code'; }
        field(17; CompanyCountry; code[36]) { Description = 'NAV Cust Vend Country'; Caption = 'Country Code'; }
        field(18; CompanyCity; code[36]) { Description = 'NAV Cust Vend City'; Caption = 'City'; }
        field(19; CompanyBlocked; code[36]) { Description = 'NAV Cust Vend Blocked'; Caption = 'Blocked'; }
        field(20; CompanyVATNo; code[36]) { Description = 'NAV Cust Vend VAT Registration No'; Caption = 'VAT Registration No.'; }
        field(21; CompanyVATPostGrp; code[36]) { Description = 'NAV Cust Vend VAT Business Group'; Caption = 'VAT Business Posting Group'; }
        field(22; CompanyPaymentTerms; code[36]) { Description = 'NAV Cust Vend Payment Terms Code'; Caption = 'Payment Terms Code'; }
        field(23; CompanyCurrency; code[36]) { Description = 'NAV Cust Vend Currency Code'; Caption = 'Currency Code'; }

    }

    keys
    {
        key(PK; CompanyID, NAVNITCode)
        {
            Clustered = true;
        }
    }
}