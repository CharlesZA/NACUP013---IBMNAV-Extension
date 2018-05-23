/// This xmlport is used to import information sent from IBM into nav

xmlport 50203 "NAC.IBMNAV.IFBATXMLP"
{
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Description='This xmlport is used to import information sent from IBM into nav';
    UseRequestPage=false;

    schema
    {
        textelement(Root)
        {
            tableelement(IFBAT; "NAC.IBMNAV.IFBAT")
            {
                fieldelement(ID;IFBAT.ID){}
                fieldelement(TID;IFBAT.TID){}
                fieldelement(SEQ;IFBAT.SEQ){}
                fieldelement(TC;IFBAT.TC){}
                fieldelement(DIM1;IFBAT.DIM1){}
                fieldelement(DIM2;IFBAT.DIM2){}
                fieldelement(DIM3;IFBAT.DIM3){}
                fieldelement(DIM4;IFBAT.DIM4){}
                fieldelement(DIM5;IFBAT.DIM5){}
                fieldelement(DIM6;IFBAT.DIM6){}
                fieldelement(DIM7;IFBAT.DIM7){}
                fieldelement(DIM8;IFBAT.DIM8){}
                fieldelement(DOCNO;IFBAT.DOCNO) {}
                fieldelement(ENV;IFBAT.ENV){}
                fieldelement(POSTDAT;IFBAT.POSTDAT){}
                fieldelement(DOCDAT;IFBAT.DOCDAT){}
                fieldelement(DOCTYP;IFBAT.DOCTYP){}
                fieldelement(ACCTYP;IFBAT.ACCTYP){}
                fieldelement(ACCTNO;IFBAT.ACCTNO){}
                fieldelement(TRND;IFBAT.TRND){}
                fieldelement(EXTDOC;IFBAT.EXTDOC){}
                fieldelement(CURR;IFBAT.CURR){}
                fieldelement(XRATE;IFBAT.XRATE){}
                fieldelement(VALUE;IFBAT.VALUE){}
                fieldelement(VATGRP;IFBAT.VATGRP){}
                fieldelement(TUSER;IFBAT.TUSER){}
                fieldelement(TDATE;IFBAT.TDATE){}
                fieldelement(TTIME;IFBAT.TTIME){}
                fieldelement(PDF;IFBAT.PDF){}
                fieldelement(ERR;IFBAT.ERR){}
                fieldelement(RESCD;IFBAT.RESCD){}
            }
        }
    }
}