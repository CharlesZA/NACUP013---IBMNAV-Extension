/// This table is the representation of the batch file from the IBM Server for NAV
/// Field naming is kept similar as on the IBM server for clarity


table 50204 "NAC.IBMNAV.IFBAT"
{
    //DataClassification = CustomerContent;
    DataPerCompany=true;
    Description = 'This table represents the data batch file received from IBM after it has been imported';
    
    fields
    {

        /// Key Fields from IBM
        field(2;ID;Integer) { Description='ID NO'; }
        field(3;TID;Code[10]) { Description='TRN IDENTIFIER'; }
        field(4;SEQ;Integer) { Description='TRN SEQUENCE'; }
        field(5;TC;Text[10]) { Description='AMS/PF CODE'; }


        /// Dimensions
        field(10;DIM1;Code[20]) { Description='Shortcut Dimension 1'; }
        field(11;DIM2;Code[20]) { Description='Shortcut Dimension 2'; }
        field(12;DIM3;Code[20]) { Description='Shortcut Dimension 3'; }
        field(13;DIM4;Code[20]) { Description='Shortcut Dimension 4'; }
        field(14;DIM5;Code[20]) { Description='Shortcut Dimension 5'; }
        field(15;DIM6;Code[20]) { Description='Shortcut Dimension 6'; }
        field(16;DIM7;Code[20]) { Description='Shortcut Dimension 7'; }
        field(17;DIM8;Code[20]) { Description='Shortcut Dimension 8'; }
        
        /// Journal Fields
        field(30;DOCNO;Code[20]) { Description='TRN DOC NO'; }
        field(31;ENV;Code[5]) { Description='MRO ENV'; }
        field(32;POSTDAT;Date) { Description='POSTED DATE'; }
        field(33;DOCDAT;Date) { Description='DOCUMENT DATE'; }
        field(34;DOCTYP;Code[20]) { Description='DOCUMENT TYPE'; }

        field(35;ACCTYP;Code[10]) { Description='ACCT TYPE'; } /// GL, CUSTOMER, VENDOR
        field(36;ACCTNO;Code[20]) { Description='ACCT NO'; }
        field(37;TRND;Text[50]) { Description='TRN DESCRIPTION'; }
        field(38;EXTDOC;Code[20]) { Description='EXTERNAL DOCUMENT NO'; }

        field(40;CURR;Code[3]) { Description='CURRENCY CODE'; } /// ZAR, AUD, EUR
        field(41;XRATE;Decimal) { Description='CURRENCY FACTOR'; } 
        field(42;VALUE;Decimal) { Description='TRN VALUE'; } /// AMOUNT

        field(45;VATGRP;Code[10]) { Description='VAT GROUP'; } /// VAT PRODUCT POSTING GROUP

        field(50;TUSER;CODE[10]) { Description='TRACK USER'; }   
        field(51;TDATE;Date) { Description='TRACK DATE'; }
        field(52;TTIME;Time) { Description='TRACK TIME'; }

        field(60;PDF;TEXT[128]) { Description='PDF LOCATION'; }

        field(70;ERR;Code[1]) { Description='ERROR FLAG'; }
        field(71;RESCD;Code[10]) { Description='RESULT CODE'; }

    }

    keys
    {
        key(PK;ID,TID,SEQ)
        {
            Clustered = true;
        }
    }
    
}