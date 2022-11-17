import ballerina/http;

service / on new http:Listener(8088) {

    resource function post orderForLuckyCustomer(@http:Payload string city)
                                returns LuckyCustomerOrderData|error {
                               
        CustomerData luckyCustomer = check customerAPISecuredEP->get("/customers/1");
        ProductData promotionalProduct = check productAPISecuredEP->get("/products/1");

        json payload = {"id": 2, "customerId": luckyCustomer.id, "productId": promotionalProduct.id, "date": "2022/11/17", "notes": "luckyCustomer order"};

        OrderData|error orderDataResponse = orderAPISecuredEP->post("/order", payload);

        if (orderDataResponse is OrderData) {
            LuckyCustomerOrderData  luckyCustomerOrderData = {
                id: orderDataResponse.id,
                city: city,
                date: orderDataResponse.date,
                notes: orderDataResponse.notes,
                customerId: orderDataResponse.customerId,
                productId: orderDataResponse.productId
            };

            return luckyCustomerOrderData;
        } else {
            return error(string `lucky customer order creation failed: ${city}`);
        }
    }
}
