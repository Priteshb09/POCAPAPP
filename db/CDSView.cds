namespace poapp.view;
using { poapp.db.master, poapp.db.transaction } from './datamodel';
 
context CDSView {
    define view ![PurchaseOrderWorklist] as
        select from transaction.purchaseorder {
            key PO_ID as ![PurchaseOrderID],
            key Items.PO_ITEMS_POS as ![PurchaseItems],
            PARTNER_GUID.BP_ID as ![BusinessPartnerID],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            GROSS_AMOUNT as ![GrossAmout],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            CURRENCY as ![Currency],
            LIFECYCLE_STATUS as ![LifeCycleStatus],
            OVERALL_STATUS as ![OveralStatus]
        }
 
    define view ![PurchaseItemView] as
        select from transaction.poitems {
            PARENT_KEY.PARTNER_GUID.NODE_KEY as ![CustomerKey],
            PRODUCT_GUID.NODE_KEY as ![ProductKey],
            CURRENCY as ![CurrencyCode],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as ![Status]
        }
 
    define view ProductView as
        select from master.product
        mixin {
            PO_ITEM : Association[*] to PurchaseItemView on PO_ITEM.ProductKey = $projection.ProductKey
        } into {
            NODE_KEY as ![ProductKey],
            DESCRIPTOIN as ![Description],
            CATEGORY as ![Category],
            PRICE as ![Price],
            SUPPLIER_GUID.BP_ID as ![BusinessPartnerID],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
            PO_ITEM as ![To_Items]
        }
}
 