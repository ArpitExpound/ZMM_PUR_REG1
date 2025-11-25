@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Tax amount Final'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAX_AMT_FINAL 
 as select from ZFI_GSTR2_TAX_AMT

{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  CompanyCodeCurrency,
  TaxCode,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(IGSTAmt) as abap.dec(13,2)) as IGSTAmt,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(RcmIGST) as abap.dec(13,2)) as RcmIGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(NonDedIGST) as abap.dec(13,2)) as NonDedIGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(NonDedRcmIGST) as abap.dec(13,2)) as NonDedRcmIGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(CGSTAmt) as abap.dec(13,2)) as CGSTAmt,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(RcmCGST) as abap.dec(13,2)) as RcmCGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(NonDedCGST) as abap.dec(13,2)) as NonDedCGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(NonDedRcmCGST) as abap.dec(13,2)) as NonDedRcmCGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(SGSTAmt) as abap.dec(13,2)) as SGSTAmt,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(RcmSGST) as abap.dec(13,2)) as RcmSGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(UGSTAmt) as abap.dec(13,2)) as UGSTAmt,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(RcmUGST) as abap.dec(13,2)) as RcmUGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(NonDedSGST) as abap.dec(13,2)) as NonDedSGST,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum(NonDedRcmSGST) as abap.dec(13,2)) as NonDedRcmSGST
}
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TaxCode,
  CompanyCodeCurrency
    
//  key CompanyCode,
//  key AccountingDocument,
//  key FiscalYear,
//  key TaxCode,
//      CompanyCodeCurrency,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      cast( sum(IGSTAmt) as abap.dec( 13, 2 ) ) as IGSTAmt,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      cast( sum(RcmIGST) as abap.dec(13,2)) as RcmIGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(NonDedIGST) as NonDedIGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(NonDedRcmIGST) as NonDedRcmIGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      cast( sum(CGSTAmt) as abap.dec( 13, 2 ) ) as CGSTAmt,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(RcmCGST) as RcmCGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(NonDedCGST) as NonDedCGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(NonDedRcmCGST) as NonDedRcmCGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      cast( sum(SGSTAmt) as abap.dec( 13, 2 ) ) as SGSTAmt,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(RcmSGST) as RcmSGST,
//      
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(UGSTAmt) as UGSTAmt,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(RcmUGST) as RcmUGST,
//      
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(NonDedSGST) as NonDedSGST,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(NonDedRcmSGST) as NonDedRcmSGST
//
//}
//group by
//    CompanyCode,
//    AccountingDocument,
//    FiscalYear,
//    TaxCode,
//    CompanyCodeCurrency
