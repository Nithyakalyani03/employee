namespace com.satinfotech.Employee;
using {cuid,managed} from '@sap/cds/common';

@assert.unique:{
 Employee_id:[Employee_id]
}

entity Employees:cuid, managed{

@title :'EmployeeID'
Employee_id: String(5);
@title :'First Name'
first_name: String(10) @mandatory;
@title :'Last Name'
last_name: String(10) @mandatory;
@title :'Email ID'
email_id: String(20) @mandatory;
@title: 'Gender'
gender : String(1);
@title :'Phone NO'
phone_no: String(20) @mandatory;
@title :'Age'
age: String(2);
@title :'Salary'
salary: String(20);
@title :'Hiring Date'
hiring_date : Date @mandatory;
@title :'Role'
role: Association to Roles;
}

@cds.persistence.skip
entity Gender {
@title : 'code'
key code : String(1);
@title :'Description'
description : String(10);
    
}

entity Roles : cuid,managed {
    @title :'Role'
    code: String(10);
    @title :'Description'
    description: String(50);
     @title: 'Projects'
    Projects: Composition of many{
        key ID: UUID;
        projects: Association to Projects;
    }
}

entity Projects : managed, cuid{
    @title: 'Code'
    code: String(3);
    @title: 'Description'
    description: String(40);
}
