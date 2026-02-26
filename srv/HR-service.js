const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');
const { validateDate, validateBalance, checkOverlap } = require('./lib/validations');

class HRService extends cds.ApplicationService {
    init() {
        const { LeaveRequests, Employees } = this.entities;

        this.on('approve', LeaveRequests, this.approveLeave.bind(this));
        this.on('rejectRequest', LeaveRequests, this.rejectLeave.bind(this));
        this.before('DELETE', LeaveRequests, this.deleteRequest.bind(this));

        this.before('CREATE', LeaveRequests, (req) => validateDate(req));
        this.before('CREATE', LeaveRequests, (req) => validateBalance(req, this.entities));
        this.before('CREATE', LeaveRequests, (req) => checkOverlap(req, this.entities));

        return super.init();
    }



    async deleteRequest(req) {
        const { LeaveRequests } = this.entities;
        const { ID } = req.params[0];
        const leaveRequest = await SELECT.one.from(LeaveRequests).where({ ID });
        if (leaveRequest.status_code === 'A' || leaveRequest.status_code === 'R') {
            return req.error(400, 'Cannot delete an approved or rejected request')
        }
    }

    async approveLeave(req) {
        const { LeaveRequests, LeaveTypes, Employees } = this.entities;
        const { ID } = req.params[1] ?? req.params[0];

        // 1. Fetch the leave request
        const leaveRequest = await SELECT.one.from(LeaveRequests).where({ ID });

        // 2. Check status
        if (leaveRequest.status_code !== 'P') {
            return req.error(400, 'Request is not in Pending status');
        }

        // 3. Update the leave request
        await UPDATE(LeaveRequests).where({ ID }).with({
            status_code: 'A',
            reviewedBy: req.user.id,
            reviewedAt: new Date(),
            reviewNotes: req.data.reviewNotes
        });

        // 4. Fetch employee and leave type
        const employee = await SELECT.one.from(Employees).where({ ID: leaveRequest.employee_ID });
        const leaveType = await SELECT.one.from(LeaveTypes).where({ ID: leaveRequest.leaveTypes_ID });

        // 5. Deduct balance if applicable
        if (leaveType.deductsBalance) {
            await UPDATE(Employees).where({ ID: employee.ID }).with({
                usedDays: employee.usedDays + leaveRequest.days
            });
        }
    }
    async rejectLeave(req) {
        const { LeaveRequests } = this.entities;
        const { ID } = req.params[1] ?? req.params[0];

        let leaveRequest = await SELECT.one.from(LeaveRequests).where({ ID });

        if (leaveRequest.status_code !== 'P') {
            return req.error(400, 'Request is not in Pending status');
        }

        await UPDATE(LeaveRequests).where({ ID }).with({
            status_code: 'R',
            reviewedBy: req.user.id,
            reviewedAt: new Date(),
            reviewNotes: req.data.reviewNotes,
        });
    }
}

module.exports = HRService;