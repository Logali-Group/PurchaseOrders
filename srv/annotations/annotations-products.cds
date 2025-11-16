using {PurchaseOrder} from '../service';

annotate PurchaseOrder.VHE_Product with {
    Plant                     @title: 'Plant';
    Product                   @title: 'Product';
    ProductName               @title: 'Product Name';
    ProductGroup              @title: 'Product Group';
    ProductType               @title: 'Product Type';
    PurchaseOrderQuantityUnit @title: 'Base Unit';
};
