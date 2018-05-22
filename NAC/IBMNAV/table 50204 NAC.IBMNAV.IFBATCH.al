/// This table is the representation of the batch file from the IBM Server for NAV
/// Field naming is kept the same as on the IBM server for clarity


table 50204 "NAC.IBMNAV.IFBATCH"
{
    DataClassification = CustomerContent;
    DataPerCompany=true;
    Description = 'This table represents the data batch file received from IBM after it has been imported'
    
    fields
    {

        /// Key Fields from IBM
        field(1;IBREC;Text[20]) { Description='BATCH REC'; }
        field(2;IBID;Integer) { Description='ID NO'; }
        field(3;IBTID;Code[10]) { Description='TRN IDENTIFIER'; }
        field(4;IBSEQ;Integer) { Description='TRN SEQUENCE'; }
        field(5;IBTC;Text[10]) { Description='AMS/PF CODE'; }


        /// Dimensions
        field(10;IBMDIM1;Code[20]) { Description='Shortcut Dimension 1'; }
        field(11;IBMDIM2;Code[20]) { Description='Shortcut Dimension 2'; }
        field(12;IBMDIM3;Code[20]) { Description='Shortcut Dimension 3'; }
        field(13;IBMDIM4;Code[20]) { Description='Shortcut Dimension 4'; }
        field(14;IBMDIM5;Code[20]) { Description='Shortcut Dimension 5'; }
        field(15;IBMDIM6;Code[20]) { Description='Shortcut Dimension 6'; }
        field(16;IBMDIM7;Code[20]) { Description='Shortcut Dimension 7'; }
        field(17;IBMDIM8;Code[20]) { Description='Shortcut Dimension 8'; }
        
        /// Journal Fields
        field(30;IBDOCNO;Code[20]) { Description='TRN DOC NO'; }
        field(31;IBENV;Code[5]) { Description='MRO ENV'; }
        field(32;IBPOSTDAT;Date) { Description='POSTED DATE'; }
        field(33;IBDOCDAT;Date) { Description='DOCUMENT DATE'; }

        field(35;IBACCTYP;Code[10]) { Description='ACCT TYPE'; } /// GL, CUSTOMER, VENDOR
        field(36;IBACCTNO;Code[20]) { Description='ACCT NO'; }
        field(37;IBTRND;Text[50]) { Description='TRN DESCRIPTION'; }
        field(38;IBEXTDOC;Code[20]) { Description='EXTERNAL DOCUMENT NO'; }

        field(40;IBCURR;Code[3]) { Description='CURRENCY CODE'; } /// ZAR, AUD, EUR
        field(41;IBXRATE;Decimal) { Description='CURRENCY FACTOR'; } 
        field(42;IBVALUE;Decimal) { Description='TRN VALUE'; } /// AMOUNT

        field(45;IBVATGRP;Code[10]) { Description='VAT GROUP'; } /// VAT PRODUCT POSTING GROUP

        field(50;IBTUSER;CODE[10]) { Description='TRACK USER'; }   
        field(51;IBTDATE;Date) { Description='TRACK DATE'; }
        field(52;IBTTIME;Time) { Description='TRACK TIME'; }

        field(60;IBPDF;TEXT[128]) { Description='PDF LOCATION'; }

        field(70;IBERR;Code[1]) { Description='ERROR FLAG'; }
        field(71;IBRESCD;Code[10]) { Description='RESULT CODE'; }

    }

    keys
    {
        key(PK;IBID,IBTID,IBSEQ)
        {
            Clustered = true;
        }
    }
    
}