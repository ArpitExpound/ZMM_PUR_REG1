@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 taxable amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAXABLE_AMT 
 as select from I_OperationalAcctgDocTaxItem

{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
  key TaxItem,
      TransactionCurrency,
      TransactionTypeDetermination,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TaxBaseAmountInTransCrcy as TaxableAmt

}
where
     TransactionTypeDetermination = 'JII'
  or TransactionTypeDetermination = 'JIC'
  or TransactionTypeDetermination = 'JIS'
  or TransactionTypeDetermination = 'NVV'
  or TransactionTypeDetermination = 'JIU'
  
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TransactionCurrency,
  TaxBaseAmountInTransCrcy,
  TransactionTypeDetermination,
  TaxCode,
  TaxItem
