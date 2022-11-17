import ballerina/graphql;

service /graphql on new graphql:Listener(8089) {

    resource function get 'order(int id) returns Order|error => loadOrder(id);

    resource function get 'customer(int id) returns Customer|error => loadCustomer(id);

    resource function get 'product(int id) returns Product|error => loadProduct(id);

    remote function createOrderForLuckyCustomer(string city) returns Order|error {

        CustomerData|error luckyCustomer = check customerAPISecuredEP->get("/getCustomer/1");
        ProductData|error promotionalProduct = check productAPISecuredEP->get("/getProduct/1");

        if (luckyCustomer is CustomerData && promotionalProduct is ProductData) {

            json payload = {"id": 2, "customerId": luckyCustomer.id, "productId": promotionalProduct.id, "date": "2022/11/17", "notes": "luckyCustomer order"};
            OrderData|error luckyCustomerOrder = check orderAPISecuredEP->post("/createOrder", payload);

            if (luckyCustomerOrder is OrderData) {
                return new Order(luckyCustomerOrder);
            } else {
                return error(string `Lucky customer Order creation failed`);
            }

        } else {
            return error(string `lucky customer order creation failed while retreiving data: ${city}`);
        }

    }

}

function loadOrder(int id) returns Order|error {

    string path = "/getOrder/" + id.toString();
    OrderData orderDataResponse = check orderAPISecuredEP->get(path);
    int|error orderId = <int>orderDataResponse.id;

    if (orderId is int) {
        return new Order(orderDataResponse);
    } else {
        return error(string `Invalid order: ${id}`);
    }
}

function loadCustomer(int id) returns Customer|error {

    string path = "/getCustomer/" + id.toString();
    CustomerData customerDataResponse = check customerAPISecuredEP->get(path);
    int|error customerId = <int>customerDataResponse.id;

    if (customerId is int) {
        return new Customer(customerDataResponse);
    } else {
        return error(string `Invalid customer: ${id}`);
    }
}

function loadProduct(int id) returns Product|error {

    string path = "/getProduct/" + id.toString();
    ProductData productDataResponse = check productAPISecuredEP->get(path);
    int|error productId = <int>productDataResponse.id;

    if (productId is int) {
        return new Product(productDataResponse);
    } else {
        return error(string `Invalid product: ${id}`);
    }
}
