import ballerina/log;
import ballerinax/health.hl7v23;
import ballerina/http;
import ballerinax/health.hl7v2;

public function main() returns error? {
    hl7v23:QRY_A19 qry_a19 = {
        msh: {
            msh3: {hd1: "ADT1"},
            msh4: {hd1: "MCM"},
            msh5: {hd1: "LABADT"},
            msh6: {hd1: "MCM"},
            msh8: "SECURITY",
            msh9: {cm_msg1: "QRY", cm_msg2: "A19"},
            msh10: "MSG00001",
            msh11: {pt1: "P"},
            msh12: "2.3"
        },
        qrd: {
            qrd1: {ts1: "20220828104856+0000"},
            qrd2: "R",
            qrd3: "I",
            qrd4: "QueryID01",
            qrd7: {cq1: 5},
            qrd8: [{xcn1: "1", xcn2: "ADAM", xcn3: "EVERMAN"}],
            qrd9: [{ce1: "VXI"}],
            qrd10: [{ce1: "SIIS"}]    
        }
    };

    byte[] encodedQRYA19 = check hl7v2:encode(hl7v23:VERSION, qry_a19);
    // Send to HL7 server
    http:Client hl7client = check new ("http://localhost:8000");
    
    byte[]|error responseMsg = hl7client->/message.post(encodedQRYA19);
    if responseMsg is error {
        log:printError("Error sending message: ", responseMsg);
        return responseMsg;
    }

    log:printInfo("Response received : ", response = check string:fromBytes(responseMsg));
}
