@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - supply attract reverse chanrge'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_SUPP_ATTR_REV
  as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      case
      when TaxCode between 'R1' and 'R8'
      then 'YES'
      when TaxCode between 'RA' and 'RD'
      then 'YES'
      else 'NO'
      end as SuppAttRevChrge,

      case
      when TaxCode between 'DI' and 'DL'
      then 'YES'
      when TaxCode between 'DA' and 'DH'
      then 'YES'
      else 'NO'
      end as NDGst
}
where
   (  AccountingDocumentType = 'RE'
  or AccountingDocumentType = 'KR'
  or AccountingDocumentType = 'KG' )
  and TaxCode <> ''
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TaxCode
