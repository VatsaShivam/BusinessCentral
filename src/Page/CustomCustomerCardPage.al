page 50110 "Custom Customer Card"
{
    PageType = Card;
    SourceTable = "Custom Customer";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer Id"; Rec."Customer Id") { }
                field("Name"; Rec."Name") { }
                field("Email"; Rec."Email") { }
                field("Phone"; Rec."Phone") { }
                field("Date of Birth"; Rec."Date of Birth") { }
                field("Loyalty Points"; Rec."Loyalty Points") { }
                field("Preferred Language"; Rec."Preferred Language") { }
            }
            group(Address)
            {
                field("Street"; Rec."Street") { }
                field("City"; Rec."City") { }
                field("State"; Rec."State") { }
                field("Postal Code"; Rec."Postal Code") { }
                field("Country"; Rec."Country") { }
            }
            group(BillingAddress)
            {
                field("Billing Street"; Rec."Billing Street") { }
                field("Billing City"; Rec."Billing City") { }
                field("Billing State"; Rec."Billing State") { }
                field("Billing Postal Code"; Rec."Billing Postal Code") { }
                field("Billing Country"; Rec."Billing Country") { }
            }
        }
    }
}
