using {PurchaseOrder} from '../service';

annotate PurchaseOrder.VHE_Companies with {
    @title : 'Companies'
    CompanyCode @Common: {
        Text : CompanyCodeName,
        TextArrangement :  #TextFirst
    }
};
