using com.sap.learning as db from '../db/schema';

service EmployeeService @(path: '/emp') {
    entity MyProfile as projection on db.Employees;
    entity LeaveTypes as projection on db.LeaveTypes;
    entity MyReuests as projection on db.LeaveRequests;
}