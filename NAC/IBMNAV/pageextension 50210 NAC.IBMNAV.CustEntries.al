pageextension 50210 "NAC.IBMNAV.CustEntries" extends "Customer Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("NAC.IBMNAV Transaction No.";"NAC.IBMNAV Transaction No.") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Transaction Code";"NAC.IBMNAV Transaction Code") {Visible=false; Editable=false;}
            field("NAC.IBMNAV Sequence No.";"NAC.IBMNAV Sequence No.") {Visible=false; Editable=false;}
            
            field(TC; TC){ Caption = 'NAC.IBMNAV AMS/PF Code (Not Used)'; Editable = false; Visible=false;}


            /// Dimensions
            field( DIM1; DIM1) { Description = 'Shortcut Dimension 1'; Caption = 'NAC.IBMNAV Shortcut Dimension 1'; Editable = false; Visible=false;}
            field(DIM2; DIM2) { Description = 'Shortcut Dimension 2'; Caption = 'NAC.IBMNAV Shortcut Dimension 2'; Editable = false; Visible=false;}
            field( DIM3; DIM3) { Description = 'Shortcut Dimension 3'; Caption = 'NAC.IBMNAV Shortcut Dimension 3'; Editable = false; Visible=false;}
            field( DIM4; DIM4) { Description = 'Shortcut Dimension 4'; Caption = 'NAC.IBMNAV Shortcut Dimension 4'; Editable = false; Visible=false;}
            field( DIM5; DIM5) { Description = 'Shortcut Dimension 5'; Caption = 'NAC.IBMNAV Shortcut Dimension 5'; Editable = false; Visible=false;}
            field( DIM6; DIM6) { Description = 'Shortcut Dimension 6'; Caption = 'NAC.IBMNAV Shortcut Dimension 6'; Editable = false; Visible=false;}
            field( DIM7; DIM7) { Description = 'Shortcut Dimension 7'; Caption = 'NAC.IBMNAV Shortcut Dimension 7'; Editable = false; Visible=false;}
            field( DIM8; DIM8) { Description = 'Shortcut Dimension 8'; Caption = 'NAC.IBMNAV Shortcut Dimension 8'; Editable = false; Visible=false;}

            /// Journal Fields
            field( DOCNO; DOCNO) { Description = 'TRN DOC NO'; Caption = 'NAC.IBMNAV Document No.'; Editable = false; Visible=false;}
            field( ENV; ENV) { Description = 'MRO ENV'; Caption = 'NAC.IBMNAV MRO ENV (Not Used)'; Editable = false; Visible=false;}
            field( POSTDAT; POSTDAT) { Description = 'POSTED DATE'; Caption = 'NAC.IBMNAV Posting Date'; Editable = false; Visible=false;}
            field( DOCDAT; DOCDAT) { Description = 'DOCUMENT DATE'; Caption = 'NAC.IBMNAV Document Date'; Editable = false; Visible=false;}
            field( DOCTYP; DOCTYP) { Description = 'DOCUMENT TYPE'; Caption = 'NAC.IBMNAV Document Type'; Editable = false; Visible=false;}

            field( ACCTYP; ACCTNO) { Description = 'ACCT TYPE'; Caption = 'NAC.IBMNAV Account Type'; Editable = false; Visible=false;} /// GL, CUSTOMER, VENDOR
            field( ACCTNO; ACCTNO) { Description = 'ACCT NO'; Caption = 'NAC.IBMNAV Account No.'; Editable = false; Visible=false;}
            field( TRND; TRND) { Description = 'TRN DESCRIPTION'; Caption = 'NAC.IBMNAV Description'; Editable = false; Visible=false;}
            field( EXTDOC; EXTDOC) { Description = 'AMASIS DOCUMENT NO'; Caption = 'NAC.IBMNAV AMASIS Document No.'; Editable = false;Visible=false; }

            field(CURR; CURR) { Description = 'CURRENCY CODE'; Caption = 'NAC.IBMNAV Currency Code'; Editable = false; Visible=false;} /// ZAR, AUD, EUR
            field( XRATE; XRATE) { Description = 'CURRENCY FACTOR'; Caption = 'NAC.IBMNAV Currency Factor'; Editable = false; Visible=false;}
            field( VALUE; VALUE) { Description = 'TRN VALUE'; Caption = 'NAC.IBMNAV Amount'; Editable = false; Visible=false;} /// AMOUNT

            field( VATGRP; VATGRP) { Description = 'VAT GROUP'; Caption = 'NAC.IBMNAV VAT Product Posting Group'; Editable = false;Visible=false; } /// VAT PRODUCT POSTING GROUP

            field( TUSER; TUSER) { Description = 'TRACK USER'; Caption = 'NAC.IBMNAV TRACK USER (Not Used)'; Editable = false; Visible=false;}
            field( TDATE; TDATE) { Description = 'TRACK DATE'; Caption = 'NAC.IBMNAV TRACK DATA (Not Used)'; Editable = false; Visible=false;}
            field( TTIME; TTIME) { Description = 'TRACK TIME'; Caption = 'NAC.IBMNAV TRACK TIME (Not Used)'; Editable = false; Visible=false;}

            field( PDF; PDF) { Description = 'PDF LOCATION'; Caption = 'NAC.IBMNAV PDF Location'; Editable = false; Visible=false;}

            field( ERR; ERR) { Description = 'ERROR FLAG'; Caption = 'NAC.IBMNAV ERROR FLAG (Not Used)'; Editable = false; Visible=false;}
            field( RESCD; RESCD) { Description = 'RESULT CODE'; Caption = 'NAC.IBMNAV RESULT CODE (Not Used)'; Editable = false; Visible=false;}

        }
    }    
}