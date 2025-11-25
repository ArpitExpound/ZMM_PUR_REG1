@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'IGST amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_IGST_AMT_N 
 as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
      CompanyCodeCurrency,
      TransactionTypeDetermination,  
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

      //      AmountInTransactionCurrency as IGSTAmt,
    
    sum( AmountInTransactionCurrency ) as IGSTAmt
//      sum(
//      case
//      when ( TaxCode = 'CC'  )
//      then AmountInTransactionCurrency
//      else cast( '0.00' as abap.curr( 13, 2 ) )
//      end
//      ) as IGSTAmt

      //      case
      //      when ( TaxCode <> 'R5' and TaxCode <> 'R6'  and TaxCode <> 'R7'  and TaxCode <> 'R8' and TaxCode <> 'R9'  )
      ////      TaxCode between 'CA' and 'CH'
      //      then  AmountInTransactionCurrency
      ////      when TaxCode between 'DA' and 'DH'
      ////      then  AmountInTransactionCurrency
      //      else cast('0.00'as abap.curr( 13,2))
      //      end                         as IGSTAmt,

//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      sum(
//      case
//      when ( TaxCode = 'R5' or TaxCode = 'R6'  or TaxCode = 'R7'  or TaxCode = 'R8' or TaxCode = 'R9' 
//       )
//      then AmountInTransactionCurrency
//      else cast( '0.00' as abap.curr( 13, 2 ) )
//      end
//      ) as RcmIGST

      //      case
      //      when ( TaxCode = 'R5' or TaxCode = 'R6'  or TaxCode = 'R7'  or TaxCode = 'R8' or TaxCode = 'R9'  )
      //      //      between 'R4' and 'R10'
      //      then  AmountInTransactionCurrency
      //      //      when TaxCode between 'DA' and 'DH'
      //      //      then  AmountInTransactionCurrency
      //      else cast('0.00'as abap.curr( 13,2))
      //      end as RcmIGST

}
where
    AccountingDocumentItemType = 'T' 
  and TransactionTypeDetermination = ''  
  and AccountingDocumentType = 'RE'
//  TransactionTypeDetermination = 'JII'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TransactionTypeDetermination,
  TaxCode
