@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - All CGST amounts'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_CGST_AMT
  as select from I_OperationalAcctgDocItem
{

  key       CompanyCode,
  key       AccountingDocument,
  key       FiscalYear,
  key       TaxCode,
            CompanyCodeCurrency,
            TransactionTypeDetermination,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

            //      AmountInTransactionCurrency as CGSTAmt,
            sum(
            case
            when ( TaxCode <> 'R1' and TaxCode <> 'R2'  and TaxCode <> 'R3'  and TaxCode <> 'R4' 
            and TaxCode <> 'RA' and TaxCode <> 'RB' and TaxCode <> 'RC' and TaxCode <> 'RD' )
            then AmountInTransactionCurrency
            else cast( '0.00' as abap.curr( 13, 2 ) )
            end
            ) as CGSTAmt,
            //      case
            //      when ( TaxCode <> 'R5' and TaxCode <> 'R6'  and TaxCode <> 'R7'  and TaxCode <> 'R8' and TaxCode <> 'R9'  )
            ////      TaxCode between 'CA' and 'CH'
            //      then  AmountInTransactionCurrency
            ////      when TaxCode between 'DA' and 'DH'
            ////      then  AmountInTransactionCurrency
            //      else cast('0.00'as abap.curr( 13,2))
            //      end                         as CGSTAmt,


            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            sum(
            case
            when ( TaxCode = 'R1' or TaxCode = 'R2'  or TaxCode = 'R3'  or TaxCode = 'R4'   
            or TaxCode = 'RA' or TaxCode = 'RB' or TaxCode = 'RC' or TaxCode = 'RD')
            then AmountInTransactionCurrency
            else cast( '0.00' as abap.curr( 13, 2 ) )
            end
            ) as RcmCGST
            //            case
            //            when ( TaxCode = 'R5' or TaxCode = 'R6'  or TaxCode = 'R7'  or TaxCode = 'R8' or TaxCode = 'R9'  )
            //            //      TaxCode between 'CA' and 'CH'
            //            then  AmountInTransactionCurrency
            //            when TaxCode between 'DA' and 'DH'
            //            then  AmountInTransactionCurrency
            //            else cast('0.00'as abap.curr( 13,2))
            //            end as RcmCGST

}
where
  TransactionTypeDetermination = 'JIC'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  TransactionTypeDetermination
//  AmountInTransactionCurrency,
//  TransactionTypeDetermination
