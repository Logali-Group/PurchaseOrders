using {PurchaseOrder} from '../service';

annotate PurchaseOrder.VHE_Plants with {
    Plant @title : 'Plant';
    PlantName @title : 'Plant Name';
    CompanyCode @title : 'Company Code';
    CompanyCodeName @title : 'Company Name';
};

annotate PurchaseOrder.VHE_Plants with @(
    UI.SelectionFields  : [
        CompanyCode
    ]
);

