@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'gstr2 report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAXAMT_F 
 as select from ZFI_GSTR2_TAXABLE_AMT

{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
      TransactionCurrency,
      TransactionTypeDetermination,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(TaxableAmt) as TaxableAmt
}
group by
    CompanyCode,
    AccountingDocument,
    FiscalYear,
    TaxCode,
    TransactionTypeDetermination,
    TransactionCurrency
