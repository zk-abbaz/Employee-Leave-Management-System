sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"employeeportal/test/integration/pages/MyRequestsList",
	"employeeportal/test/integration/pages/MyRequestsObjectPage"
], function (JourneyRunner, MyRequestsList, MyRequestsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('employeeportal') + '/test/flp.html#app-preview',
        pages: {
			onTheMyRequestsList: MyRequestsList,
			onTheMyRequestsObjectPage: MyRequestsObjectPage
        },
        async: true
    });

    return runner;
});

