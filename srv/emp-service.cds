using com.sap.learning as db from '../db/schema';

service EmployeeService @(path: '/emp') {
    entity MyProfile as projection on db.Employees;
    entity LeaveTypes as projection on db.LeaveTypes;
    entity LeaveStatus   as projection on db.LeaveStatus;
    @odata.draft.enabled
    entity MyRequests as projection on db.LeaveRequests;
}

// annotate EmployeeService.MyProfile with @odata.draft.enabled;
// annotate EmployeeService.MyRequests with @odata.draft.enabled;
// annotate EmployeeService.LeaveTypes with @odata.draft.enabled;