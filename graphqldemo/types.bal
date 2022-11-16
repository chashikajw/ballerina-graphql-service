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
