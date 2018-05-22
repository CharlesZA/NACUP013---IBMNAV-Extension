/// This xmlport is used to import information sent from IBM into nav

xmlport 50203 "NAC.IBMNAV.IFBATXMLP"
{
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<TAB>';
    FieldSeparator = '<None>';
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Description='This xmlport is used to import information sent from IBM into nav';

    schema
    {
        textelement(Root)
        {
            tableelement(IFBAT; "NAC.IBMNAV.IFBAT")
            {
                fieldelement(IBID;IFBAT.IBID) {}
                fieldelement(IBTID;IFBAT.IBTID) {}
                fieldelement(IBSEQ;IFBAT.IBSEQ){}
                fieldelement(IBTC;IFBAT.IBTC){}

                fieldelement(IBDIM1;IFBAT.IBDIM1){}
                fieldelement(IBDIM2;IFBAT.IBDIM2){}
                fieldelement(IBDIM3;IFBAT.IBDIM3){}
                fieldelement(IBDIM4;IFBAT.IBDIM4){}
                fieldelement(IBDIM5;IFBAT.IBDIM5){}
                fieldelement(IBDIM6;IFBAT.IBDIM6){}
                fieldelement(IBDIM7;IFBAT.IBDIM7){}
                fieldelement(IBDIM8;IFBAT.IBDIM8){}

                fieldelement(IBDOCNO;IFBAT.IBDOCNO) {}
                fieldelement(IBENV;IFBAT.IBENV){}
                fieldelement(IBPOSTDAT;IFBAT.IBPOSTDAT){}
                fieldelement(IBDOCDAT;IFBAT.IBDOCDAT){}
                fieldelement(IBACCTYP;IFBAT.IBACCTYP){}
                fieldelement(IBACCTNO;IFBAT.IBACCTNO){}
                fieldelement(IBTRND;IFBAT.IBTRND){}
                fieldelement(IBEXTDOC;IFBAT.IBEXTDOC){}
                fieldelement(IBCURR;IFBAT.IBCURR){}
                fieldelement(IBXRATE;IFBAT.IBXRATE){}
                fieldelement(IBVALUE;IFBAT.IBVALUE){}
                fieldelement(IBVATGRP;IFBAT.IBVATGRP){}
                fieldelement(IBTUSER;IFBAT.IBTUSER){}
                fieldelement(IBTDATE;IFBAT.IBTDATE){}
                fieldelement(IBTTIME;IFBAT.IBTTIME){}
                fieldelement(IBERR;IFBAT.IBERR){}
                fieldelement(IBRESCD;IFBAT.IBRESCD){}
            }
        }
    }
}