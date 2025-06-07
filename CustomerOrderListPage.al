page 50111 "Custom Order List"
{
    PageType = List;
    SourceTable = "Custom Order";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order Id"; Rec."Order Id") { }
                field("Customer Id"; Rec."Customer Id") { }
                field("Order Date"; Rec."Order Date") { }
                field("Status"; Rec."Status") { }
                field("Total Amount"; Rec."Total Amount") { }
            }
        }
    }
}