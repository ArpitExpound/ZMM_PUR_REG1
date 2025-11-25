@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'gstr2 - MSME status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_MSME_VEND1
 as select from ZFI_GSTR2_MSME_VEND

{
  key CompanyCode,
  key FiscalYear,
  key AccountingDocument,
      MsmeStatus

}
group by
  CompanyCode,
  FiscalYear,
  AccountingDocument,
  MsmeStatus
