/// Displays information to be or sent to IBM

page 50205 "NAC.IBMNAV.IFRETList"
{
    PageType = List;
    SourceTable = "NAC.IBMNAV.IFRET";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IRID;IRID) {}
                field(IRTID;IRTID) {}
                field(IRSEQ;IRSEQ) {}
                
                field(IRRESCD;IRRESCD) {}
                field(IRRESDS;IRRESDS) {}
                field(IRDATE;IRDATE) {}
                field(IRTIME;IRTIME) {}
            }
        }
    }
}