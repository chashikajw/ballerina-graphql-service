import ballerina/http;


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

function getOrderData(int id) returns OrderData {

    OrderData orderData = {
        id: 1,
        customerId: 1,
        productId: 1,
        date: "2022/11/16",
        notes: "1st order"
    };

    return orderData;
}

function getCustomerData(int id) returns CustomerData|error {

    CustomerData customerData = {
        id: 1,
        name: "Smith",
        city: "Colombo"
    };

    return customerData;
}

function getProductData(int id) returns ProductData|error {

    ProductData productData = {
        id: 1,
        name: "Watch 123",
        description: "Rolex watch"
    };

    return productData;
}

service / on new http:Listener(8085) {

    resource function get getOrder/[int orderId]() returns json|error {
        OrderData|error orderData = getOrderData(orderId);
        if orderData is error {
            return error("Invalid order id");
        } else {
            json orderDataJsonResponse = orderData.toJson();
            return orderDataJsonResponse;
        }
    }

    resource function get getCustomer/[int customerId]() returns json|error {
        CustomerData|error customerData = getCustomerData(customerId);
        if customerData is error {
            return error("Invalid customer id");
        } else {
            json orderDataJsonResponse = customerData.toJson();
            return orderDataJsonResponse;
        }
    }

    resource function get getProduct/[int productId]() returns json|error {
        ProductData|error productData = getProductData(productId);
        if productData is error {
            return error("Invalid product id");
        } else {
            json shipperDataJsonResponse = productData.toJson();
            return shipperDataJsonResponse;
        }
    }

    resource function post createOrder(@http:Payload OrderData orderData)
                                returns json {

        return {
            id: orderData.id,
            customerId: orderData.customerId,
            productId: orderData.productId,
            date: orderData.date,
            notes: orderData.notes
        };
    }
}
