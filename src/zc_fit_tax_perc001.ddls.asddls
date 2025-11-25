@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZFIT_TAX_PERC001'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_FIT_TAX_PERC001
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_FIT_TAX_PERC002
  association [1..1] to ZR_FIT_TAX_PERC002 as _BaseEntity on $projection.TAXCODE = _BaseEntity.TAXCODE
{
  key Taxcode,
  IgstRate,
  CgstRate,
  SgstRate,
  UgstRate,
  RcmIgstRate,
  RcmCgstRate,
  RcmSgstRate,
  RcmUgstRate,
  Taxkay,
  Glacc,
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
