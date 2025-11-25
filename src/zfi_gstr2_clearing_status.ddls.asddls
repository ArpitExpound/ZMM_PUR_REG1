@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Clearing status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_CLEARING_STATUS
 as select from I_OperationalAcctgDocItem

{
  key CompanyCode,
  key FiscalYear,
  key AccountingDocument,
      ClearingJournalEntry,
      case
      when ClearingJournalEntry is not initial then 'X'
      end as clearind

}
where //ClearingJournalEntry is not initial and
  ClearingJournalEntry like '15%'
