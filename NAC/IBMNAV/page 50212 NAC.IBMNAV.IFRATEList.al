page 50212 "NAC.IBMNAV.IFXRATEList"
{

    PageType = List;
    SourceTable = "NAC.IBMNAV.IFXRATE";
    Caption = 'NAC.IBMNAV.IFXRATEList';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("BASECURRENCY"; "BASECURRENCY")
                {
                    ApplicationArea = All;
                }
                field("CURRENCY"; "CURRENCY")
                {
                    ApplicationArea = All;
                }
                field("RATE"; "RATE")
                {
                    ApplicationArea = All;
                }
                field("UPDDATE"; "UPDDATE")
                {
                    ApplicationArea = All;
                }
                field("UPDTIME"; "UPDTIME")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
