@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - All SGST amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_SGST_AMT
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
       when ( TaxCode <> 'R1' and TaxCode <> 'R2'  and TaxCode <> 'R3'  and TaxCode <> 'R4'  )
      //      TaxCode between 'CA' and 'CH'
       then  AmountInTransactionCurrency
      //      when TaxCode between 'DA' and 'DH'
      //      then  AmountInTransactionCurrency
       else cast('0.00'as abap.curr( 13,2))
       end                     ) as SGSTAmt,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum ( case
       when ( TaxCode = 'R1' or TaxCode = 'R2'  or TaxCode = 'R3'  or TaxCode = 'R4'  )
      //      TaxCode between 'CA' and 'CH'
       then  AmountInTransactionCurrency
//       when TaxCode between 'DA' and 'DH'
//       then  AmountInTransactionCurrency
       else cast('0.00'as abap.curr( 13,2))
       end                     ) as RcmSGST

}
where
  (
       TransactionTypeDetermination = 'JIS'
//    or TransactionTypeDetermination = 'JIU'
  )
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  TransactionTypeDetermination
//  AmountInTransactionCurrency,
//  TransactionTypeDetermination
