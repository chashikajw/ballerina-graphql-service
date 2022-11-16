import ballerina/graphql;


service /graphql on new graphql:Listener(8089) {

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

    OrderData|error orderDataResponse = getOrder(id);
    if (orderDataResponse is OrderData) { 
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


function loadProduct(int id) returns Product|error {

    ProductData|error productDataResponse = getProduct(id);

    if (productDataResponse is ProductData) { 
        return new Product(productDataResponse);
    } else {
        return error(string `Invalid product: ${id}`);
    }
}
