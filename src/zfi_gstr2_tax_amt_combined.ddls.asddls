@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'tax amt combined'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAX_AMT_COMBINED
   as select from ZFI_GSTR2_TAX_AMT_FINAL
{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  CompanyCodeCurrency,
  TaxCode,  
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(IGSTAmt,0)) as abap.dec(13,2)) as IGSTAmt,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(RcmIGST,0)) as abap.dec(13,2)) as RcmIGST,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(CGSTAmt,0)) as abap.dec(13,2)) as CGSTAmt,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(RcmCGST,0)) as abap.dec(13,2)) as RcmCGST,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(SGSTAmt,0)) as abap.dec(13,2)) as SGSTAmt,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(RcmSGST,0)) as abap.dec(13,2)) as RcmSGST,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(UGSTAmt,0)) as abap.dec(13,2)) as UGSTAmt,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(coalesce(RcmUGST,0)) as abap.dec(13,2)) as RcmUGST
}
group by CompanyCode, AccountingDocument, FiscalYear, CompanyCodeCurrency, TaxCode
