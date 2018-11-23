/// This table is the representation of the batch file from the IBM Server for NAV
/// Field naming is kept similar as on the IBM server for clarity

table 50213 "NAC.IBMNAV.IFXRATE"
{
    //DataClassification = CustomerContent;
    DataPerCompany = false;
    Description = 'This table represents the data batch file received from IBM after it has been imported';

    fields
    {
        field(1; BASECURRENCY; code[10]) { Description = 'Base Currency Code'; Caption = 'Base Currency Code'; }
        field(2; CURRENCY; code[10]) { Description = 'Currency Code'; Caption = 'Currency Code'; }

        field(10; RATE; Decimal) { Description = 'Exchange Rate'; Caption = 'Exchange Rate'; }
        field(11; UPDDATE; Date) { Description = 'Exchange Rate Starting Date'; Caption = 'Starting Date'; }
        field(12; UPDTIME; Time) { Description = 'Exchange Rate Starting Time'; Caption = 'Starting Time'; }

    }

    keys
    {
        key(PK; BASECURRENCY, CURRENCY, UPDDATE)
        {
            Clustered = true;
        }
    }
}