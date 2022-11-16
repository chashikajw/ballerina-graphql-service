import ballerina/graphql;
import ballerina/http;

# The Order, Customer, Product API base URL
string apiUrl = "http://localhost:8085";

public type OrderData record {
    int id;
    int customerId;
    int productId;
    string date;
    string notes;
};

public type CustomerData record {
    int id;
    string name;
    string city;
};

public type ProductData record {
    int id;
    string name;
    string description;
};

service class Customer {

    private CustomerData data;

    function init(CustomerData data) {
        self.data = data;
    }

    resource function get id() returns int {
        return self.data.id;
    }

    resource function get name() returns string {
        return self.data.name;
    }

    resource function get city() returns string {
        return self.data.city;
    }
}

service class Product {

    private ProductData data;

    function init(ProductData data) {
        self.data = data;
    } 

    resource function get id() returns int {
        return self.data.id;
    }

    resource function get name() returns string {
        return self.data.name;
    }

    resource function get description() returns string {
        return self.data.description;
    }
}

service class Order {

    private OrderData data;

    function init(OrderData data) {
        self.data = data;
    }

    resource function get id() returns int {
        return self.data.id;
    }

    resource function get notes() returns string {
        return self.data.notes;
    }

    resource function get date() returns string {
        return self.data.date;
    }

    resource function get customer() returns Customer|error {
        return check loadCustomer(self.data.customerId);
    }

    resource function get product() returns Product|error {
        return check loadProduct(self.data.productId);
    }
}

service /graphql on new graphql:Listener(8080) {

    resource function get 'order(int id) returns Order|error => loadOrder(id);

    resource function get 'customer(int id) returns Customer|error => loadCustomer(id);

    resource function get 'product(int id) returns Product|error => loadProduct(id);

    remote function createOrderForLuckyCustomer(string city) returns Order|error {

        CustomerData|error luckyCustomer = getCustomer(1);
        ProductData|error promotionalProduct = getProduct(1);

        if (luckyCustomer is CustomerData && promotionalProduct is ProductData) {
            Order|error luckyCustomerOrder = createOrder(luckyCustomer, promotionalProduct);
            return luckyCustomerOrder;
        } else {
            return error(string `Order creation failed`);
        }

    }

}

function loadOrder(int id) returns Order|error {

    http:Client backendClient = check new(apiUrl);
    string path = "/getOrder/" + id.toString();

    OrderData orderDataResponse = check backendClient->get(path);
    int|error orderId = <int> orderDataResponse.id;

    if (orderId is int) { 
        return new Order(orderDataResponse);
    } else {
        return error(string `Invalid order: ${id}`);
    }
}


function loadCustomer(int id) returns Customer|error {

    CustomerData|error customerDataResponse = getCustomer(id);
    if (customerDataResponse is CustomerData) { 
        return new Customer(customerDataResponse);
    } else {
        return error(string `Invalid customer: ${id}`);
    }
}

function getCustomer(int id) returns CustomerData|error {

    http:Client backendClient = check new(apiUrl);
    string path = "/getCustomer/" + id.toString();

    CustomerData customerDataResponse = check backendClient->get(path);
    int|error customerId = <int> customerDataResponse.id;

    if (customerId is int) { 
        return customerDataResponse;
    } else {
        return error(string `Invalid customer: ${id}`);
    }
}

function loadProduct(int id) returns Product|error {

    ProductData|error productDataResponse = getProduct(id);

    if (productDataResponse is ProductData) { 
        return new Product(productDataResponse);
    } else {
        return error(string `Invalid product: ${id}`);
    }
}

function getProduct(int id) returns ProductData|error {

    http:Client backendClient = check new(apiUrl);
    string path = "/getProduct/" + id.toString();

    ProductData productDataResponse = check backendClient->get(path);
    int|error productId = <int> productDataResponse.id;

    if (productId is int) { 
        return productDataResponse;
    } else {
        return error(string `Invalid product: ${id}`);
    }
}


function createOrder(CustomerData customer, ProductData product) returns Order|error {

    http:Client backendClient = check new(apiUrl);
    string path = "/createOrder";

    json payload = { "id": 2, "customerId": customer.id, "productId": product.id, "date": "2022/11/17", "notes": "Texas luckyCustomer order"};

    OrderData orderDataResponse = check backendClient->post(path, payload);

    int|error orderId = <int> orderDataResponse.id;

    if (orderId is int) { 
        return new Order(orderDataResponse);
    } else {
        return error(string `Order creation failed`);
    }
}