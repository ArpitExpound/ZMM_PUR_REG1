@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Po related details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_PO_DETS 
  as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      PurchasingDocument,
      BaseUnit,
      PurchasingDocumentPriceUnit,
      @Semantics.quantity.unitOfMeasure: 'PurchasingDocumentPriceUnit'
      PurchaseOrderQty
}
where
      AccountingDocumentType       = 'RE'
  and TransactionTypeDetermination = 'WRX'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  PurchasingDocument,
  BaseUnit,
  PurchasingDocumentPriceUnit,
  PurchaseOrderQty
