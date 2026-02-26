using HRService as service from '../../srv/HR-service';
annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Department',
                Value : department,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Entitlement',
                Value : entitlement,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Used Days',
                Value : usedDays,
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
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Leave Request',
            ID : 'LeaveRequest',
            Target : 'leaveRequests/@UI.LineItem#LeaveRequest1',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Email',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Department',
            Value : department,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Entitlement',
            Value : entitlement,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Used Days',
            Value : usedDays,
        },
    ],
    UI.FieldGroup #LeaveRequest : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.days,
                Label : 'days',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.endDate,
                Label : 'endDate',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.reason,
                Label : 'reason',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.reviewNotes,
                Label : 'reviewNotes',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.startDate,
                Label : 'startDate',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.status,
                Label : 'status',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.reviewedAt,
                Label : 'reviewedAt',
            },
            {
                $Type : 'UI.DataField',
                Value : leaveRequests.reviewedBy,
                Label : 'reviewedBy',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : 'Employee',
        TypeNamePlural : 'Employees',
        TypeImageUrl : 'sap-icon://employee',
    },
);

annotate service.Employees with {
    manager @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Employees',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : manager_ID,
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

annotate service.LeaveRequests with @(
    UI.LineItem #LeaveRequest : [
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
            Label : 'startDate',
        },
        {
            $Type : 'UI.DataField',
            Value : reviewNotes,
            Label : 'reviewNotes',
        },
        {
            $Type : 'UI.DataField',
            Value : reviewedBy,
            Label : 'reviewedBy',
        },
        {
            $Type : 'UI.DataField',
            Value : reviewedAt,
            Label : 'reviewedAt',
        },
        {
            $Type : 'UI.DataField',
            Value : reason,
            Label : 'reason',
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
            Label : 'endDate',
        },
        {
            $Type : 'UI.DataField',
            Value : days,
            Label : 'days',
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : employee.name,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
    UI.SelectionPresentationVariant #LeaveRequest : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#LeaveRequest',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.LineItem #LeaveRequest1 : [
        {
            $Type : 'UI.DataField',
            Value : startDate,
            Label : 'Start Date',
        },
        {
            $Type : 'UI.DataField',
            Value : days,
            Label : 'Days',
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
            Label : 'End Date',
        },
        {
            $Type : 'UI.DataField',
            Value : reason,
            Label : 'Reason',
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Label : 'Status',
            Criticality : status.criticality,
            CriticalityRepresentation : #WithIcon,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Leave Details',
            ID : 'LeaveDetails',
            Target : '@UI.FieldGroup#LeaveDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Review Details',
            ID : 'ReviewDetails',
            Target : '@UI.FieldGroup#ReviewDetails',
        },
    ],
    UI.FieldGroup #LeaveDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : days,
                Label : 'Days',
            },
            {
                $Type : 'UI.DataField',
                Value : startDate,
                Label : 'Start Date',
            },
            {
                $Type : 'UI.DataField',
                Value : reason,
                Label : 'Reason',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'Status',
                Criticality : status.criticality,
                CriticalityRepresentation : #WithIcon,
            },
        ],
    },
    UI.FieldGroup #ReviewDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : reviewedAt,
                Label : 'Reviewed At',
            },
            {
                $Type : 'UI.DataField',
                Value : reviewedBy,
                Label : 'Reviewed By',
            },
            {
                $Type : 'UI.DataField',
                Value : reviewNotes,
                Label : 'Review Notes',
            },
        ],
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'HRService.approve',
            Label : 'Approve',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'HRService.rejectRequest',
            Label : 'Reject',
        },
    ],
);

annotate service.LeaveRequests with {
    status @(
        Common.Text : status.displayText,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'LeaveStatus',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.LeaveStatus with {
    displayText @Common.Text : code
};

annotate service.LeaveStatus with {
    code @Common.Text : displayText
};

