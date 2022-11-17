public type OrderData readonly & record {
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

public type LuckyCustomerOrderData readonly & record {
    int id;
    string city;
    int customerId;
    int productId;
    string date;
    string notes;
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

isolated service class Product {

    private final ProductData & readonly data;

    function init(ProductData data) {
        self.data = data.cloneReadOnly();
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

isolated service class Order {

    private final OrderData data;

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
