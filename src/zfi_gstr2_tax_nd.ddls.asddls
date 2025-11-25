@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Tax non dedeuctions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAX_ND 
  as select from I_OperationalAcctgDocTaxItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      CompanyCodeCurrency,
      TaxCode,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when TaxCode between 'BA' and 'BH'
      then  TaxAmountInTransCrcy
      else cast('0.00'as abap.curr( 13,2))
      end as NonDedSGST,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when TaxCode between 'DA' and 'DH'
      then   TaxAmountInTransCrcy
      else cast('0.00'as abap.curr( 13,2))
      end as NonDedRcmSGST,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when TaxCode between 'BI' and 'BL'
      then TaxAmountInTransCrcy
      else cast('0.00'as abap.curr( 13,2))
      end as NonDedIGST,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when TaxCode between 'DI' and 'DL'
      then TaxAmountInTransCrcy
      else cast('0.00'as abap.curr( 13,2))
      end as NonDedRcmIGST

}
where
  TransactionTypeDetermination = 'NVV'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  TaxAmountInTransCrcy,
  TransactionTypeDetermination
