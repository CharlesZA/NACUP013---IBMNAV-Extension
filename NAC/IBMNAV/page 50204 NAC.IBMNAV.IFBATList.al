/// Displays IBM Batch Transactions


page 50204 "NAC.IBMNAV.IFBATList"
{
    PageType = List;
    SourceTable = "NAC.IBMNAV.IFBAT";
    UsageCategory = Lists;
    Caption='NAC.IBMNAV IBM Batch Information';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID;ID) {  }
                field(TID;TID) {}
                field(SEQ;SEQ) {}
                field(TC;TC) {}

                field(DIM1;DIM1) {}
                field(DIM2;DIM2) {}
                field(DIM3;DIM3) {}
                field(DIM4;DIM4) {}
                field(DIM5;DIM5) {}
                field(DIM6;DIM6) {}
                field(DIM7;DIM7) {}
                field(DIM8;DIM8) {}

                field(DOCNO;DOCNO) {}
                field(ENV;ENV) {}
                field(POSTDAT;POSTDAT) {}
                field(DOCDAT;DOCDAT) {}
                field(DOCTYP;DOCTYP) {}
                field(ACCTYP;ACCTYP) {}
                field(ACCTNO;ACCTNO) {}
                field(TRND;TRND) {}
                field(EXTDOC;EXTDOC) {}
                field(CURR;CURR) {}
                field(XRATE;XRATE) {}
                field(VALUE;VALUE) {}
                field(VATGRP;VATGRP) {}
                field(TUSER;TUSER) {}
                field(TDATE;TDATE) {}
                field(TTIME;TTIME) {}
                field(ERR;ERR) {}
                field(RESCD;RESCD) {}
            }
        }
    }

}