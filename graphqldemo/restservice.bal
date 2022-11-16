import ballerina/http;

service / on new http:Listener(8088) {

    resource function post createOrderForLuckyCustomer(@http:Payload string city)
                                returns json|error {

        ProductData|error productDataResponse = check productAPISecuredEP->get("/getProduct/1");
        CustomerData|error customerDataResponse = check customerAPISecuredEP->get("/getCustomer/1");

        if (productDataResponse is ProductData && customerDataResponse is CustomerData) {
            json payload = {"id": 2, "customerId": customerDataResponse.id, "productId": productDataResponse.id, "date": "2022/11/17", "notes": "luckyCustomer order"};

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
