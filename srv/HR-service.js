const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');


class HRService extends cds.ApplicationService {
    init () {
        const {LeaveRequests, Employees} = this.entities;
    
        this.on('approve', LeaveRequests, this.approveLeave.bind(this));
        this.on('rejectRequest', LeaveRequests, this.rejectLeave.bind(this));
        this.before('CREATE', LeaveRequests, this.validateDAte.bind(this));
        this.before('DELETE', LeaveRequests, this.deleteRequest.bind(this));
        this.before('CREATE', LeaveRequests, this.validateBalance.bind(this));
        this.before('CREATE', LeaveRequests, this.checkOverlap.bind(this));
        return super.init();
    }

    async checkOverlap(req) {
        const {LeaveRequests} = this.entities;
        const {startDate, endDate, employee_ID} = req.data;

        const overlap = await SELECT.one.from(LeaveRequests).where(
            `employee_ID = '${employee_ID}'
            AND (status = 'P' or status = 'A')
            AND startDate <= '${endDate}'
            AND endDate >= '${startDate}'`
        );

        if(overlap) {
            return req.error(400, 'You already have a request that overlaps with these dates')
        }
    }

    async validateBalance(req) {
        const {Employees, LeaveTypes} = this.entities;
        const {employee_ID, leaveTypes_ID, days} = req.data;

        
        const employee = await SELECT.one.from(Employees).where({ ID: employee_ID });
        const leaveType = await SELECT.one.from(LeaveTypes).where({ID: leaveTypes_ID})
        if( leaveType.deductsBalance ) {
            const daysLeft = employee.entitlement - employee.usedDays;
            if( days > daysLeft) {
                return req.error(400, `Insufficient balance. You have ${daysLeft} days left`)
            }   
        }
    }

    async validateDAte(req) {

        const {startDate} = req.data;
        const today = new Date();
        today.setHours(0, 0, 0, 0,);

        if(new Date(startDate) < today) {
           return req.error(400, 'Start date cannot be in the past')
        }
    }

    async deleteRequest(req) {
         const { LeaveRequests } = this.entities;
        const { ID } = req.params[0];
        const leaveRequest = await SELECT.one.from(LeaveRequests).where({ID});
        if(leaveRequest.status === 'A' || leaveRequest.status === 'R') {
            return req.error(400, 'Cannot delete an approved or rejected request')
        }
    }

    async approveLeave(req) {
    const { LeaveRequests, LeaveTypes, Employees } = this.entities;
    const { ID } = req.params[0];

    // 1. Fetch the leave request
    const leaveRequest = await SELECT.one.from(LeaveRequests).where({ ID });

    // 2. Check status
    if (leaveRequest.status !== 'P') {
        return req.error(400, 'Request is not in Pending status');
    }

    // 3. Update the leave request
    await UPDATE(LeaveRequests).where({ ID }).with({
        status: 'A',
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
        const {LeaveRequests} = this.entities;
        const {ID} = req.params[0];

        let leaveRequest = await SELECT.one.from(LeaveRequests).where({ID});
        
        if(leaveRequest.status !== 'P') {
            return req.error (400, 'Request is not in Pending status');
        }

        await UPDATE(LeaveRequests).where({ID}).with({
            status: 'R',
            reviewedBy: req.user.id,
            reviewedAt: new Date(),
            reviewNotes: req.data.reviewNotes,
        });
    }
}

module.exports = HRService;