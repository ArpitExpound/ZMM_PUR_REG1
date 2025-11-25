@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - WBS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_WBS 
 as select from I_OperationalAcctgDocItem as a
{

  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,
      WBSElementInternalID
}
where
  WBSElementInternalID is not initial
