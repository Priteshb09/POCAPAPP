using CatalogService as service from '../../srv/cat-service';
annotate service.POsV4 with @(
    UI.SelectionFields : [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.BP_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'service.discountOnPrice',
            Label : 'Increase Price',
            Inline : true
        },
        {
            $Type : 'UI.DataField',
            Value : LifecycleStatus,
            Criticality : LSCriticality
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : OSCriticality
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ID
        },
        Description : {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME
        },
        ImageUrl : 'https://tse4.mm.bing.net/th/id/OIP.lpUWv6qdLJQr9BzJuyBk4wHaHa?cb=12&rs=1&pid=ImgDetMain&o=7&rm=3'
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purchase Order Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Details',
                    Target : '@UI.FieldGroup#MoreDetails'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Price Details',
                    Target : '@UI.FieldGroup#AmountDetails'
                }
               
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Items',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.FieldGroup #MoreDetails : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY
            },
            {
                $Type : 'UI.DataField',
                Label : 'Life Cycle Status',
                Value : LifecycleStatus,
                Criticality : LSCriticality
            },
            {
                $Type : 'UI.DataField',
                Label : 'Overall Status',
                Value : OverallStatus,
                Criticality : OSCriticality
            }
        ]
    },
    UI.FieldGroup #AmountDetails : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            }
        ]
    }
);

annotate service.POItemsV4 with @(
    UI.LineItem : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEMS_POS
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Item',
        TypeNamePlural : 'Purchase Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS,
        }
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label: 'Purchase Item Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Amount details for purhcase item',
                    Target : '@UI.FieldGroup#AmountItems'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Details',
                    Target : '@UI.FieldGroup#ProductInfo'
                }
            ]
        }
    ],
    UI.FieldGroup #AmountItems : {
        Data: [
            {
                $Type : 'UI.DataField',
                Value : NODE_KEY
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            }
        ]
    },
    UI.FieldGroup #ProductInfo : {
        Data: [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTOIN
            },
            {
                $Type : 'UI.DataField',
                Value :  PRODUCT_GUID.CATEGORY
            },
            {
                $Type : 'UI.DataField',
                Value :  PRODUCT_GUID.DIM_UNIT
            },
            {
                $Type : 'UI.DataField',
                Value :  PRODUCT_GUID.PRICE
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.HEIGHT
            },
            {
                $Type : 'UI.DataField',
                Value :  PRODUCT_GUID.WIDTH
            },
            {
                $Type : 'UI.DataField',
                Value :  PRODUCT_GUID.TYPE_CODE
            },
            {
                $Type : 'UI.DataField',
                Value :  PRODUCT_GUID.TAX_TARIF_CODE
            }
        ]
    }
);


