# ballerina-graphql-service

## prerequisite
1. Install the ballerina 
    - https://ballerina.io/learn/install-ballerina/set-up-ballerina/
2. Install the VS code extenstion
    - https://marketplace.visualstudio.com/items?itemName=WSO2.ballerina

3. Download the API Manager
    - https://wso2.com/api-manager/

## Steps to excute the solution

1. Start the backend (Clone the repo and go to the root. Then run the follwing command.)
    ```
    bal run restbackend
    ```
2. Start the API Manager

3. Create 3 APIs in the API Manager

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

4. Start the GraphqlService and RestServicce
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

## References

1. Provide values to configurable variables
    - https://ballerina.io/learn/configure-ballerina-programs/provide-values-to-configurable-variables/



2. A client, which is secured with OAuth2
    - https://ballerina.io/learn/by-example/http-client-oauth2-client-credentials-grant-type/


3. OAuth2 client credentials grant configurations for OAuth2 authentication
    - https://lib.ballerina.io/ballerina/http/latest/records/OAuth2ClientCredentialsGrantConfig





4. Create GraphQL API in the API Manager
    - https://apim.docs.wso2.com/en/latest/tutorials/create-and-publish-a-graphql-api/#step-2-design-a-graphql-api