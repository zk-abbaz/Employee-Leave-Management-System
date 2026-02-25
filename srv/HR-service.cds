using com.sap.learning as db from '../db/schema';

service HRService @(path: '/hr'){
    entity Employees as projection on db.Employees;
    entity LeaveTypes as projection on db.LeaveTypes;

    @odata.draft.enabled
    entity LeaveRequests as projection on db.LeaveRequests actions {
        action approve(reviewNotes: String);
        action rejectRequest(reviewNotes: String);
    }
}

// annotate HRService.Employees with @odata.draft.enabled;
// annotate HRService.LeaveRequests with @odata.draft.enabled;
// annotate HRService.LeaveTypes with @odata.draft.enabled;


