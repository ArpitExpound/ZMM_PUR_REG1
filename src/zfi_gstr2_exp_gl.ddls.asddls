@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Expense GL details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_EXP_GL  as select from    I_OperationalAcctgDocItem as a
    left outer join I_CnsldtnGLAccountVH      as h on  a.CostElement     = h.GLAccount
                                                   and h.ChartOfAccounts = 'YCOA'
{

  key a.CompanyCode,
  key a.AccountingDocument,
  key a.FiscalYear,
      a.CostElement,
      a.TaxCode,
      h.GLAccountName
}
where
  a.CostElement is not initial
group by
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.CostElement,
  a.TaxCode,
  h.GLAccountName
