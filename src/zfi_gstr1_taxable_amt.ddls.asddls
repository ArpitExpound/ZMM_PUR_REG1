@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 - taxable item amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_TAXABLE_AMT 
as select from I_OperationalAcctgDocTaxItem

{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TaxBaseAmountInTransCrcy as TaxableAmt

}
where
     TransactionTypeDetermination = 'JOI'
  or TransactionTypeDetermination = 'JOC'
  or TransactionTypeDetermination = 'JOS'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TransactionCurrency,
  TaxBaseAmountInTransCrcy
