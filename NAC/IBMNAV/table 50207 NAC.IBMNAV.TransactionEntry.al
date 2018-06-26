/// This table stores all successful historical information posted from IBM
/// It is used for querying transaction duplicates received from IBM incase it is submitted twice. 
/// It is used as reference information stored against other ledger entries where by flow filters can be used to lookup info

table 50207 "NAC.IBMNAV.TransactionEntry"
{
    //DataClassification = CustomerContent;
    DataPerCompany=true;
    Description = 'This table stores all successful historical information posted from IBM';
    
    fields
    {

        /// Key Fields from IBM
        field(2;ID;Integer) { Description='ID NO'; Caption='ID No.'; Editable=false; }
        field(3;TID;Code[10]) { Description='TRN IDENTIFIER'; Caption='Transaction Code'; Editable=false; }
        field(4;SEQ;Integer) { Description='TRN SEQUENCE'; Caption='Sequence Number'; Editable=false; }
        field(5;TC;Text[10]) { Description='AMS/PF CODE'; Caption='AMS/PF Code (Not Used)'; Editable=false; }


        /// Dimensions
        field(10;DIM1;Code[20]) { Description='Shortcut Dimension 1'; Caption='Shortcut Dimension 1'; Editable=false; }
        field(11;DIM2;Code[20]) { Description='Shortcut Dimension 2'; Caption='Shortcut Dimension 2'; Editable=false; }
        field(12;DIM3;Code[20]) { Description='Shortcut Dimension 3'; Caption='Shortcut Dimension 3'; Editable=false; }
        field(13;DIM4;Code[20]) { Description='Shortcut Dimension 4'; Caption='Shortcut Dimension 4'; Editable=false; }
        field(14;DIM5;Code[20]) { Description='Shortcut Dimension 5'; Caption='Shortcut Dimension 5'; Editable=false; }
        field(15;DIM6;Code[20]) { Description='Shortcut Dimension 6'; Caption='Shortcut Dimension 6'; Editable=false; }
        field(16;DIM7;Code[20]) { Description='Shortcut Dimension 7'; Caption='Shortcut Dimension 7'; Editable=false; }
        field(17;DIM8;Code[20]) { Description='Shortcut Dimension 8'; Caption='Shortcut Dimension 8'; Editable=false; }
        
        /// Journal Fields
        field(30;DOCNO;Code[20]) { Description='TRN DOC NO'; Caption='Document No.'; Editable=false; }
        field(31;ENV;Code[5]) { Description='MRO ENV'; Caption='MRO ENV (Not Used)'; Editable=false; }
        field(32;POSTDAT;Date) { Description='POSTED DATE'; Caption='Posting Date'; Editable=false; }
        field(33;DOCDAT;Date) { Description='DOCUMENT DATE'; Caption='Document Date'; Editable=false; }
        field(34;DOCTYP;Code[20]) { Description='DOCUMENT TYPE'; Caption='Document Type'; Editable=false; }

        field(35;ACCTYP;Code[10]) { Description='ACCT TYPE'; Caption='Account Type'; Editable=false; } /// GL, CUSTOMER, VENDOR
        field(36;ACCTNO;Code[20]) { Description='ACCT NO'; Caption='Account No.'; Editable=false; }
        field(37;TRND;Text[50]) { Description='TRN DESCRIPTION'; Caption='Description'; Editable=false; }
        field(38;EXTDOC;Code[35]) { Description='EXTERNAL DOCUMENT NO'; Caption='External Document No.'; Editable=false; }

        field(40;CURR;Code[3]) { Description='CURRENCY CODE'; Caption='Currency Code'; Editable=false; } /// ZAR, AUD, EUR
        field(41;XRATE;Decimal) { Description='CURRENCY FACTOR'; Caption='Currency Factor'; Editable=false; } 
        field(42;VALUE;Decimal) { Description='TRN VALUE'; Caption='Amount'; Editable=false; } /// AMOUNT

        field(45;VATGRP;Code[10]) { Description='VAT GROUP'; Caption='VAT Product Posting Group'; Editable=false; } /// VAT PRODUCT POSTING GROUP

        field(50;TUSER;CODE[10]) { Description='TRACK USER'; Caption='TRACK USER (Not Used)'; Editable=false; }   
        field(51;TDATE;Date) { Description='TRACK DATE'; Caption='TRACK DATA (Not Used)'; Editable=false; }
        field(52;TTIME;Time) { Description='TRACK TIME'; Caption='TRACK TIME (Not Used)'; Editable=false; }

        field(60;PDF;TEXT[128]) { Description='PDF LOCATION'; Caption='PDF Location'; Editable=false; }

        field(70;ERR;Code[1]) { Description='ERROR FLAG'; Caption='ERROR FLAG (Not Used)'; Editable=false; }
        field(71;RESCD;Code[10]) { Description='RESULT CODE'; Caption='RESULT CODE (Not Used)'; Editable=false; }
    }

    keys
    {
        key(PK;ID,TID,SEQ)
        {
            Clustered = true;
        }
    }
}