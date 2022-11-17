import ballerina/http;

service / on new http:Listener(8088) {

    resource function post createOrderForLuckyCustomer(@http:Payload string city)
                                returns json|error {

        CustomerData|error luckyCustomer = check customerAPISecuredEP->get("/getCustomer/1");
        ProductData|error promotionalProduct = check productAPISecuredEP->get("/getProduct/1");

        if (promotionalProduct is ProductData && luckyCustomer is CustomerData) {
            json payload = {"id": 2, "customerId": luckyCustomer.id, "productId": promotionalProduct.id, "date": "2022/11/17", "notes": "luckyCustomer order"};

            OrderData|error orderDataResponse = check orderAPISecuredEP->post("/createOrder", payload);

            if (orderDataResponse is OrderData) {
                return {
                    id: orderDataResponse.id,
                    city: city,
                    customerId: orderDataResponse.customerId,
                    productId: orderDataResponse.productId,
                    date: orderDataResponse.date,
                    notes: orderDataResponse.notes
                };
            } else {
                return error(string `lucky customer order creation failed: ${city}`);
            }

        } else {
            return error(string `lucky customer order creation failed while retreiving data: ${city}`);
        }

    }
}
