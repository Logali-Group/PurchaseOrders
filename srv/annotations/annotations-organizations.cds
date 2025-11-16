using {PurchaseOrder} from '../service';

annotate PurchaseOrder.VHE_Organizations with {
    @title : 'Organizations'
    PurchasingOrganization @Common: {
        Text : PurchasingOrganizationName,
        TextArrangement :  #TextOnly
    }
};
