const { resolve } = require("@sap/cds");
 
module.exports = cds.service.impl(async function(){
    // Step-1 : Declaring the entities which we are going to use.
    const { EmployeeV4, POsV4 } = this.entities;
    const {uuid} = cds.utils;
 
    this.on('createEmployee',async(request, response) => {
        const dataset = request.data;
        const id = uuid();
        let entryToBeCreated = {
            ID : id,
            nameFirst : request.data.nameFirst,
            nameMiddle : request.data.nameMiddle,
            nameLast : request.data.nameLast,
            nameInitials : request.data.nameInitials,
            gender : request.data.gender,
            language : request.data.language,
            mobile : request.data.mobile,
            email : request.data.email,
            loginName : request.data.loginName,
            Currency_code : request.data.Currency_code,
            salaryAmount : request.data.salaryAmount,
            accountNumber : request.data.accountNumber,
            bankId : request.data.bankId,
            bankName : request.data.bankName
        }
        // Step - 2 : Insert Employee service using request.data(which is coming from the user)
        let returndata = await cds.tx(request).run([
            INSERT.into('POAPP_DB_MASTER_EMPLOYEE').entries([entryToBeCreated])
    ]).then((resolve, reject)=>{
            if(typeof(resolve) !== undefined){
                return request.data;
            } else {
                request.console.error((500,"Error in creating employee"));
            }
        }).catch(error => {
            request.error(500, "Error : " + error.toString());
        })
 
        return returndata;
    });

    this.on('getEmployeewithMoreSalary', async(request, response) => {
        try {
            // Step-2 : Declare the transaction maangement object
            const tx = cds.tx(request);
 
            // Step - 3 : Read the employee with biggest salary
            const returndata = await tx.read(EmployeeV4).orderBy({
                salaryAmount : 'desc'
            }).limit(1);
            return returndata;
        } catch (error) {
            return "Error " + error.toString();
        }
    });

        this.on('discountOnPrice',async(request,response) => {
        try {
            const ID = request.params[0];
            const tx = cds.tx(request);
            await tx.update(POsV4).with({
                GROSS_AMOUNT : { '+=' : 1000 },
                NET_AMOUNT : { '+=' : 800 },
                TAX_AMOUNT : { '+=' : 200 },
                NOTE : "Discounted..!"
            }).where(ID)
        } catch (error) {
            return "Error : " + error.toString();
        }
    });

    this.on('largetOrder', async(request, response) => {
        try {
            const tx = cds.tx(request);
 
            const reply = await tx.read(POsV4).orderBy({
                GROSS_AMOUNT : 'desc'
            }).limit(1);
 
            return reply;
        } catch (error) {
            return "Error" + error.toString();
        }
    });

})