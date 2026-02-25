sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"leavemanagement/test/integration/pages/EmployeesList",
	"leavemanagement/test/integration/pages/EmployeesObjectPage",
	"leavemanagement/test/integration/pages/LeaveRequestsObjectPage"
], function (JourneyRunner, EmployeesList, EmployeesObjectPage, LeaveRequestsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('leavemanagement') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeesList: EmployeesList,
			onTheEmployeesObjectPage: EmployeesObjectPage,
			onTheLeaveRequestsObjectPage: LeaveRequestsObjectPage
        },
        async: true
    });

    return runner;
});

