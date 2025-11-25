@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sgst value for sa doc'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_TAX_AMT_SSA 
as select from I_OperationalAcctgDocItem
{
  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
//  key    GLAccount,
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
      max( cast(
      case when GLAccount = '0000148002' then cast(AmountInTransactionCurrency as abap.dec(15,2)) else 0 end
      as abap.dec(15,2))                                                )                  as sGSTAmtDec,
      //    sum(case when GLAccount = '0000148003' then AmountInTransactionCurrency else 0 end) as IGSTAmtDec,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    max (  cast(
      case when GLAccount = '0000148015' then cast(AmountInTransactionCurrency as abap.dec(15,2)) else 0 end
      as abap.dec(15,2))  ) as SGST,
//      sum(case when GLAccount = '0000148012' then AmountInTransactionCurrency else 0 end) as RIGST
      //    case
      //    when GLAccount = '0000148003' then
      //    cast( AmountInTransactionCurrency as abap.dec(15,2) ) end as IGSTAmtDec,
      //
      //    case
      //    when GLAccount = '0000148012' then
      //    cast( AmountInTransactionCurrency as abap.dec(15,2) ) end as RIGST
      
      max(
    case
      when GLAccount = '0000148002'
           and cast(AmountInTransactionCurrency as abap.dec(15,2)) > 0
      then GLAccount
      when GLAccount = '0000148015'
           and cast(AmountInTransactionCurrency as abap.dec(15,2)) > 0
      then GLAccount
//      when TransactionTypeDetermination = 'JII'
//           and cast(AmountInTransactionCurrency as abap.dec(15,2)) > 0
//      then GLAccount
//      else ''
    end
  )                                  as GLAccount


}

where
       AccountingDocumentType = 'SA'
  and(
       GLAccount              = '0000148002'
    or GLAccount              = '0000148015'
  )

group by
  AccountingDocument,
  CompanyCode,
  FiscalYear,
  GLAccount,
  AccountingDocumentType,
  CompanyCodeCurrency,
  AmountInTransactionCurrency
