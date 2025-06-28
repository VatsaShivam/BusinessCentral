page 50113 "Custom Order Line Subpage"
{
    PageType = ListPart;
    SourceTable = "Custom Order Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Id"; Rec."Product Id") { }
                field("Product Name"; Rec."Product Name") { }
                field("Quantity"; Rec."Quantity") { }
                field("Unit Price"; Rec."Unit Price") { }
                field("Total Price"; Rec."Total Price") { }
                field("SKU"; Rec."SKU") { }
                field("Category"; Rec."Category") { }
                field("Brand"; Rec."Brand") { }
            }
        }
    }
}