using {
    poapp.db.master,
    poapp.db.transaction
} from '../db/datamodel';
 
service CatalogService @(path: 'MyService', requires : 'authenticated-user') {
 
    @readonly
    entity BusinessPartnerV4 as projection on master.businesspartner;
 
    @readonly
    entity AddressV4         as projection on master.address;
 
    entity EmployeeV4 @(restrict: [
        {
            grant : ['READ'], to : 'Viewer', where : 'bankName = $user.bankName'
        },
        {
            grant : ['WRITE'], to : 'Admin'
        }
    ])        as projection on master.employee;
 
    @readonly
    entity ProductV4         as projection on master.product;
 
    entity POItemsV4         as projection on transaction.poitems;
 
    entity POsV4 @(
        odata.draft.enabled : true
    ) as
        projection on transaction.purchaseorder {
            *,
            case OVERALL_STATUS
                when 'N' then 'New'
                when 'P' then 'Paid'
                when 'B' then 'Blocked'
                when 'R' then 'Returned'
                else 'Delivered'
            end as OverallStatus : String(20) @(title: '{i18n>OVERALL_STATUS}'),
            case OVERALL_STATUS
                when 'N' then 2
                when 'P' then 2
                when 'B' then 1
                when 'R' then 1
                else 3
            end as OSCriticality : Integer,
            case LIFECYCLE_STATUS
                when 'N' then 'New'
                when 'I' then 'In Progress'
                when 'P' then 'Pending'
                when 'C' then 'Cancelled'
                else 'Done'
            end as LifecycleStatus : String(20) @(title: '{i18n>LIFECYCLE_STATUS}'),
            case LIFECYCLE_STATUS
                when 'N' then 3
                when 'I' then 1
                when 'P' then 2
                when 'C' then 1
                else 2
            end as LSCriticality : Integer,
            Items : redirected to POItemsV4
        } actions {
            @cds.odata.bindingparameter.name : '_pricehike'
            @Common.SideEffects : {
                TargetProperties : [
                    '_pricehike/GROSS_AMOUNT'
                ],
            }
            action discountOnPrice() ;
            function largetOrder() returns array of POsV4;
        };
 
    action createEmployee(Currency_code: String,
                          accountNumber: String,
                          bankId: String,
                          bankName: String,
                          email: String,
                          gender: String,
                          language: String,
                          loginName: String,
                          mobile: String,
                          nameFirst: String,
                          nameMiddle: String,
                          nameInitials: String,
                          nameLast: String,
                          salaryAmount: Decimal(10, 2)
 
    ) returns array of EmployeeV4;
 
    function getEmployeewithMoreSalary() returns array of EmployeeV4 ;
}
 