### Request Message

HL7 message as a record
```
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
```

HL7 message after encoding with HL7
```
MSH|^~\\&|ADT1|MCM|LABADT|MCM||SECURITY|QRY^A19|MSG00001|P|2.3|||||||${"\r"}QRD|20220828104856+0000|R|I|QueryID01|||5.0|1^ADAM^EVERMAN^^|VXI|SIIS|
```

#### Request body
Following is a HL7 messaged encoded with base64
```
C01TSHxeflwmfEFEVDF8TUNNfExBQkFEVHxNQ018fFNFQ1VSSVRZfFFSWV5BMTl8TVNHMDAwMDF8UHwyLjN8fHx8fHx8DVFSRHwyMDIyMDgyODEwNDg1NiswMDAwfFJ8SXxRdWVyeUlEMDF8fHw1LjB8MV5BREFNXkVWRVJNQU5eXnxWWEl8U0lJU3wNHA0=
```
