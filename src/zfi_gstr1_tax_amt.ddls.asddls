@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 - Tax amounts'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_TAX_AMT 
as select from  I_OperationalAcctgDocTaxItem as a

    left outer join ZFI_GSTR1_IGST_AMT           as c on  a.CompanyCode        = c.CompanyCode
                                                      and a.AccountingDocument = c.AccountingDocument
                                                      and a.FiscalYear         = c.FiscalYear
                                                      and a.TaxCode            = c.TaxCode

    left outer join ZFI_GSTR1_CGST_AMT           as d on  a.CompanyCode        = d.CompanyCode
                                                      and a.AccountingDocument = d.AccountingDocument
                                                      and a.FiscalYear         = d.FiscalYear
                                                      and a.TaxCode            = d.TaxCode

    left outer join ZFI_GSTR1_SGST_AMT           as e on  a.CompanyCode        = e.CompanyCode
                                                      and a.AccountingDocument = e.AccountingDocument
                                                      and a.FiscalYear         = e.FiscalYear
                                                      and a.TaxCode            = e.TaxCode

    left outer join ZFI_GSTR1_UGST_AMT           as b on  a.CompanyCode        = b.CompanyCode
                                                      and a.AccountingDocument = b.AccountingDocument
                                                      and a.FiscalYear         = b.FiscalYear
                                                      and a.TaxCode            = b.TaxCode
{

  key       a.CompanyCode,
  key       a.AccountingDocument,
  key       a.FiscalYear,
  key       a.TaxCode,
            c.CompanyCodeCurrency,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            c.IGSTAmt,

            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            d.CGSTAmt,

            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            e.SGSTAmt,

            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            b.UGSTAmt

}
where
     a.TransactionTypeDetermination = 'JOI'
  or a.TransactionTypeDetermination = 'JOC'
  or a.TransactionTypeDetermination = 'JOS'
  or a.TransactionTypeDetermination = 'JOU'
group by
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.TaxCode,
  c.CompanyCodeCurrency,
  c.IGSTAmt,
  d.CGSTAmt,
  e.SGSTAmt,
  b.UGSTAmt
