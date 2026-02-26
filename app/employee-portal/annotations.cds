using EmployeeService as service from '../../srv/emp-service';
annotate service.MyRequests with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Start Date',
                Value : startDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'End Date',
                Value : endDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Reason',
                Value : reason,
            },
            {
                $Type : 'UI.DataField',
                Value : leaveTypes_ID,
                Label : 'Leave Types ID',
            },
            {
                $Type : 'UI.DataField',
                Value : employee_ID,
                Label : 'Employee ID',
            },
            {
                $Type : 'UI.DataField',
                Value : days,
                Label : 'Days',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Start Date',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'End Date',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Reason',
            Value : reason,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Days',
            Value : days,
        },
        {
            $Type : 'UI.DataField',
            Value : leaveTypes_ID,
            Label : 'Leave Types ID',
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Value : employee_ID,
            Label : 'Employee ID',
            @UI.Hidden,
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : employee.name,
        },
        TypeName : 'My leave request',
        TypeNamePlural : '',
        TypeImageUrl : 'sap-icon://employee',
    },
);

annotate service.MyRequests with {
    employee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'MyProfile',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : employee_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'department',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'entitlement',
            },
        ],
    }
};

annotate service.MyRequests with {
    leaveTypes @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'LeaveTypes',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : leaveTypes_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'deductsBalance',
            },
        ],
    }
};

annotate service.MyRequests with {
    days @Common.FieldControl : #ReadOnly
};

