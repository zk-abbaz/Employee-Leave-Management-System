const cds = require('@sap/cds');
const { validateDate, validateBalance, checkOverlap, calculateDays } = require('./lib/validations');
const { LeaveRequest } = require('#cds-models/HRService');

class EmployeeService extends cds.ApplicationService {
    init() {
        const { MyProfile, MyRequests } = this.entities;

        // READ scoping
        // this.before('READ', MyProfile, this.scopeProfile.bind(this));
        // this.before('READ', MyRequests, this.scopeRequests.bind(this));

        // CREATE validations — reusing shared logic
    this.before('CREATE', MyRequests, (req) => calculateDays(req));
    this.before('CREATE', MyRequests, (req) => validateDate(req));
    this.before('CREATE', MyRequests, (req) => validateBalance(req, this.entities));
    this.before('CREATE', MyRequests, (req) => checkOverlap(req, this.entities));


    this.before('CREATE', MyRequests, (req) => {
    if (!req.data.employee_ID) {
        req.data.employee_ID = '5f4d6e7a-1234-4abc-8def-000000000011';
    }
});

        return super.init();
    }

 async scopeProfile(req) {
        // only return the employee record that matches the logged-in user
        req.query.where({ ID: req.user.id });
    }

    async scopeRequests(req) {
        // only return leave requests belonging to the logged-in user
        req.query.where({ employee_ID: req.user.id });
    }
}

module.exports = EmployeeService;