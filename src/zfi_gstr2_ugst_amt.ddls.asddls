@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - All UGST amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_UGST_AMT 
as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
      CompanyCodeCurrency,
      TransactionTypeDetermination,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

      //      AmountInTransactionCurrency as SGSTAmt,

      sum ( case
       when ( TaxCode <> 'RA' and TaxCode <> 'RB'  and TaxCode <> 'RC'  and TaxCode <> 'RD'  )
      //      TaxCode between 'CA' and 'CH'
       then  AmountInTransactionCurrency
      //      when TaxCode between 'DA' and 'DH'
      //      then  AmountInTransactionCurrency
       else cast('0.00'as abap.curr( 13,2))
       end                     ) as UGSTAmt,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum ( case
       when ( TaxCode = 'RA' or TaxCode = 'RB'  or TaxCode = 'RC'  or TaxCode = 'RD'  )
      //      TaxCode between 'CA' and 'CH'
       then  AmountInTransactionCurrency
//       when TaxCode between 'DA' and 'DH'
//       then  AmountInTransactionCurrency
       else cast('0.00'as abap.curr( 13,2))
       end                     ) as RcmUGST

}
where
  (
//       TransactionTypeDetermination = 'JIS'
     TransactionTypeDetermination = 'JIU'
  )
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  TransactionTypeDetermination
