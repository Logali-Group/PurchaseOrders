using {PurchaseOrder} from '../service';


annotate PurchaseOrder.VHE_Groups with {
    @title : 'Groups'
    PurchasingGroup @Common: {
        Text : PurchasingGroupName,
        TextArrangement : #TextOnly
    };
};
