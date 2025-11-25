@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SGST amount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR1_SGST_AMT 
 as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      CompanyCodeCurrency,
      TaxCode,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      AmountInTransactionCurrency as SGSTAmt
}
where
  TransactionTypeDetermination = 'JOS'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  AmountInTransactionCurrency,
  TransactionTypeDetermination
