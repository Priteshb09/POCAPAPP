namespace poapp.common;
 
using {Currency} from '@sap/cds/common';
 
 
// Reusable Types : GUID, PhoneNumber, Email
type Guid        : String(36);
type PhoneNumber : String(36);
type Email       : String(255);
 
// Reuse Type with Enumerator
type Gender      : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}
 
// Reuse Type with Currency Code
type AmountT     : Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);
 
// Reusable Aspect with Common Reusetypes given by SAP
aspect Amount : {
    CURRENCY    : Currency @(title: '{i18n>CURRENCY_CODE}');
    GROSS_AMOUNT : AmountT  @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT   : AmountT  @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT  : AmountT @(title: '{i18n>TAX_AMOUNT}');
}