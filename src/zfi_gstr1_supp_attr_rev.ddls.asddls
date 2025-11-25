@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 - Supply supp attr rev'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR1_SUPP_ATTR_REV 
 as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      case
      when TaxCode between 'CA' and 'CL'
      then 'YES'
      when TaxCode between 'DA' and 'DL'
      then 'YES'
      else 'NO'
      end as SuppAttRevChrge
}
where
     AccountingDocumentType = 'DR'
  or AccountingDocumentType = 'RD'
  or AccountingDocumentType = 'RV'
  or AccountingDocumentType = 'VR'
  or AccountingDocumentType = 'DG'
  or AccountingDocumentType = 'GD'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TaxCode
