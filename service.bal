import ballerina/log;
//import ballerinax/health.hl7v2;
import ballerinax/mysql;
import ballerina/sql;
//import ballerinax/health.hl7v23;
//import ballerina/uuid;
import ballerina/http;
import ballerinax/mysql.driver as _;

configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string db = ?;
configurable int port = ?;

final string msg = string `MSH|^~\\&|ADT1|GOOD HEALTH HOSPITAL|GHH LAB, INC.|GOOD HEALTH HOSPITAL|
198808181126|SECURITY|ADT^A01^ADT_A01|MSG00001|P|2.3||${"\r"}EVN|A01|200708181123||
${"\r"}PID|1||PATID1234^5^M11^ADT1^MR^GOOD HEALTH HOSPITAL~123456789^^^USSSA^SS||
BATMAN^ADAM^A^III||19610615|M||C|2222 HOME STREET^^GREENSBORO^NC^27401-1020|GL|
(555) 555-2004|(555)555-2004||S||PATID12345001^2^M10^ADT1^AN^A|444333333|987654^NC|
${"\r"}NK1|1|NUCLEAR^NELDA^W|SPO^SPOUSE||||NK^NEXT OF KIN${"\r"}PV1|1|I|2000^2012^01||||
004777^ATTEND^AARON^A|||SUR||||ADM|A0|`;

service / on new http:Listener(8000) {
    resource function post message(@http:Payload string data) returns string|error {
        log:printInfo("Received HL7 Message: ", data = data);

        // Note: When you know the message type you can directly get it parsed.
        // hl7v23:QRY_A19|error parsedMsg = hl7v2:parse(data).ensureType(hl7v23:QRY_A19);
        // if parsedMsg is error {
        //     return error("Error occurred while parsing the received message", parsedMsg);
        // }
        // log:printInfo("Parsed HL7 message:" + parsedMsg.toString());

        mysql:Client|error mySqlClient = new (host, username, password, db, port, connectionPool = {maxOpenConnections: 3});
        if mySqlClient is error {
            return error("Error occurred while creating the MySQL client", mySqlClient);
        }
        sql:ParameterizedQuery query = `INSERT INTO hl7_data (data) values (${msg.toJsonString()})`;
        sql:ExecutionResult|sql:Error result = mySqlClient->execute(query);
        if result is sql:Error {
            return error("Error occurred while executing the query", result);
        }
        log:printInfo("Successfully inserted the data to the database");

        // Extract Message header (MSH)
        // hl7v23:MSH? msh = ();
        // if parsedMsg is hl7v2:Message && parsedMsg.hasKey("msh") {
        //     anydata mshEntry = parsedMsg["msh"];
        //     hl7v23:MSH|error tempMSH = mshEntry.ensureType();
        //     if tempMSH is error {
        //         return error("Error occurred while casting MSH");
        //     }
        //     msh = tempMSH;
        // } 
        // if msh is () {
        //     return error("Failed to extract MSH from HL7 message");
        // }
        // hl7v23:ACK ack = {
        //     msh: {
        //         msh3: { hd1: "TESTSERVER"},
        //         msh4: { hd1: "WSO2OH" },
        //         msh5: { hd1: msh.msh3.hd1 },
        //         msh6: { hd1: msh.msh4.hd1 },
        //         msh9: { cm_msg1: hl7v23:ACK_MESSAGE_TYPE },
        //         msh10: uuid:createType1AsString().substring(0,8),
        //         msh11: { pt1: "P" },
        //         msh12: "2.3"
        //     },
        //     msa: {
        //         msa1: "AA",
        //         msa2: msh.msh10
        //     }
        // };
        // encode message to wire format
        // byte[]|hl7v2:HL7Error encodedMsg = hl7v2:encode(hl7v23:VERSION, ack);
        // if encodedMsg is hl7v2:HL7Error {
        //     return error("Error occurred while encoding acknowledgement", encodedMsg);
        // }
        // string|error ackStr = string:fromBytes(encodedMsg);
        // if ackStr is error {
        //     return error("Error occurred while converting encoded message to string", ackStr);
        // }
        // log:printInfo("Sending ACK: ", message = ackStr);
        // return encodedMsg;
        return "success";
    }
}

// service class HL7ServiceConnectionService {
//     *tcp:ConnectionService;

//     remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns byte[]|tcp:Error? {

//     }

//     remote function onError(tcp:Error err) {
//         log:printError("An error occurred", 'error = err);
//     }

//     remote function onClose() {
//         log:printInfo("Client left");
//     }
// }
