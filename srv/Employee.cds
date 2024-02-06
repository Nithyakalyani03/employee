using { com.satinfotech.Employee as db } from '../db/schema';

service Employee {
    entity Employees as projection on db.Employees;
    entity Gender as projection on db.Gender;
    entity Roles as projection on db.Roles{
    @UI.Hidden: true
    ID,
     *  
    };
    entity Roles.Projects as projection on db.Roles.Projects;
    entity Projects as projection on db.Projects{
       @UI.Hidden: true
     ID,
     *  
    };
}

annotate Employee.Employees with {
    first_name      @assert.format: '^[a-zA-Z]{2,}$';
    last_name      @assert.format: '^[a-zA-Z]{2,}$';    
    email_id     @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    phone_no  @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
}

annotate Employee.Employees with @odata.draft.enabled;
annotate Employee.Roles with @odata.draft.enabled;
annotate Employee.Projects with @odata.draft.enabled;


annotate Employee.Roles.Projects with @(
    UI.LineItem:[
        {
            Label: 'Projects',
            Value: projects_ID
        },
    ]
);

annotate Employee.Projects with @( 
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Projects : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ProjectsFacet',
            Label : 'Projects',
            Target : '@UI.FieldGroup#Projects',
        },
    ],

);

annotate Employee.Gender with @(
    UI.LineItem:[
    {
        @Type: 'UI.DataField',
        Value: code
    },
    {
        @Type: 'UI.DataField',
        Value: description
    },
  ]  
);


annotate Employee.Roles with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        },
        {
            Value: Projects.projects.description
        }
    ],
     UI.FieldGroup #RolesInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            },
            {
                Value: projects,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'RolesInfoFacet',
            Label : 'Roles Information',
            Target : '@UI.FieldGroup#RolesInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'Roles.ProjectsFacet',
            Label : 'Roles Projects Information',
            Target : 'Projects/@UI.LineItem',
        },
    ],
);

annotate Employee.Employees with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : Employee_id
        },
        {
            $Type : 'UI.DataField',
            Value : first_name
        },
        {
            $Type : 'UI.DataField',
            Value : last_name
        },
        {
            $Type : 'UI.DataField',
            Value : email_id
        },
        {
            $Type : 'UI.DataField',
            Label: 'Gender',
            Value : gender
        },
        {
            $Type : 'UI.DataField',
            Value : phone_no
        },
        {
            $Type : 'UI.DataField',
            Value : age
        },
        {
            $Type : 'UI.DataField',
            Value : salary
        },
        {
            $Type : 'UI.DataField',
            Value : hiring_date
        },
        {
            Value:role.code
        },

        ],
    UI.SelectionFields: [ first_name,last_name, email_id, phone_no, age, salary, hiring_date],    
    UI.FieldGroup #EmployeesInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
             {
            $Type : 'UI.DataField',
            Value : Employee_id
        },
        {
            $Type : 'UI.DataField',
            Value : first_name
        },
        {
            $Type : 'UI.DataField',
            Value : last_name
        },
        {
            $Type : 'UI.DataField',
            Value : email_id
        },
        {
        
            $Type : 'UI.DataField',
            Label: 'Gender',
            Value : gender,
        },
        {
            $Type : 'UI.DataField',
            Value : phone_no
        },
        {
            $Type : 'UI.DataField',
            Value : age
        },
        {
            $Type : 'UI.DataField',
            Value : salary
        },
        {
            $Type : 'UI.DataField',
            Value : hiring_date
        },
        {
                $Type: 'UI.DataField',
                Value: role_ID
        },

       ],
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'EmployeesInfoFacet',
            Label : 'Employees Information',
            Target : '@UI.FieldGroup#EmployeesInformation',
        },
      ], 
);

annotate Employee.Roles.Projects with {
    projects @(
        Common.Text: projects.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Projects',
            CollectionPath : 'Projects',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : projects_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}

annotate Employee.Employees with {
    gender @(     
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Genders',
            CollectionPath : 'Gender',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : gender,
                    ValueListProperty : 'code'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    );
    role @(
        Common.Text: role.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Roles',
            CollectionPath : 'Roles',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : role_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    );

};