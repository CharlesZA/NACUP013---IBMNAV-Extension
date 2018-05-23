/// Displays information to be or sent to IBM

page 50205 "NAC.IBMNAV.IFRETList"
{
    PageType = List;
    SourceTable = "NAC.IBMNAV.IFRET";
    UsageCategory = Lists;
    Caption = 'NAC.IBMNAV IBM Return File Information';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID;ID) {}
                field(TID;TID) {}
                field(SEQ;SEQ) {}
                
                field(RESCD;RESCD) {}
                field(RESDS;RESDS) {}
                field(DATE;DATE) {}
                field(TIME;TIME) {}
            }
        }
    }
}