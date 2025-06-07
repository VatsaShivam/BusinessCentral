codeunit 50100 "Import&ExportJsonFile"
{
    trigger OnRun()
    begin

    end;

    procedure GetOrderJson(OrderId: Code[20]): Text
    var
        OrderRec: Record "Custom Order";
        CustomerRec: Record "Custom Customer";
        OrderLineRec: Record "Custom Order Line";
        JsonObj: JsonObject;
        CustomerObj: JsonObject;
        OrderObj: JsonObject;
        ShippingObj: JsonObject;
        ProductsArr: JsonArray;
        ProductObj: JsonObject;
        TotalAmount: Decimal;
        AddressObj: JsonObject;
        BillingAddrObj: JsonObject;
        ShipAddrObj: JsonObject;
        JsonText: Text;
    begin
        if not OrderRec.Get(OrderId) then
            exit('');

        if CustomerRec.Get(OrderRec."Customer Id") then begin
            CustomerObj.Add('customerId', CustomerRec."Customer Id");
            CustomerObj.Add('name', CustomerRec.Name);
            CustomerObj.Add('email', CustomerRec.Email);
            CustomerObj.Add('phone', CustomerRec.Phone);
            CustomerObj.Add('dateOfBirth', Format(CustomerRec."Date of Birth"));
            CustomerObj.Add('loyaltyPoints', CustomerRec."Loyalty Points");
            CustomerObj.Add('preferredLanguage', CustomerRec."Preferred Language");


            AddressObj.Add('street', CustomerRec.Street);
            AddressObj.Add('city', CustomerRec.City);
            AddressObj.Add('state', CustomerRec.State);
            AddressObj.Add('postalCode', CustomerRec."Postal Code");
            AddressObj.Add('country', CustomerRec.Country);
            CustomerObj.Add('address', AddressObj);

            BillingAddrObj.Add('street', CustomerRec."Billing Street");
            BillingAddrObj.Add('city', CustomerRec."Billing City");
            BillingAddrObj.Add('state', CustomerRec."Billing State");
            BillingAddrObj.Add('postalCode', CustomerRec."Billing Postal Code");
            BillingAddrObj.Add('country', CustomerRec."Billing Country");
            CustomerObj.Add('billingAddress', BillingAddrObj);
        end;

        TotalAmount := 0;
        OrderLineRec.SetRange("Order Id", OrderId);
        if OrderLineRec.FindSet() then
            repeat
                Clear(ProductObj);
                ProductObj.Add('productId', OrderLineRec."Product Id");
                ProductObj.Add('productName', OrderLineRec."Product Name");
                ProductObj.Add('quantity', OrderLineRec.Quantity);
                ProductObj.Add('unitPrice', OrderLineRec."Unit Price");
                ProductObj.Add('totalPrice', OrderLineRec."Total Price");
                ProductObj.Add('sku', OrderLineRec.SKU);
                ProductObj.Add('category', OrderLineRec.Category);
                ProductObj.Add('brand', OrderLineRec.Brand);
                ProductsArr.Add(ProductObj);
                TotalAmount += OrderLineRec."Total Price";
            until OrderLineRec.Next() = 0;

        ShippingObj.Add('method', OrderRec."Shipping Method");
        ShippingObj.Add('cost', OrderRec."Shipping Cost");
        ShippingObj.Add('trackingNumber', OrderRec."Shipping Tracking Number");
        ShippingObj.Add('carrier', OrderRec."Shipping Carrier");
        ShippingObj.Add('estimatedDelivery', Format(OrderRec."Shipping Estimated Delivery"));

        ShipAddrObj.Add('street', OrderRec."Shipping Street");
        ShipAddrObj.Add('city', OrderRec."Shipping City");
        ShipAddrObj.Add('state', OrderRec."Shipping State");
        ShipAddrObj.Add('postalCode', OrderRec."Shipping Postal Code");
        ShipAddrObj.Add('country', OrderRec."Shipping Country");
        ShippingObj.Add('address', ShipAddrObj);

        OrderObj.Add('orderId', OrderRec."Order Id");
        OrderObj.Add('orderDate', Format(OrderRec."Order Date"));
        OrderObj.Add('status', Format(OrderRec.Status));
        OrderObj.Add('totalAmount', TotalAmount);
        OrderObj.Add('currency', OrderRec.Currency);
        OrderObj.Add('paymentMethod', OrderRec."Payment Method");
        OrderObj.Add('discount', OrderRec.Discount);
        OrderObj.Add('taxAmount', OrderRec."Tax Amount");
        OrderObj.Add('notes', OrderRec.Notes);
        OrderObj.Add('products', ProductsArr);
        OrderObj.Add('shipping', ShippingObj);

        JsonObj.Add('customer', CustomerObj);
        JsonObj.Add('order', OrderObj);

        JsonObj.WriteTo(JsonText);
        exit(JsonText);
    end;

    procedure ImportOrderFromJson(JsonText: Text)
    var
        JsonObj, CustomerObj, OrderObj, AddressObj, BillingAddrObj, ShippingObj, ShipAddrObj : JsonObject;
        CustomerToken, AddressToken, BillingAddrToken, OrderToken, ShippingToken, ShipAddrToken, ProductArrToken : JsonToken;
        ProductsArr: JsonArray;
        ProductObj: JsonObject;
        CustomerRec: Record "Custom Customer";
        OrderRec: Record "Custom Order";
        OrderLineRec: Record "Custom Order Line";
        i, LineNo : Integer;
        StatusOption: Option Open,Confirmed,Shipped,Closed;
    begin
        if not JsonObj.ReadFrom(JsonText) then
            Error('Invalid JSON format.');

        if JsonObj.Get('customer', CustomerToken) then begin
            CustomerObj := CustomerToken.AsObject();
            Clear(CustomerRec);
            CustomerRec.Init();
            CustomerRec.Validate("Customer Id", CustomerObj.GetText('customerId'));
            CustomerRec.Validate("Name", CustomerObj.GetText('name'));
            CustomerRec.Validate("Email", CustomerObj.GetText('email'));
            CustomerRec.Validate("Phone", CustomerObj.GetText('phone'));
            CustomerRec.Validate("Date of Birth", CustomerObj.GetDate('dateOfBirth'));
            CustomerRec.Validate("Loyalty Points", CustomerObj.GetInteger('loyaltyPoints'));
            CustomerRec.Validate("Preferred Language", CustomerObj.GetText('preferredLanguage'));


            if CustomerObj.Get('address', AddressToken) then begin
                AddressObj := AddressToken.AsObject();
                CustomerRec.Validate("Street", AddressObj.GetText('street'));
                CustomerRec.Validate("City", AddressObj.GetText('city'));
                CustomerRec.Validate("State", AddressObj.GetText('state'));
                CustomerRec.Validate("Postal Code", AddressObj.GetText('postalCode'));
                CustomerRec.Validate("Country", AddressObj.GetText('country'));
            end;


            if CustomerObj.Get('billingAddress', BillingAddrToken) then begin
                BillingAddrObj := BillingAddrToken.AsObject();
                CustomerRec.Validate("Billing Street", BillingAddrObj.GetText('street'));
                CustomerRec.Validate("Billing City", BillingAddrObj.GetText('city'));
                CustomerRec.Validate("Billing State", BillingAddrObj.GetText('state'));
                CustomerRec.Validate("Billing Postal Code", BillingAddrObj.GetText('postalCode'));
                CustomerRec.Validate("Billing Country", BillingAddrObj.GetText('country'));
            end;

            if not CustomerRec.Insert(true) then
                CustomerRec.Modify(true);
        end;


        if JsonObj.Get('order', OrderToken) then begin
            OrderObj := OrderToken.AsObject();
            Clear(OrderRec);
            OrderRec.Init();
            OrderRec.Validate("Order Id", OrderObj.GetText('orderId'));
            OrderRec.Validate("Customer Id", CustomerRec."Customer Id");
            OrderRec.Validate("Order Date", OrderObj.GetDate('orderDate'));


            case LowerCase(OrderObj.GetText('status')) of
                'open':
                    OrderRec.Validate(Status, 0);
                'confirmed':
                    OrderRec.Validate(Status, 1);
                'shipped':
                    OrderRec.Validate(Status, 2);
                'closed':
                    OrderRec.Validate(Status, 3);
            end;

            OrderRec.Validate("Total Amount", OrderObj.GetDecimal('totalAmount'));
            OrderRec.Validate("Currency", OrderObj.GetText('currency'));
            OrderRec.Validate("Payment Method", OrderObj.GetText('paymentMethod'));
            OrderRec.Validate("Discount", OrderObj.GetDecimal('discount'));
            OrderRec.Validate("Tax Amount", OrderObj.GetDecimal('taxAmount'));
            OrderRec.Validate("Notes", OrderObj.GetText('notes'));


            if OrderObj.Get('shipping', ShippingToken) then begin
                ShippingObj := ShippingToken.AsObject();
                OrderRec.Validate("Shipping Method", ShippingObj.GetText('method'));
                OrderRec.Validate("Shipping Cost", ShippingObj.GetDecimal('cost'));
                OrderRec.Validate("Shipping Tracking Number", ShippingObj.GetText('trackingNumber'));
                OrderRec.Validate("Shipping Carrier", ShippingObj.GetText('carrier'));
                OrderRec.Validate("Shipping Estimated Delivery", ShippingObj.GetDate('estimatedDelivery'));
                if ShippingObj.Get('address', ShipAddrToken) then begin
                    ShipAddrObj := ShipAddrToken.AsObject();
                    OrderRec.Validate("Shipping Street", ShipAddrObj.GetText('street'));
                    OrderRec.Validate("Shipping City", ShipAddrObj.GetText('city'));
                    OrderRec.Validate("Shipping State", ShipAddrObj.GetText('state'));
                    OrderRec.Validate("Shipping Postal Code", ShipAddrObj.GetText('postalCode'));
                    OrderRec.Validate("Shipping Country", ShipAddrObj.GetText('country'));
                end;
            end;

            if not OrderRec.Insert(true) then
                OrderRec.Modify(true);

            if OrderObj.Get('products', ProductArrToken) then begin
                ProductsArr := ProductArrToken.AsArray();
                LineNo := 1;
                for i := 0 to ProductsArr.Count() - 1 do begin
                    ProductsArr.Get(i, ProductArrToken);
                    ProductObj := ProductArrToken.AsObject();
                    Clear(OrderLineRec);
                    OrderLineRec.Init();
                    OrderLineRec.Validate("Order Id", OrderRec."Order Id");
                    OrderLineRec.Validate("Line Id", LineNo);
                    OrderLineRec.Validate("Product Id", ProductObj.GetText('productId'));
                    OrderLineRec.Validate("Product Name", ProductObj.GetText('productName'));
                    OrderLineRec.Validate("Quantity", ProductObj.GetInteger('quantity'));
                    OrderLineRec.Validate("Unit Price", ProductObj.GetDecimal('unitPrice'));
                    OrderLineRec.Validate("Total Price", ProductObj.GetDecimal('totalPrice'));
                    OrderLineRec.Validate("SKU", ProductObj.GetText('sku'));
                    OrderLineRec.Validate("Category", ProductObj.GetText('category'));
                    OrderLineRec.Validate("Brand", ProductObj.GetText('brand'));
                    OrderLineRec.Insert(true);
                    LineNo += 1;
                end;
            end;
        end;
    end;
}