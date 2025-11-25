@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cgst value for sa doc'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAX_AMT_CSA 
as select from I_OperationalAcctgDocItem
{
  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
  key    GLAccount,
      AccountingDocumentType,
      CompanyCodeCurrency,
      //    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //    AmountInTransactionCurrency   ,
      //    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //    cast(
      //        case
      //            when GLAccount = '0000148003' then AmountInTransactionCurrency
      //            else 0
      //        end
      //    as abap.dec(15,2)) as IGSTAmtDec,
      //
      //    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //    cast(
      //        case
      //            when GLAccount = '0000148012' then AmountInTransactionCurrency
      //            else 0
      //        end
      //    as abap.dec(15,2)) as RIGST

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case when GLAccount = '0000148003' then cast(AmountInTransactionCurrency as abap.dec(15,2)) else 0 end
      as abap.dec(15,2))                                                                  as cGSTAmtDec,
      //    sum(case when GLAccount = '0000148003' then AmountInTransactionCurrency else 0 end) as IGSTAmtDec,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case when GLAccount = '0000148014' then cast(AmountInTransactionCurrency as abap.dec(15,2)) else 0 end
      as abap.dec(15,2))  as cGST
//      sum(case when GLAccount = '0000148012' then AmountInTransactionCurrency else 0 end) as RIGST
      //    case
      //    when GLAccount = '0000148003' then
      //    cast( AmountInTransactionCurrency as abap.dec(15,2) ) end as IGSTAmtDec,
      //
      //    case
      //    when GLAccount = '0000148012' then
      //    cast( AmountInTransactionCurrency as abap.dec(15,2) ) end as RIGST


}

where
       AccountingDocumentType = 'SA'
  and(
       GLAccount              = '0000148003'
    or GLAccount              = '0000148014'
  )

group by
  AccountingDocument,
  CompanyCode,
  FiscalYear,
  GLAccount,
  AccountingDocumentType,
  CompanyCodeCurrency,
  AmountInTransactionCurrency   
