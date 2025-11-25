@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'tax percentage'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_FIT_TAX_PREC as select from zi_fit_tax_perc
//composition of target_data_source_name as _association_name
{
    key Taxcode,
    IgstRate,
    CgstRate,
    SgstRate,
    RcmIgstRate,
    RcmCgstRate,
    RcmSgstRate,
    Localcreatedby,
    Localcreatedat,
    Locallastchangedby,
    Locallastchangedat,
    Lastchangedat
//    _association_name // Make association public
}
