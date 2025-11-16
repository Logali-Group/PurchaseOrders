using {com.globaltalent.purchaseorder as entitites} from '../db/schema';

using {API_COMPANYCODE_SRV} from './external/API_COMPANYCODE_SRV';
using {CE_PURCHASINGORGANIZATION_0001 as Organization} from './external/CE_PURCHASINGORGANIZATION_0001';
using {API_BUSINESS_PARTNER as BusinessPartner} from './external/API_BUSINESS_PARTNER';
using {CE_PURCHASINGGROUP_0001 as Group} from './external/CE_PURCHASINGGROUP_0001';
using {ZCE_PURCHASEORDERTYPE as PurchaseOrderType} from './external/ZCE_PURCHASEORDERTYPE';
using {API_PLANT_SRV as Plant} from './external/API_PLANT_SRV';
using {API_STORAGELOCATION_SRV as StorageLocation} from './external/API_STORAGELOCATION_SRV';
using {API_PRODUCT_SRV as Product} from './external/API_PRODUCT_SRV';

service PurchaseOrder {
    entity PurchaseOrder          as projection on entitites.PurchaseOrderHeader
        actions {
            @Core.OperationAvailable: {
                $edmJson: {
                    $If: [
                        {
                            $Eq: [
                                {
                                    $Path: 'in/PurchasingProcessingStatus_code'
                                },
                                {
                                    $String: 'A'
                                }
                            ]
                        },
                        true,
                        false
                    ]
                }
            }
            @Common.SideEffects     : {
                $Type         : 'Common.SideEffectsType',
                TargetEntities: [
                    in.PurchasingProcessingStatus
                ]
            }
            action submitOrder(in: $self) returns PurchaseOrder;
        };

    entity PurchaseOrderItem      as projection on entitites.PurchaseOrderItem;

    /** Value Helps - External */
    
    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_Companies          as
        projection on API_COMPANYCODE_SRV.A_CompanyCode {
            key CompanyCode,
                CompanyCodeName,
                Country,
                CityName,
                Language
        };

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_Organizations      as
        projection on Organization.A_PurchasingOrganization {
            key PurchasingOrganization,
                PurchasingOrganizationName,
                CompanyCode
        }

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_Groups             as
        projection on Group.A_PurchasingGroup {
            key PurchasingGroup,
                PurchasingGroupName
        };

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_Suppliers          as
        projection on BusinessPartner.A_Supplier {
            key Supplier,
                SupplierName,
                to_SupplierPurchasingOrg.PurchasingOrganization as PurchasingOrganization
        };

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_PurchaseOrderTypes as
        projection on PurchaseOrderType.PurchaseOrderType {
            key PurchaseOrderType,
                PurchaseOrderTypeName
        }

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_Plants             as
        projection on Plant.A_Plant {
            key Plant,
                PlantName,
                CompanyCode,
                CompanyCodeName
        }

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_StorageLocation    as
        projection on StorageLocation.StorageLocation {
            key StorageLocation,
                StorageLocationName,
            key Plant
        };

    @cds.persistence.exists
    @cds.persistence.skip
    entity VHE_Product            as
        projection on Product.A_Product {
            key Product,
                to_Description.ProductDescription               as ProductName,
                ProductGroup,
                ProductType,
                to_ProductProcurement.PurchaseOrderQuantityUnit as PurchaseOrderQuantityUnit,
                to_Plant.Plant                                  as Plant
        };
};
