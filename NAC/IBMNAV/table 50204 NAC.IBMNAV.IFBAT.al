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
        field(2;ID;Integer) { Description='ID NO'; Caption='ID No.'; }
        field(3;TID;Code[10]) { Description='TRN IDENTIFIER'; Caption='Transaction Code'; }
        field(4;SEQ;Integer) { Description='TRN SEQUENCE'; Caption='Sequence Number'; }
        field(5;TC;Text[10]) { Description='AMS/PF CODE'; Caption='AMS/PF Code (Not Used)'; }


        /// Dimensions
        field(10;DIM1;Code[20]) { Description='Shortcut Dimension 1'; Caption='Shortcut Dimension 1'; }
        field(11;DIM2;Code[20]) { Description='Shortcut Dimension 2'; Caption='Shortcut Dimension 2'; }
        field(12;DIM3;Code[20]) { Description='Shortcut Dimension 3'; Caption='Shortcut Dimension 3'; }
        field(13;DIM4;Code[20]) { Description='Shortcut Dimension 4'; Caption='Shortcut Dimension 4'; }
        field(14;DIM5;Code[20]) { Description='Shortcut Dimension 5'; Caption='Shortcut Dimension 5'; }
        field(15;DIM6;Code[20]) { Description='Shortcut Dimension 6'; Caption='Shortcut Dimension 6'; }
        field(16;DIM7;Code[20]) { Description='Shortcut Dimension 7'; Caption='Shortcut Dimension 7'; }
        field(17;DIM8;Code[20]) { Description='Shortcut Dimension 8'; Caption='Shortcut Dimension 8'; }
        
        /// Journal Fields
        field(30;DOCNO;Code[20]) { Description='TRN DOC NO'; Caption='Document No.'; }
        field(31;ENV;Code[5]) { Description='MRO ENV'; Caption='MRO ENV (Not Used)'; }
        field(32;POSTDAT;Date) { Description='POSTED DATE'; Caption='Posting Date'; }
        field(33;DOCDAT;Date) { Description='DOCUMENT DATE'; Caption='Document Date'; }
        field(34;DOCTYP;Code[20]) { Description='DOCUMENT TYPE'; Caption='Document Type'; }

        field(35;ACCTYP;Code[10]) { Description='ACCT TYPE'; Caption='Account Type'; } /// GL, CUSTOMER, VENDOR
        field(36;ACCTNO;Code[20]) { Description='ACCT NO'; Caption='Account No.'; }
        field(37;TRND;Text[50]) { Description='TRN DESCRIPTION'; Caption='Description'; }
        field(38;EXTDOC;Code[35]) { Description='EXTERNAL DOCUMENT NO'; Caption='External Document No.'; }

        field(40;CURR;Code[3]) { Description='CURRENCY CODE'; Caption='Currency Code'; } /// ZAR, AUD, EUR
        field(41;XRATE;Decimal) { Description='CURRENCY FACTOR'; Caption='Currency Factor'; } 
        field(42;VALUE;Decimal) { Description='TRN VALUE'; Caption='Amount'; } /// AMOUNT

        field(45;VATGRP;Code[10]) { Description='VAT GROUP'; Caption='VAT Product Posting Group'; } /// VAT PRODUCT POSTING GROUP

        field(50;TUSER;CODE[10]) { Description='TRACK USER'; Caption='TRACK USER (Not Used)'; }   
        field(51;TDATE;Date) { Description='TRACK DATE'; Caption='TRACK DATA (Not Used)'; }
        field(52;TTIME;Time) { Description='TRACK TIME'; Caption='TRACK TIME (Not Used)'; }

        field(60;PDF;TEXT[128]) { Description='PDF LOCATION'; Caption='PDF Location'; }

        field(70;ERR;Code[1]) { Description='ERROR FLAG'; Caption='ERROR FLAG (Not Used)'; }
        field(71;RESCD;Code[10]) { Description='RESULT CODE'; Caption='RESULT CODE (Not Used)'; }

    }

    keys
    {
        key(PK;ID,TID,SEQ)
        {
            Clustered = true;
        }
    }   
}