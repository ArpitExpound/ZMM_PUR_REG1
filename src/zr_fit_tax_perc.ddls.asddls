@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Generated core data service entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_FIT_TAX_PERC  as select from zfit_tax_perc
{
  key taxcode            as Taxcode,
      igst_rate          as IgstRate,
      cgst_rate          as CgstRate,
      sgst_rate          as SgstRate,
      ugst_rate          as UgstRate,
      rcm_igst_rate      as RcmIgstRate,
      rcm_cgst_rate      as RcmCgstRate,
      rcm_sgst_rate      as RcmSgstRate,
      rcm_ugst_rate      as RcmUgstRate,
      @Semantics.user.createdBy: true
      localcreatedby     as Localcreatedby,
      @Semantics.systemDateTime.createdAt: true
      localcreatedat     as Localcreatedat,
      @Semantics.user.localInstanceLastChangedBy: true
      locallastchangedby as Locallastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as Locallastchangedat,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as Lastchangedat

}
