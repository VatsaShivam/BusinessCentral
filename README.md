# Business Central Order JSON Integration

AL procedures to export and import detailed order data in JSON format in Microsoft Dynamics 365 Business Central. 

# 1. Export Order as JSON
Procedure: GetOrderJson(OrderId: Code): Text

# Description:
Generates a comprehensive JSON object for a given order, including:

Customer details (contact info, addresses, loyalty, etc.)

Order header info (date, status, payment, totals, notes)

Order line details (products, pricing, SKU, brand, category)

Shipping information (method, carrier, tracking, address)

# 2.Import Order from JSON
Procedure: ImportOrderFromJson(JsonText: Text)

# Description:
Parses a JSON object representing an order and inserts or updates:

Customer master data (with addresses)

Order header

Order lines (products)

Shipping details
