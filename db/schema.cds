namespace com.sap.learning;

using { cuid, managed, sap.common.CodeList} from '@sap/cds/common';

entity Employees: cuid, managed {
    name : String;
    email : String;
    department: String;
    manager: Association to Employees;
    entitlement: Integer default 20;
    usedDays : Integer default 0;
    leaveRequests: Association to many LeaveRequests on leaveRequests.employee = $self;
} 

entity LeaveTypes: cuid {
    name : String(50);
    deductsBalance : Boolean default true;
}

entity LeaveRequests: cuid, managed {
    employee : Association to Employees;
    leaveTypes : Association to LeaveTypes;
    startDate: Date;
    endDate : Date;
    reason : String(50);
    days : Integer;
    status : String(1) enum {
        pending = 'P';
        approved = 'A';
        rejected = 'R';  
    } default 'P'; 
    reviewedBy : String(100) @readonly;
    reviewedAt : DateTime @readonly;
    reviewNotes : String(500) @readonly;
}
