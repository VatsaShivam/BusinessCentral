table 50102 "Custom Order Line"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Line Id"; Integer) { DataClassification = CustomerContent; }
        field(2; "Order Id"; Code[20]) { DataClassification = CustomerContent; }
        field(3; "Product Id"; Code[20]) { DataClassification = CustomerContent; }
        field(4; "Product Name"; Text[100]) { DataClassification = CustomerContent; }
        field(5; "Quantity"; Integer) { DataClassification = CustomerContent; }
        field(6; "Unit Price"; Decimal) { DataClassification = CustomerContent; }
        field(7; "Total Price"; Decimal) { DataClassification = CustomerContent; }
        field(8; "SKU"; Code[20]) { DataClassification = CustomerContent; }
        field(9; "Category"; Text[50]) { DataClassification = CustomerContent; }
        field(10; "Brand"; Text[50]) { DataClassification = CustomerContent; }
    }
    keys
    {
        key(PK; "Order Id", "Line Id") { Clustered = true; }
    }
}