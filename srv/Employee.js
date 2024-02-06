const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

    const { Employees, Gender } = this.entities();
    
    this.on(['READ'], Employees, async(req) => {
        results = await cds.run(req.query);
        if(Array.isArray(results)){
            results.forEach(element => {
             element.gen = results.gender === 'M' ? 'Male' : 'Female';
            });
        }else{
            results.gen = results.gender === 'M' ? 'Male' : 'Female';
        }
        if(results.gender === 'M ') {
            results.gender = 'Male';
        } else if (results.gender === 'F') {
            results.gender = 'Female';
        }
        
        return results;
    });

    this.before(['CREATE', 'UPDATE'], Employees, async (req) => {
        let query1 = SELECT.from(Employees).where({ ref: ["email_id"] }, "=", { val: req.data.email_id }).and('Employee_id', '!=', req.data.Employee_id);
        const result = await cds.run(query1);
        if (result.length > 0) {
            req.error({ 'code': 'STEMAILEXISTS', message: 'Employee with such email already exists', target: 'email_id' });
        }
    });

    this.on('READ', Gender, async(req) => {
        genders = [
            {"code":"M", "description":"Male"},
            {"code":"F", "description":"Female"}
        ]
        genders.$count=genders.length;
        return genders;
    });
});