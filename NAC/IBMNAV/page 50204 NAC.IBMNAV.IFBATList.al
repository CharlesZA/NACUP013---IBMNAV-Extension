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
                field(IBID;IBID) {  }
                field(IBTID;IBTID) {}
                field(IBSEQ;IBSEQ) {}
                field(IBTC;IBTC) {}

                field(IBDIM1;IBDIM1) {}
                field(IBDIM2;IBDIM2) {}
                field(IBDIM3;IBDIM3) {}
                field(IBDIM4;IBDIM4) {}
                field(IBDIM5;IBDIM5) {}
                field(IBDIM6;IBDIM6) {}
                field(IBDIM7;IBDIM7) {}
                field(IBDIM8;IBDIM8) {}

                field(IBDOCNO;IBDOCNO) {}
                field(IBENV;IBENV) {}
                field(IBPOSTDAT;IBPOSTDAT) {}
                field(IBDOCDAT;IBDOCDAT) {}
                field(IBACCTYP;IBACCTYP) {}
                field(IBACCTNO;IBACCTNO) {}
                field(IBTRND;IBTRND) {}
                field(IBEXTDOC;IBEXTDOC) {}
                field(IBCURR;IBCURR) {}
                field(IBXRATE;IBXRATE) {}
                field(IBVALUE;IBVALUE) {}
                field(IBVATGRP;IBVATGRP) {}
                field(IBTUSER;IBTUSER) {}
                field(IBTDATE;IBTDATE) {}
                field(IBTTIME;IBTTIME) {}
                field(IBERR;IBERR) {}
                field(IBRESCD;IBRESCD) {}
            }
        }
    }

}