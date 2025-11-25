@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - IRN'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_IRN 
  as select from I_OperationalAcctgDocItem
{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      IN_InvoiceReferenceNumber
}
where
  IN_InvoiceReferenceNumber is not initial
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  IN_InvoiceReferenceNumber
