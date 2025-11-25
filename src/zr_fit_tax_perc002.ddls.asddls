@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZFIT_TAX_PERC001'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_FIT_TAX_PERC002
  as select from ZFIT_TAX_PERC
{
  key taxcode as Taxcode,
  igst_rate as IgstRate,
  cgst_rate as CgstRate,
  sgst_rate as SgstRate,
  ugst_rate as UgstRate,
  rcm_igst_rate as RcmIgstRate,
  rcm_cgst_rate as RcmCgstRate,
  rcm_sgst_rate as RcmSgstRate,
  rcm_ugst_rate as RcmUgstRate,
  taxkay as Taxkay,
  glacc as Glacc,
  @Semantics.user.createdBy: true
  localcreatedby as Localcreatedby,
  @Semantics.systemDateTime.createdAt: true
  localcreatedat as Localcreatedat,
  @Semantics.user.localInstanceLastChangedBy: true
  locallastchangedby as Locallastchangedby,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchangedat as Locallastchangedat,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat
}
