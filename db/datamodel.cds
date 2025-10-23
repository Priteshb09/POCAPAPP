namespace poapp.db;

using {poapp.common as common} from './common';
using {
    cuid,
    Currency
} from '@sap/cds/common';


context master {
    entity businesspartner {
        key NODE_KEY     : common.Guid @(title: '{i18n>NODE_KEY}');
            BP_ROLE      : String(2)   @(title: '{i18n>BP_ROLE}');
            EMAIL        : common.Email @(title: '{i18n>EMAIL}');
            MOBILE       : common.PhoneNumber @(title: '{i18n>MOBILE}');
            FAX          : String(36) @(title: '{i18n>FAX}');
            WEB          : String(105) @(title: '{i18n>WEB}');
            BP_ID        : common.Guid @(title: '{i18n>BP_ID}');
            COMPANY_NAME : String(255) @(title: '{i18n>COMPANY_NAME}');
            ADDRESS_GUID : Association to address @(title: '{i18n>ADDRESS_GUID}');
    }

    entity address {
        key NODE_KEY        : common.Guid  @(title: '{i18n>NODE_KEY}');
            CITY            : String(36)   @(title: '{i18n>CITY}');
            POSTAL          : String(12)  @(title: '{i18n>POSTAL}');
            STREET          : String(48)  @(title: '{i18n>STREET}');
            BUILDING        : String(105)  @(title: '{i18n>BUILDING}');
            COUNTRY         : String(48)  @(title: '{i18n>COUNTRY}');
            ADDRESS_TYPE    : String(48)  @(title: '{i18n>ADDRESS_TYPE}');
            VAL_START       : Date  @(title: '{i18n>VAL_START}');
            VAL_END         : Date  @(title: '{i18n>VAL_END}');
            LATITUDE        : Decimal  @(title: '{i18n>LATITUDE}');
            LONGITUDE       : Decimal  @(title: '{i18n>LONGITUDE}');
            // Unmanaged Association
            businesspartner : Association to one businesspartner
                                  on businesspartner.ADDRESS_GUID = $self;
    }

    entity product {
        key NODE_KEY       : common.Guid @(title: '{i18n>NODE_KEY}');
            PRODUCT_ID     : String(28) @(title: '{i18n>PRODUCT_ID}');
            TYPE_CODE      : String(2)  @(title: '{i18n>TYPE_CODE}');
            CATEGORY       : String(32)  @(title: '{i18n>CATEGORY}');
            DESCRIPTOIN    : String(255)  @(title: '{i18n>DESCRIPTION}');
            TAX_TARIF_CODE : Integer  @(title: '{i18n>TAX_TARIF_CODE}');
            MEASURE_UNIT   : String(2)  @(title: '{i18n>MEASURE_UNIT}');
            WEIGHT_MEASURE : Decimal(5, 2)  @(title: '{i18n>WEIGHT_MEASURE}');
            WEIGHT_UNIT    : String(2)  @(title: '{i18n>WEIGHT_UNIT}');
            CURRENCY_CODE  : String(4)  @(title: '{i18n>CURRENCY_CODE}');
            PRICE          : Decimal(15, 2) @(title: '{i18n>PRICE}');
            WIDTH          : Decimal(5, 2) @(title: '{i18n>WIDTH}');
            DEPTH          : Decimal(5, 2)  @(title: '{i18n>DEPTH}');
            HEIGHT         : Decimal(5, 2)  @(title: '{i18n>HEIGHT}');
            DIM_UNIT       : String(2)  @(title: '{i18n>DIM_UNIT}');
            // Managed Associaion
            SUPPLIER_GUID  : Association to master.businesspartner @(title: '{i18n>NET_AMOUNT}');
    }

    // Reuse Aspect can be used outside the entity
    // Reuse Type can be used inside the entity
    entity employee : cuid {
        nameFirst     : String(48) @(title: '{i18n>NODE_KEY}');
        nameLast      : String(48) @(title: '{i18n>LAST_NAME}');
        nameMiddle    : String(48) @(title: '{i18n>MIDDLE_NAME}');
        nameInitials  : String(48) @(title: '{i18n>INITIALS}');
        gender        : common.Gender  @(title: '{i18n>GENDER}');
        language      : String(2) @(title: '{i18n>LANGUAGE}');
        mobile        : common.PhoneNumber @(title: '{i18n>MOBILE}');
        email         : common.Email  @(title: '{i18n>EMAIL}');
        loginName     : String(16)  @(title: '{i18n>LOGIN_NAME}');
        Currency      : Currency  @(title: '{i18n>CURRENCY}');
        salaryAmount  : common.AmountT @(title: '{i18n>SALARY_AMOUNT}');
        accountNumber : String(16) @(title: '{i18n>ACCOUNT_NUMBER}');
        bankId        : String(12) @(title: '{i18n>BANK_ID}');
        bankName      : String(64) @(title: '{i18n>BANK_NAME}');
    }

}

context transaction {
    entity purchaseorder : common.Amount {
        key NODE_KEY         : common.Guid @(title: '{i18n>NODE_KEY}');
            PO_ID            : common.Guid @(title: '{i18n>PO_ID}');
            PARTNER_GUID     : Association to master.businesspartner @(title: '{i18n>PARTNER_GUID}');
            LIFECYCLE_STATUS : String(2) @(title: '{i18n>LIFECYCLE_STATUS}');
            OVERALL_STATUS   : String(2)  @(title: '{i18n>OVERALL_STATUS}');
            // Unmanaged Association
            Items            : Composition of many poitems
                                   on Items.PARENT_KEY = $self;
    }

    entity poitems : common.Amount {
        key NODE_KEY     : common.Guid @(title: '{i18n>OVERALL_STATUS}');
            PARENT_KEY   : Association to purchaseorder @(title: '{i18n>PARENT_KEY}');
            PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}');
            PRODUCT_GUID : Association to master.product @(title: '{i18n>PRODUCT_GUID}');
    }
}
