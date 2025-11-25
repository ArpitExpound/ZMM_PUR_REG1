@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'IGST amount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR1_IGST_AMT 
  as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      CompanyCodeCurrency,
      TaxCode,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      AmountInTransactionCurrency as IGSTAmt
}
where
  TransactionTypeDetermination = 'JOI'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  AmountInTransactionCurrency,
  TransactionTypeDetermination
