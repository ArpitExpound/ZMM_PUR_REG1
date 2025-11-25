@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZFIT_TAX_PERC'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_FIT_TAX_PERC
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_FIT_TAX_PERC000
  association [1..1] to ZR_FIT_TAX_PERC000 as _BaseEntity on $projection.TAXCODE = _BaseEntity.TAXCODE
{
  key Taxcode,
  IgstRate,
  CgstRate,
  SgstRate,
  RcmIgstRate,
  RcmCgstRate,
  RcmSgstRate,
  @Semantics: {
    User.Createdby: true
  }
  Localcreatedby,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  Localcreatedat,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  Locallastchangedby,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchangedat,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  Lastchangedat,
  _BaseEntity
}
