using {PurchaseOrder} from '../service';


annotate PurchaseOrder.OverallStatus with {
    code @title : 'Codes'
    @Common : { 
        Text : name,
        TextArrangement : #TextOnly
     }
};
