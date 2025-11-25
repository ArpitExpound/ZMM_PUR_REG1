@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HSN details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_HSN as select from I_OperationalAcctgDocItem
{

  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
//  key AccountingDocumentItem,
      GLAccount,
      AccountingDocumentType,
      CompanyCodeCurrency,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
       AmountInTransactionCurrency
    
}

where GLAccount = '0000450034'
