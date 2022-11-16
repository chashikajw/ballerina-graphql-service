import ballerina/http;

configurable string tokenUrl = "https://localhost:9443/oauth2/token";
configurable string clientId = "qxklSKGyCKQRkB4L1s75NmQwzyEa";
configurable string clientSecret = "M1NAtXw1Ptr8GWgVHxtARa1J4MIa";

// Use client credentials grant type to generate token

http:Client productAPISecuredEP = check new ("https://localhost:8243/productapi/1.0.0",
    auth = {
    tokenUrl: tokenUrl,
    clientId: clientId,
    clientSecret: clientSecret,
    defaultTokenExpTime: 10,
    clientConfig: {
        secureSocket: {
            cert: "graphqldemo/resources/public.crt"
        }
    }
},
        secureSocket = {
    cert: "graphqldemo/resources/public.crt"
}
);

http:Client customerAPISecuredEP = check new ("https://localhost:8243/customerapi/1.0.0",
    auth = {
    tokenUrl: tokenUrl,
    clientId: clientId,
    clientSecret: clientSecret,
    defaultTokenExpTime: 10,
    clientConfig: {
        secureSocket: {
            cert: "graphqldemo/resources/public.crt"
        }
    }
},
        secureSocket = {
    cert: "graphqldemo/resources/public.crt"
}
);

http:Client orderAPISecuredEP = check new ("https://localhost:8243/orderapi/1.0.0",
    auth = {
    tokenUrl: tokenUrl,
    clientId: clientId,
    clientSecret: clientSecret,
    defaultTokenExpTime: 10,
    clientConfig: {
        secureSocket: {
            cert: "graphqldemo/resources/public.crt"
        }
    }
},
        secureSocket = {
    cert: "graphqldemo/resources/public.crt"
}
);

function getProduct(int id) returns ProductData|error {

    string path = "/getProduct/" + id.toString();

    ProductData productDataResponse = check productAPISecuredEP->get(path);
    int|error productId = <int>productDataResponse.id;

    if (productId is int) {
        return productDataResponse;
    } else {
        return error(string `Invalid product: ${id}`);
    }
}

function getCustomer(int id) returns CustomerData|error {

    string path = "/getCustomer/" + id.toString();

    CustomerData customerDataResponse = check customerAPISecuredEP->get(path);
    int|error customerId = <int>customerDataResponse.id;

    if (customerId is int) {
        return customerDataResponse;
    } else {
        return error(string `Invalid customer: ${id}`);
    }
}

function getOrder(int id) returns OrderData|error {

    string path = "/getOrder/" + id.toString();

    OrderData orderDataResponse = check orderAPISecuredEP->get(path);
    int|error orderId = <int>orderDataResponse.id;

    if (orderId is int) {
        return orderDataResponse;
    } else {
        return error(string `Invalid order: ${id}`);
    }
}

function createOrder(CustomerData customer, ProductData product) returns Order|error {

    string path = "/createOrder";

    json payload = {"id": 2, "customerId": customer.id, "productId": product.id, "date": "2022/11/17", "notes": "Texas luckyCustomer order"};

    OrderData orderDataResponse = check orderAPISecuredEP->post(path, payload);

    int|error orderId = <int>orderDataResponse.id;

    if (orderId is int) {
        return new Order(orderDataResponse);
    } else {
        return error(string `Order creation failed`);
    }
}
