import ballerina/http;

configurable string tokenUrl = "https://localhost:9443/oauth2/token";
configurable string clientId = "qxklSKGyCKQRkB4L1s75NmQwzyEa";
configurable string clientSecret = "M1NAtXw1Ptr8GWgVHxtARa1J4MIa";

// Use client credentials grant type to generate token

final http:Client productAPISecuredEP = check new ("https://localhost:8243/productapi/1.0.0",
    auth = {
    tokenUrl: tokenUrl,
    clientId: clientId,
    clientSecret: clientSecret,
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

final http:Client customerAPISecuredEP = check new ("https://localhost:8243/customerapi/1.0.0",
    auth = {
    tokenUrl: tokenUrl,
    clientId: clientId,
    clientSecret: clientSecret,
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

final http:Client orderAPISecuredEP = check new ("https://localhost:8243/orderapi/1.0.0",
    auth = {
    tokenUrl: tokenUrl,
    clientId: clientId,
    clientSecret: clientSecret,
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

