@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'tac percentage interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_fit_tax_perc as select from zfit_tax_perc
{
    key taxcode as Taxcode,
    igst_rate as IgstRate,
    cgst_rate as CgstRate,
    sgst_rate as SgstRate,
    rcm_igst_rate as RcmIgstRate,
    rcm_cgst_rate as RcmCgstRate,
    rcm_sgst_rate as RcmSgstRate,
    localcreatedby as Localcreatedby,
    localcreatedat as Localcreatedat,
    locallastchangedby as Locallastchangedby,
    locallastchangedat as Locallastchangedat,
    lastchangedat as Lastchangedat
}
