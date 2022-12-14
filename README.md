# ballerina-service-orchestration

We are using the ballerina since Ballerina has first-class support for a lot of different network protocols such as HTTP, GraphQL, Websocket, gRPC, etc.

## prerequisite
1. Install the ballerina 
    - https://ballerina.io/learn/install-ballerina/set-up-ballerina/
2. Install the VS code extenstion
    - https://marketplace.visualstudio.com/items?itemName=WSO2.ballerina

3. Download the API Manager
    - https://wso2.com/api-manager/

## Solution
![Solution](https://github.com/chashikajw/ballerina-graphql-service/blob/main/images/Solution.png)

## Steps to excute the solution

1. Start the backend (Clone the repo and go to the root. Then run the follwing command.)
    ```
    bal run restbackend
    ```
2. Start the API Manager

3. Create 3 APIs in the API Manager and deploy

    - CustomerAPI
        - Context: /customerapi
        - Version: 1.0.0
        - Endpoint: http://localhost:8085
        - Resources
         - GET - customers/{id}
    - ProductAPI
        - Context: /productapi
        - Version: 1.0.0
        - Endpoint: http://localhost:8085
        - Resources
            - GET - products/{id}
    - OrderAPI
        - Context: /orderapi
        - Version: 1.0.0
        - Endpoint: http://localhost:8085
        - Resources
            - GET - products/{id}
            - POST - order
4. Create a application in devportal and subscribe to the API.

5. Start the GraphqlService and RestServicce
    ```
    bal run graphqldemo
    ```
- REST Sevice:
    - orderForLuckyCustomer(POST)
        ```
        curl --request POST 'http://localhost:8088/orderForLuckyCustomer' \
        -d 'Colombo'
        ```
- GraphQL Sevice:
    - GetOrderDeails with the customer and product details(Query)
        ```
        curl -X POST -H "Content-type: application/json" -d '{ "query": "{ order(id: 1) { notes, date, customer { name }, product { name } } }" }' 'http://localhost:8089/graphql'
        ```
   - createOrderForLuckyCustomer(Mutation)
        ```
        curl -X POST -H "Content-type: application/json" -d '{ "query": "mutation { orderForLuckyCustomer(city: \"Mr. Lambert\") {     notes, date } }" }' 'http://localhost:8089/graphql'
        ```

6. Expose newly created REST API in the API Manager

    - CusomizedAPI
        - Context: /customizedAPI
        - Version: 1.0.0
        - Endpoint: http://localhost:8088
        - Resources
            - POST - orderForLuckyCustomer

7. Expose newly created GraphQL API in the API Manager

    - CusomizedAPI
        - Shema (Located in resources folder)
        - Context: /LuckyCustomerOrder
        - Version: 1.0.0
        - Endpoint: http://localhost:8089/graphql



## References

1. Provide values to configurable variables
    - https://ballerina.io/learn/configure-ballerina-programs/provide-values-to-configurable-variables/



2. A client, which is secured with OAuth2
    - https://ballerina.io/learn/by-example/http-client-oauth2-client-credentials-grant-type/


3. OAuth2 client credentials grant configurations for OAuth2 authentication
    - https://lib.ballerina.io/ballerina/http/latest/records/OAuth2ClientCredentialsGrantConfig

4. Create REST Services using Ballerina
    - https://ballerina.io/learn/write-a-restful-api-with-ballerina/

5.  Create a GraphQL service using Ballerina
    - https://ballerina.io/learn/write-a-graphql-api-with-ballerina/

6. Create GraphQL API in the API Manager
    - https://apim.docs.wso2.com/en/latest/tutorials/create-and-publish-a-graphql-api/#step-2-design-a-graphql-api