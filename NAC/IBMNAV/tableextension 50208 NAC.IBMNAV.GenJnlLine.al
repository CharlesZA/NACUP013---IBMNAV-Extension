/// Extension to table to store transaction reference information related to table NAC.IBMNAV.TransactionEntry

tableextension 50208 "NAC.IBMNAV.GenJnlLine" extends "Gen. Journal Line"
{
    Description='Extension to table to store transaction reference information related to table NAC.IBMNAV.TransactionEntry';
    
    fields
    {
        field(50201; "NAC.IBMNAV Transaction No."; Integer) 
        {
            Editable=false;
            Caption='IBM Transaction No.';
        }
        field(50202;"NAC.IBMNAV Transaction Code";code[10])
        {
            Editable=false;
            Caption='IBM Transaction Code';
        }
        field(50203; "NAC.IBMNAV Sequence No.";Integer)
        {
            Editable=false;
            Caption='IBM Sequence No.';
        }
        field(50205; TC; Text[10]) { Description = 'AMS/PF CODE'; Caption = 'AMS/PF Code (Not Used)'; Editable = false; }

                /// Dimensions
        field(50210; DIM1; Code[20]) { Description = 'Shortcut Dimension 1'; Caption = 'Shortcut Dimension 1'; Editable = false; }
        field(50211; DIM2; Code[20]) { Description = 'Shortcut Dimension 2'; Caption = 'Shortcut Dimension 2'; Editable = false; }
        field(50212; DIM3; Code[20]) { Description = 'Shortcut Dimension 3'; Caption = 'Shortcut Dimension 3'; Editable = false; }
        field(50213; DIM4; Code[20]) { Description = 'Shortcut Dimension 4'; Caption = 'Shortcut Dimension 4'; Editable = false; }
        field(50214; DIM5; Code[20]) { Description = 'Shortcut Dimension 5'; Caption = 'Shortcut Dimension 5'; Editable = false; }
        field(50215; DIM6; Code[20]) { Description = 'Shortcut Dimension 6'; Caption = 'Shortcut Dimension 6'; Editable = false; }
        field(50216; DIM7; Code[20]) { Description = 'Shortcut Dimension 7'; Caption = 'Shortcut Dimension 7'; Editable = false; }
        field(50217; DIM8; Code[20]) { Description = 'Shortcut Dimension 8'; Caption = 'Shortcut Dimension 8'; Editable = false; }

        /// Journal Fields
        field(50230; DOCNO; Code[20]) { Description = 'TRN DOC NO'; Caption = 'Document No.'; Editable = false; }
        field(50231; ENV; Code[5]) { Description = 'MRO ENV'; Caption = 'MRO ENV (Not Used)'; Editable = false; }
        field(50232; POSTDAT; Date) { Description = 'POSTED DATE'; Caption = 'Posting Date'; Editable = false; }
        field(50233; DOCDAT; Date) { Description = 'DOCUMENT DATE'; Caption = 'Document Date'; Editable = false; }
        field(50234; DOCTYP; Code[20]) { Description = 'DOCUMENT TYPE'; Caption = 'Document Type'; Editable = false; }

        field(50235; ACCTYP; Code[10]) { Description = 'ACCT TYPE'; Caption = 'Account Type'; Editable = false; } /// GL, CUSTOMER, VENDOR
        field(50236; ACCTNO; Code[20]) { Description = 'ACCT NO'; Caption = 'Account No.'; Editable = false; }
        field(50237; TRND; Text[50]) { Description = 'TRN DESCRIPTION'; Caption = 'Description'; Editable = false; }
        field(50238; EXTDOC; Code[35]) { Description = 'AMASIS DOCUMENT NO'; Caption = 'AMASIS Document No.'; Editable = false; }

        field(5020; CURR; Code[3]) { Description = 'CURRENCY CODE'; Caption = 'Currency Code'; Editable = false; } /// ZAR, AUD, EUR
        field(50241; XRATE; Decimal) { Description = 'CURRENCY FACTOR'; Caption = 'Currency Factor'; Editable = false; }
        field(50242; VALUE; Decimal) { Description = 'TRN VALUE'; Caption = 'Amount'; Editable = false; } /// AMOUNT

        field(50245; VATGRP; Code[10]) { Description = 'VAT GROUP'; Caption = 'VAT Product Posting Group'; Editable = false; } /// VAT PRODUCT POSTING GROUP

        field(50250; TUSER; CODE[10]) { Description = 'TRACK USER'; Caption = 'TRACK USER (Not Used)'; Editable = false; }
        field(50251; TDATE; Date) { Description = 'TRACK DATE'; Caption = 'TRACK DATA (Not Used)'; Editable = false; }
        field(50252; TTIME; Time) { Description = 'TRACK TIME'; Caption = 'TRACK TIME (Not Used)'; Editable = false; }

        field(50260; PDF; TEXT[128]) { Description = 'PDF LOCATION'; Caption = 'PDF Location'; Editable = false; }

        field(50270; ERR; Code[1]) { Description = 'ERROR FLAG'; Caption = 'ERROR FLAG (Not Used)'; Editable = false; }
        field(50271; RESCD; Code[10]) { Description = 'RESULT CODE'; Caption = 'RESULT CODE (Not Used)'; Editable = false; }

    }
    
}