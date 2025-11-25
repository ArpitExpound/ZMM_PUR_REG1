@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CGST gstr amount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR1_CGST_AMT as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      CompanyCodeCurrency,
      TaxCode,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      AmountInTransactionCurrency as CGSTAmt
}
where
  TransactionTypeDetermination = 'JOC'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  AmountInTransactionCurrency,
  TransactionTypeDetermination
