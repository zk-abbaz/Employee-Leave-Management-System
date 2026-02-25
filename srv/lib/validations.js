
    
    
    const checkOverlap = async (req, entities) => {
        const LeaveRequests = entities.LeaveRequests || entities.MyRequests;
        const {startDate, endDate, employee_ID} = req.data;
           if (!startDate || !endDate || !employee_ID) return;  // add guard

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

    const validateBalance = async (req, entities) => {
        const Employees = entities.Employees || entities.MyProfile;
        const LeaveTypes = entities.LeaveTypes;
        const {employee_ID, leaveTypes_ID, days} = req.data;

          if (!employee_ID || !leaveTypes_ID || !days) return;  // add this guard

        
        const employee = await SELECT.one.from(Employees).where({ ID: employee_ID });
        const leaveType = await SELECT.one.from(LeaveTypes).where({ID: leaveTypes_ID});

        if (!leaveType) return;  // add this guard too
        
        if( leaveType.deductsBalance ) {
            const daysLeft = employee.entitlement - employee.usedDays;
            if( days > daysLeft) {
                return req.error(400, `Insufficient balance. You have ${daysLeft} days left`)
            }   
        }
    }

    const validateDate = async (req) => {

        const {startDate} = req.data;
        const today = new Date();
        today.setHours(0, 0, 0, 0,);

        if(new Date(startDate) < today) {
           return req.error(400, 'Start date cannot be in the past')
        }
    }

    module.exports = { validateDate, validateBalance, checkOverlap };