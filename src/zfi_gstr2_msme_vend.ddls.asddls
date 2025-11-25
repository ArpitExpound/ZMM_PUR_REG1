@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'gstr2 - MSME Vendor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_MSME_VEND 
 as select from I_OperationalAcctgDocItem as a
               left outer join I_BuPaIdentification as b on b.BusinessPartner = a.Supplier
                                                         and b.BPIdentificationType = 'MSME V'       

{

  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,
      case b.BPIdentificationNumber 
      when '' then 'NO'
      else 'Yes'
      end as MsmeStatus

}
where
  a.FinancialAccountType = 'K'
group by
  a.CompanyCode,
  a.FiscalYear,
  a.AccountingDocument,
  a.GLAccount,
  b.BPIdentificationNumber
