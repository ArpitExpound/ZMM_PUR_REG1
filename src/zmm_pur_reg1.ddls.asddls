@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Profit Center details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_PUR_REG1 
 as select from    I_OperationalAcctgDocItem as a
    left outer join I_ProfitCenterText        as b on a.ProfitCenter = b.ProfitCenter

{

  key a.CompanyCode,
  key a.AccountingDocument,
  key a.FiscalYear,
      a.ProfitCenter,
      b.ProfitCenterName
}
where
  a.ProfitCenter is not initial
group by
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.ProfitCenter,
  b.ProfitCenterName
