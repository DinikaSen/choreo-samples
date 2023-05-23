import ballerina/http;
import ballerina/log;
import wso2/choreo.sendsms;


type Request record {|
    string toNumber;
    string message;
|};

sendsms:Client sendSmsClient = check new ();

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    resource function post sendSMS(@http:Payload Request payload) returns string|error {

        log:printInfo(payload.toJsonString());
        string response = check sendSmsClient -> sendSms(payload.toNumber, payload.message);
        log:printInfo(response);
        if (response == "queued") {
            return "200";
        }
        return response;
    }
}

