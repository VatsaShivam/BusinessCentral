table 50101 "Custom Order"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Order Id"; Code[20]) { DataClassification = CustomerContent; }
        field(2; "Customer Id"; Code[20])
        {
            TableRelation = "Custom Customer"."Customer Id";
            DataClassification = CustomerContent;
        }
        field(3; "Order Date"; Date) { DataClassification = CustomerContent; }
        field(4; "Status"; Option)
        {
            OptionMembers = Open,Confirmed,Shipped,Closed;
            DataClassification = CustomerContent;
        }
        field(5; "Total Amount"; Decimal) { DataClassification = CustomerContent; }
        field(6; "Currency"; Code[10]) { DataClassification = CustomerContent; }
        field(7; "Payment Method"; Text[30]) { DataClassification = CustomerContent; }
        field(8; "Discount"; Decimal) { DataClassification = CustomerContent; }
        field(9; "Tax Amount"; Decimal) { DataClassification = CustomerContent; }
        field(10; "Notes"; Text[250]) { DataClassification = CustomerContent; }
        field(11; "Shipping Method"; Text[30]) { DataClassification = CustomerContent; }
        field(12; "Shipping Cost"; Decimal) { DataClassification = CustomerContent; }
        field(13; "Shipping Tracking Number"; Text[50]) { DataClassification = CustomerContent; }
        field(14; "Shipping Carrier"; Text[50]) { DataClassification = CustomerContent; }
        field(15; "Shipping Estimated Delivery"; Date) { DataClassification = CustomerContent; }
        field(16; "Shipping Street"; Text[100]) { DataClassification = CustomerContent; }
        field(17; "Shipping City"; Text[50]) { DataClassification = CustomerContent; }
        field(18; "Shipping State"; Text[50]) { DataClassification = CustomerContent; }
        field(19; "Shipping Postal Code"; Text[20]) { DataClassification = CustomerContent; }
        field(20; "Shipping Country"; Text[50]) { DataClassification = CustomerContent; }
    }
    keys
    {
        key(PK; "Order Id") { Clustered = true; }
    }
}