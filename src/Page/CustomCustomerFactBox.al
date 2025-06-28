page 50114 "Custom Customer FactBox"
{
    PageType = CardPart;
    SourceTable = "Custom Customer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Customer Id"; Rec."Customer Id")
            {
                TableRelation = "Custom Customer";
            }
            field("Loyalty Points"; Rec."Loyalty Points") { }
            field("Preferred Language"; Rec."Preferred Language") { }
        }
    }
}