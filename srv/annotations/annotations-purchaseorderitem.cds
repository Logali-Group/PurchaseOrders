using {PurchaseOrder} from '../service';

annotate PurchaseOrder.PurchaseOrderItem with {
    PurchaseOrder              @title: 'Purchase Order';
    PurchaseOrderItem          @title: 'Purchase Order Item'           @Core.Computed       : true;
    PurchaseOrderItemText      @title: 'Purchase Order Item Text';
    Plant                      @title: 'Plant';
    StorageLocation            @title: 'Storage Location';
    Material                   @title: 'Product';
    MaterialName               @title: 'Product Name';
    MaterialGroup              @title: 'Product Group';
    ProductType                @title: 'Product Type';
    NetPriceQuantity           @title: 'Net Price Quantity'            @Measures.Unit       : OrderPriceUnit_code;
    OrderPriceUnit             @title: 'Order Quantity'                @Common.IsUnit;
    NetPriceAmount             @title: 'Net Price Amount'              @Measures.ISOCurrency: DocumentCurrency_code;
    DocumentCurrency           @title: 'Currency'                      @Common.IsCurrency;
    OrderQuantity              @title: 'Order Quantity'                @Measures.Unit       : PurchaseOrderQuantityUnit_code;
    PurchaseOrderQuantityUnit  @title: 'Purchase Order Quantity Unit'  @Common.IsUnit;
    TaxCode                    @title: 'Tax Code';
};

annotate PurchaseOrder.PurchaseOrderItem with {
    Plant           @Common: {ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'VHE_Plants',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterIn',
                LocalDataProperty: PurchaseOrder.CompanyCode_CompanyCode,
                ValueListProperty: 'CompanyCode'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: Plant_Plant,
                ValueListProperty: 'Plant'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: PlantName,
                ValueListProperty: 'PlantName'
            }
        ]
    }};
    StorageLocation @Common: {ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'VHE_StorageLocation',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterIn',
                LocalDataProperty: Plant_Plant,
                ValueListProperty: 'Plant'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: StorageLocation_StorageLocation,
                ValueListProperty: 'StorageLocation'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: StorageLocationName,
                ValueListProperty: 'StorageLocationName'
            }
        ]
    }};
    Material        @Common: {ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'VHE_Product',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterIn',
                LocalDataProperty: Plant_Plant,
                ValueListProperty: 'Plant'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: Material_Product,
                ValueListProperty: 'Product'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: MaterialName,
                ValueListProperty: 'ProductName'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: MaterialGroup,
                ValueListProperty: 'ProductGroup'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: ProductType,
                ValueListProperty: 'ProductType'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: PurchaseOrderQuantityUnit,
                ValueListProperty: 'PurchaseOrderQuantityUnit'
            }
        ]
    }}
};


annotate PurchaseOrder.PurchaseOrderItem with @(
    Common.SideEffects             : {
        $Type           : 'Common.SideEffectsType',
        SourceProperties: [
            'Material_Product',
            'NetPriceAmount',
            'NetPriceQuantity',
            'OrderQuantity',
            'PurchaseOrderQuantityUnit'
        ],
        TargetProperties: [
            'NetPriceAmount',
            'DocumentCurrency_code',
            'NetPriceQuantity',
            'PurchaseOrderQuantityUnit',
            'TaxCode'
        ],
        TargetEntities  : [PurchaseOrder]
    },
    UI.HeaderInfo                  : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
        Title         : {
            $Type: 'UI.DataField',
            Value: PurchaseOrder.PurchaseOrder
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: PurchaseOrder.PurchaseOrderDate
        }
    },
    UI.LineItem                    : [
        {
            $Type             : 'UI.DataField',
            Value             : PurchaseOrderItem,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '12rem'
            }
        },
        {
            $Type             : 'UI.DataField',
            Value             : Plant_Plant,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '8rem'
            }
        },
        {
            $Type: 'UI.DataField',
            Value: Material_Product
        },
        {
            $Type: 'UI.DataField',
            Value: MaterialName
        },
        // {
        //     $Type             : 'UI.DataField',
        //     Value             : MaterialGroup,
        //     @HTML5.CssDefaults: {
        //         $Type: 'HTML5.CssDefaultsType',
        //         width: '12rem'
        //     }
        // },
        // {
        //     $Type             : 'UI.DataField',
        //     Value             : ProductType,
        //     @HTML5.CssDefaults: {
        //         $Type: 'HTML5.CssDefaultsType',
        //         width: '12rem'
        //     }
        // },
        {
            $Type             : 'UI.DataField',
            Value             : OrderQuantity,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '12rem'
            }
        },
        {
            $Type             : 'UI.DataField',
            Value             : NetPriceQuantity,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '12rem'
            }
        },
        {
            $Type             : 'UI.DataField',
            Value             : NetPriceAmount,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '12rem'
            }
        }
    ],
    UI.FieldGroup #DeliveryData    : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrderItem
            },
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrderItemText
            },
            {
                $Type: 'UI.DataField',
                Value: Plant_Plant
            },
            {
                $Type: 'UI.DataField',
                Value: StorageLocation_StorageLocation
            }
        ]
    },
    UI.FieldGroup #MaterialDetails : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Material_Product
            },
            {
                $Type: 'UI.DataField',
                Value: MaterialName
            },
            {
                $Type: 'UI.DataField',
                Value: MaterialGroup
            },
            {
                $Type: 'UI.DataField',
                Value: ProductType
            }
        ]
    },
    UI.FieldGroup #QuantityAndPrice: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: OrderQuantity
            },
            {
                $Type: 'UI.DataField',
                Value: NetPriceAmount
            },
            {
                $Type: 'UI.DataField',
                Value: NetPriceQuantity
            },
            {
                $Type: 'UI.DataField',
                Value: TaxCode
            }
        ]
    },
    UI.Facets                      : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#DeliveryData',
                    Label : 'Delivery Data'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#MaterialDetails',
                    Label : 'Material Details'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#QuantityAndPrice',
            Label : 'Quantity and Price'
        }
    ]
);
