namespace com.globaltalent.purchaseorder;

using {
    cuid,
    managed,
    sap.common.CodeList,
    sap.common.Languages,
    sap.common.Currencies
} from '@sap/cds/common';

using {API_COMPANYCODE_SRV as Company} from '../srv/external/API_COMPANYCODE_SRV';
using {CE_PURCHASINGORGANIZATION_0001 as Organization} from '../srv/external/CE_PURCHASINGORGANIZATION_0001';
using {API_BUSINESS_PARTNER as BusinessPartner} from '../srv/external/API_BUSINESS_PARTNER';
using {CE_PURCHASINGGROUP_0001 as Group} from '../srv/external/CE_PURCHASINGGROUP_0001';
using {ZCE_PURCHASEORDERTYPE as PurchaseOrderType} from '../srv/external/ZCE_PURCHASEORDERTYPE';
using {API_PLANT_SRV as Plant} from '../srv/external/API_PLANT_SRV';
using {API_STORAGELOCATION_SRV as StorageLocation} from '../srv/external/API_STORAGELOCATION_SRV';
using {API_PRODUCT_SRV as Product} from '../srv/external/API_PRODUCT_SRV';

entity PurchaseOrderHeader : cuid, managed {
    key PurchaseOrder              : String(10) @Core.Computed: true;
        CompanyCode                : Association to Company.A_CompanyCode;
        CompanyName                : String(25);
        PurchasingOrganization     : Association to Organization.A_PurchasingOrganization;
        PurchasingOrganizationName : String(20);
        PurchasingGroup            : Association to Group.A_PurchasingGroup;
        PurchasingGroupName        : String(18);
        PurchaseOrderType          : Association to PurchaseOrderType.PurchaseOrderType;
        PurchaseOrderTypeName      : String(20);
        Supplier                   : Association to BusinessPartner.A_SupplierPurchasingOrg;
        SupplierName               : String(80);
        Language                   : Association to Languages default 'EN';
        PurchaseOrderDate          : Date;
        DocumentCurrency           : Association to Currencies default 'USD';
        PurchasingProcessingStatus : Association to OverallStatus;
        TotalAmount                : Decimal    @Core.Computed: true;
        to_PurchaseOrderItem       : Composition of many PurchaseOrderItem
                                         on to_PurchaseOrderItem.PurchaseOrder = $self;
};

entity PurchaseOrderItem : cuid {
    key PurchaseOrderItem         : String(5);
        PurchaseOrderItemText     : String(40);
        Plant                     : Association to Plant.A_Plant;
        PlantName                 : String(30);
        StorageLocation           : Association to StorageLocation.StorageLocation;
        StorageLocationName       : String(16);
        Material                  : Association to Product.A_Product;
        MaterialName              : String(40);
        MaterialGroup             : String(9);
        ProductType               : String(4);
        NetPriceQuantity          : Decimal;
        OrderPriceUnit            : Association to Units;
        NetPriceAmount            : Decimal;
        DocumentCurrency          : Association to Currencies;
        OrderQuantity             : Decimal;
        PurchaseOrderQuantityUnit : Association to Units;
        TaxCode                   : String(2);
        PurchaseOrder             : Association to PurchaseOrderHeader;
};


entity OverallStatus : CodeList {
    key code        : String enum {
            H = 'En Retención'; // On Hold (Borrador) - Mapea a '01' de SAP
            A = 'Activo'; // Active (Aprobado y Enviado) - Mapea a '05' de SAP
            C = 'Completado'; // Completed - Mapea a '06' de SAP
            R = 'Rechazado'; // Rejected - Mapea a '03' de SAP
        };
        criticality : Integer;
};

entity Units : CodeList {
    key code : String(3);
}
