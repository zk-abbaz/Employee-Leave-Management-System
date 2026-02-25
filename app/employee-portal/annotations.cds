using EmployeeService as service from '../../srv/emp-service';
annotate service.MyRequests with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'startDate',
                Value : startDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'endDate',
                Value : endDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'reason',
                Value : reason,
            },
            {
                $Type : 'UI.DataField',
                Label : 'days',
                Value : days,
            },
            {
                $Type : 'UI.DataField',
                Value : leaveTypes_ID,
                Label : 'leaveTypes_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : employee_ID,
                Label : 'employee_ID',
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
            Label : 'startDate',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'endDate',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'reason',
            Value : reason,
        },
        {
            $Type : 'UI.DataField',
            Label : 'days',
            Value : days,
        },
        {
            $Type : 'UI.DataField',
            Value : leaveTypes_ID,
            Label : 'leaveTypes_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : employee_ID,
            Label : 'employee_ID',
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

