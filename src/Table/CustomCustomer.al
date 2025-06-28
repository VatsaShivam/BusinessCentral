table 50100 "Custom Customer"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Customer Id"; Code[20]) { DataClassification = CustomerContent; }
        field(2; "Name"; Text[100]) { DataClassification = CustomerContent; }
        field(3; "Email"; Text[100]) { DataClassification = CustomerContent; }
        field(4; "Phone"; Text[30]) { DataClassification = CustomerContent; }
        field(5; "Date of Birth"; Date) { DataClassification = CustomerContent; }
        field(6; "Loyalty Points"; Integer) { DataClassification = CustomerContent; }
        field(7; "Preferred Language"; Text[30]) { DataClassification = CustomerContent; }
        field(8; "Street"; Text[100]) { DataClassification = CustomerContent; }
        field(9; "City"; Text[50]) { DataClassification = CustomerContent; }
        field(10; "State"; Text[50]) { DataClassification = CustomerContent; }
        field(11; "Postal Code"; Text[20]) { DataClassification = CustomerContent; }
        field(12; "Country"; Text[50]) { DataClassification = CustomerContent; }
        field(13; "Billing Street"; Text[100]) { DataClassification = CustomerContent; }
        field(14; "Billing City"; Text[50]) { DataClassification = CustomerContent; }
        field(15; "Billing State"; Text[50]) { DataClassification = CustomerContent; }
        field(16; "Billing Postal Code"; Text[20]) { DataClassification = CustomerContent; }
        field(17; "Billing Country"; Text[50]) { DataClassification = CustomerContent; }
    }
    keys
    {
        key(PK; "Customer Id") { Clustered = true; }
    }
}
