@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR1_PO_DETS 
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
  (
       AccountingDocumentType       = 'DR'
    or AccountingDocumentType       = 'RV'
  )
  and  TransactionTypeDetermination = 'WRX'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  PurchasingDocument,
  BaseUnit,
  PurchasingDocumentPriceUnit,
  PurchaseOrderQty
