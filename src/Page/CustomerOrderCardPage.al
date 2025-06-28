page 50112 "Custom Order Card"
{
    PageType = Document;
    SourceTable = "Custom Order";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Order Id"; Rec."Order Id") { }
                field("Customer Id"; Rec."Customer Id") { }
                field("Order Date"; Rec."Order Date") { }
                field("Status"; Rec."Status") { }
                field("Currency"; Rec."Currency") { }
                field("Payment Method"; Rec."Payment Method") { }
                field("Discount"; Rec."Discount") { }
                field("Tax Amount"; Rec."Tax Amount") { }
                field("Notes"; Rec."Notes") { }
            }
            group(Shipping)
            {
                field("Shipping Method"; Rec."Shipping Method") { }
                field("Shipping Cost"; Rec."Shipping Cost") { }
                field("Shipping Tracking Number"; Rec."Shipping Tracking Number") { }
                field("Shipping Carrier"; Rec."Shipping Carrier") { }
                field("Shipping Estimated Delivery"; Rec."Shipping Estimated Delivery") { }
                field("Shipping Street"; Rec."Shipping Street") { }
                field("Shipping City"; Rec."Shipping City") { }
                field("Shipping State"; Rec."Shipping State") { }
                field("Shipping Postal Code"; Rec."Shipping Postal Code") { }
                field("Shipping Country"; Rec."Shipping Country") { }
            }
            part(OrderLines; "Custom Order Line Subpage")
            {
                SubPageLink = "Order Id" = FIELD("Order Id");
            }
        }
        area(factboxes)
        {
            part(CustomerFactbox; "Custom Customer FactBox")
            {
                SubPageLink = "Customer Id" = FIELD("Customer Id");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ExportOrderAsJson)
            {
                Caption = 'Export Order as JSON';
                Image = Export;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    JsonText: Text;
                    OutStr: OutStream;
                    InStr: InStream;
                    FileName: Text;
                    MimeType: Text;
                // MyJsonObject: JsonObject;
                begin
                    JsonText := ImportExportCU.GetOrderJson(Rec."Order Id");
                    TempBlob.CreateOutStream(OutStr);
                    OutStr.WriteText(JsonText);
                    TempBlob.CreateInStream(InStr);

                    FileName := 'Order_' + Rec."Order Id" + Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2><Hours24,2><Minutes,2><Seconds,2>') + '.json';
                    MimeType := 'application/json';
                    DownloadFromStream(InStr, '', '', MimeType, FileName);
                end;
            }

            action(ImportOrderFromJson1)
            {
                Caption = 'Import Order from JSON';
                Image = Import;
                trigger OnAction()
                var
                    InStream: InStream;
                    OutStream: OutStream;
                    JsonText: Text;
                    Filename: Text;
                    TempBlob: Codeunit "Temp Blob";
                begin
                    if UploadIntoStream('Select JSON file', '', 'JSON files|*.json', Filename, InStream) then begin
                        TempBlob.CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        TempBlob.CreateInStream(InStream);
                        InStream.ReadText(JsonText);
                        ImportExportCU.ImportOrderFromJson(JsonText);
                        Message('Import completed. File: %1', Filename);
                    end else
                        Message('File upload was cancelled or failed.');
                end;
            }
            action(ParseXmlToValidField)
            {
                Caption = 'Parse from XML';
                Image = Action;
                trigger OnAction()
                var
                    ResponseText: Text;
                    ParseXML: Codeunit ParseXmlCodeunit;
                begin
                    ResponseText :=
                        '<Customers>' +
                        '  <Customer>' +
                        '    <No>CUS001</No>' +
                        '    <Name>Shivam Mishra</Name>' +
                        '    <Address>123 Business St</Address>' +
                        '    <Address2>Suite 100</Address2>' +
                        '    <City>Hyderabad</City>' +
                        '    <PostCode>10001</PostCode>' +
                        '    <CountryRegionCode>India</CountryRegionCode>' +
                        '    <Contact>mukesh yadav</Contact>' +
                        '    <PhoneNo>+91 123-345-6789</PhoneNo>' +
                        '    <Email>mukesh.yadav@abccorp.com</Email>' +
                        '    <ServiceStatus>Accepted</ServiceStatus>' +
                        '    <ServiceStartDate>2024-06-01</ServiceStartDate>' +
                        '  </Customer>' +
                        '  <Customer>' +
                        '    <No>CUS002</No>' +
                        '    <Name>Rahul Singh</Name>' +
                        '    <Address>456 Trade Ave</Address>' +
                        '    <Address2>Floor 2</Address2>' +
                        '    <City>Lucknow</City>' +
                        '    <PostCode>20002</PostCode>' +
                        '    <CountryRegionCode>India</CountryRegionCode>' +
                        '    <Contact>Mili Dev</Contact>' +
                        '    <PhoneNo>+91 123-7123 4567</PhoneNo>' +
                        '    <Email>mili.dev@xyzltd.com</Email>' +
                        '    <ServiceStatus>Pending</ServiceStatus>' +
                        '    <ServiceStartDate>2024-06-15</ServiceStartDate>' +
                        '  </Customer>' +
                        '</Customers>';

                    ParseXML.ParseAllFieldsFromXml(ResponseText);
                end;
            }
            action(CreateUserInAPI)
            {
                Caption = 'Create User';
                trigger OnAction()
                var
                    JsonSample: Codeunit "Json Learning";
                begin
                    JsonSample.CreateUserInAPI();
                end;
            }
        }
    }

    var
        ImportExportCU: Codeunit "Import&ExportJsonFile";
}
