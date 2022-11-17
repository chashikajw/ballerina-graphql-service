import ballerina/http;

string tokenUrl = "https://localhost:9443/oauth2/token";
string clientId = "r01AoY53rdj0_M9oIbhuPZTpfv4a";
string clientSecret = "rK3U2eSmrtFfP62fFj3YCBK53F0a";

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

