pageextension 50211 "NAC.IBMNAV.VendEntries" extends "Vendor Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("NAC.IBMNAV Transaction No.";"NAC.IBMNAV Transaction No.") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Transaction Code";"NAC.IBMNAV Transaction Code") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Sequence No.";"NAC.IBMNAV Sequence No.") {Visible=false; Editable=false;}

            field(TC; TC){ Caption = 'AMS/PF Code (Not Used)'; Editable = false; Visible=false;}


            /// Dimensions
            field( DIM1; DIM1) { Description = 'Shortcut Dimension 1'; Caption = 'Shortcut Dimension 1'; Editable = false; Visible=false;}
            field(DIM2; DIM2) { Description = 'Shortcut Dimension 2'; Caption = 'Shortcut Dimension 2'; Editable = false; Visible=false;}
            field( DIM3; DIM3) { Description = 'Shortcut Dimension 3'; Caption = 'Shortcut Dimension 3'; Editable = false; Visible=false;}
            field( DIM4; DIM4) { Description = 'Shortcut Dimension 4'; Caption = 'Shortcut Dimension 4'; Editable = false; Visible=false;}
            field( DIM5; DIM5) { Description = 'Shortcut Dimension 5'; Caption = 'Shortcut Dimension 5'; Editable = false; Visible=false;}
            field( DIM6; DIM6) { Description = 'Shortcut Dimension 6'; Caption = 'Shortcut Dimension 6'; Editable = false; Visible=false;}
            field( DIM7; DIM7) { Description = 'Shortcut Dimension 7'; Caption = 'Shortcut Dimension 7'; Editable = false; Visible=false;}
            field( DIM8; DIM8) { Description = 'Shortcut Dimension 8'; Caption = 'Shortcut Dimension 8'; Editable = false; Visible=false;}

            /// Journal Fields
            field( DOCNO; DOCNO) { Description = 'TRN DOC NO'; Caption = 'Document No.'; Editable = false; Visible=false;}
            field( ENV; ENV) { Description = 'MRO ENV'; Caption = 'MRO ENV (Not Used)'; Editable = false; Visible=false;}
            field( POSTDAT; POSTDAT) { Description = 'POSTED DATE'; Caption = 'Posting Date'; Editable = false; Visible=false;}
            field( DOCDAT; DOCDAT) { Description = 'DOCUMENT DATE'; Caption = 'Document Date'; Editable = false; Visible=false;}
            field( DOCTYP; DOCTYP) { Description = 'DOCUMENT TYPE'; Caption = 'Document Type'; Editable = false; Visible=false;}

            field( ACCTYP; ACCTNO) { Description = 'ACCT TYPE'; Caption = 'Account Type'; Editable = false; Visible=false;} /// GL, CUSTOMER, VENDOR
            field( ACCTNO; ACCTNO) { Description = 'ACCT NO'; Caption = 'Account No.'; Editable = false; Visible=false;}
            field( TRND; TRND) { Description = 'TRN DESCRIPTION'; Caption = 'Description'; Editable = false; Visible=false;}
            field( EXTDOC; EXTDOC) { Description = 'AMASIS DOCUMENT NO'; Caption = 'AMASIS Document No.'; Editable = false;Visible=false; }

            field(CURR; CURR) { Description = 'CURRENCY CODE'; Caption = 'Currency Code'; Editable = false; Visible=false;} /// ZAR, AUD, EUR
            field( XRATE; XRATE) { Description = 'CURRENCY FACTOR'; Caption = 'Currency Factor'; Editable = false; Visible=false;}
            field( VALUE; VALUE) { Description = 'TRN VALUE'; Caption = 'Amount'; Editable = false; Visible=false;} /// AMOUNT

            field( VATGRP; VATGRP) { Description = 'VAT GROUP'; Caption = 'VAT Product Posting Group'; Editable = false;Visible=false; } /// VAT PRODUCT POSTING GROUP

            field( TUSER; TUSER) { Description = 'TRACK USER'; Caption = 'TRACK USER (Not Used)'; Editable = false; Visible=false;}
            field( TDATE; TDATE) { Description = 'TRACK DATE'; Caption = 'TRACK DATA (Not Used)'; Editable = false; Visible=false;}
            field( TTIME; TTIME) { Description = 'TRACK TIME'; Caption = 'TRACK TIME (Not Used)'; Editable = false; Visible=false;}

            field( PDF; PDF) { Description = 'PDF LOCATION'; Caption = 'PDF Location'; Editable = false; Visible=false;}

            field( ERR; ERR) { Description = 'ERROR FLAG'; Caption = 'ERROR FLAG (Not Used)'; Editable = false; Visible=false;}
            field( RESCD; RESCD) { Description = 'RESULT CODE'; Caption = 'RESULT CODE (Not Used)'; Editable = false; Visible=false;}

        }
    }    
}