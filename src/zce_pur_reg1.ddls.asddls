@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report Main'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZCE_PUR_REG1 
//as select from data_source_name
//composition of target_data_source_name as _association_name
as select distinct from    ZFI_GSTR2_REP1               as a
    left outer join ZFI_GSTR2_SUPP_ATTR_REV      as b on  a.CompanyCode        = b.CompanyCode
//                                                      and a.AccountingDocument = b.AccountingDocument
//                                                      and a.FiscalYear         = b.FiscalYear
//
//    left outer join ZFI_GSTR2_TAX_AMT_FINAL      as c on  a.CompanyCode        = c.CompanyCode
//                                                      and a.AccountingDocument = c.AccountingDocument
//                                                      and a.FiscalYear         = c.FiscalYear
////                                                      and a.taxcode1 = c.TaxCode                        ////////add by sandeep
//                                                       
//    left outer join ZR_FIT_TAX_PERC              as n on c.TaxCode = n.Taxcode
//    left outer join I_TaxCodeText                as k on c.TaxCode = k.TaxCode
//    left outer join I_EnterpriseProjectElement_2 as m on a.WBSElementInternalID = m.WBSElementInternalID
//    left outer join ZFI_GSTR2_EXP_GL             as h on  c.AccountingDocument = h.AccountingDocument
//                                                      and c.FiscalYear         = h.FiscalYear
//                                                      and c.CompanyCode        = h.CompanyCode
//                                                      and c.TaxCode            = h.TaxCode
{
  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument
//  key c.TaxCode,
//      a.CompanyCodeCurrency,
//      a.CustGstin,
//      a.BusinessPlace,
////      h.CostElement   as ExpGLAcct,
////      h.GLAccountName as ExpGLDesp,
//      a.InvoiceRefNum,
//      a.DocumentType,
//      a.DocumentDate,
//      a.PostingDate,
//      a.Supplier,
//      a.BPSupplierFullName,
//      a.SupplierGSTIN,
//      a.CityName,
//      a.RegionName,
//      a.PlaceOfSupply,
//      b.SuppAttRevChrge,
//      a.PoDocument
      //      c.TaxCode,
//      k.TaxCodeName   as TaxCodeDesp,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      a.ItemTaxAmt,
//      n.IgstRate,
//      n.CgstRate,
//      n.SgstRate,
//      n.RcmIgstRate,
//      n.RcmCgstRate,
//      n.RcmSgstRate,
////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.IGSTAmt,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.RcmIGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.NonDedIGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.NonDedRcmIGST,
////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.CGSTAmt,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.RcmCGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.NonDedCGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.NonDedRcmCGST,
////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.SGSTAmt,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.RcmSGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.NonDedSGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      c.NonDedRcmSGST,
//      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//      a.InvoiceVal,
//      b.NDGst,
//      //      a.HsnSacCode,
//      a.ProfitCenter,
//      a.ProfitCenterDesp,
//      //      a.HsnNature,
//      a.GstinStatus,
//      //      @Semantics.quantity.unitOfMeasure: 'Uom'
//      //      a.Qty,
//      //      a.Uom,
//      a.ParkBy,
//      a.PostBy,
//      a.Pan,
//      a.MsmeStatus,
//      case a.clearind
//      when 'X'
//      then 'Cleared'
//      else 'Open'
//      end             as ClearStatus,
//      a.InvRefNumber,
//      m.ProjectElement
//
}
//group by
//  a.CompanyCode,
//  a.FiscalYear,
//  a.AccountingDocument,
//  a.CompanyCodeCurrency,
//  a.CustGstin,
//  a.BusinessPlace,
//  //  a.ExpGLAcct,
//  //  a.ExpGLDesp,
//  a.InvoiceRefNum,
//  a.DocumentType,
//  a.DocumentDate,
//  a.PostingDate,
//  a.Supplier,
//  a.BPSupplierFullName,
//  a.SupplierGSTIN,
//  a.CityName,
//  a.RegionName,
//  a.PlaceOfSupply,
//  b.SuppAttRevChrge,
//  a.PoDocument,
//  c.TaxCode,
//  k.TaxCodeName,
//  a.ItemTaxAmt,
//  n.IgstRate,
//  n.CgstRate,
//  n.SgstRate,
//  n.RcmIgstRate,
//  n.RcmCgstRate,
//  n.RcmSgstRate,
//  c.IGSTAmt,
//  c.RcmIGST,
//  c.NonDedIGST,
//  c.NonDedRcmIGST,
//  c.CGSTAmt,
//  c.RcmCGST,
//  c.NonDedCGST,
//  c.NonDedRcmCGST,
//  c.SGSTAmt,
//  c.RcmSGST,
//  c.NonDedSGST,
//  c.NonDedRcmSGST,
//  a.InvoiceVal,
//  b.NDGst,
//  //  a.HsnSacCode,
//  a.ProfitCenter,
//  a.ProfitCenterDesp,
//  //  a.HsnNature,
//  a.GstinStatus,
////  a.Qty,
////  a.Uom,
//  a.ParkBy,
//  a.PostBy,
//  a.Pan,
//  a.BusinessPlace,
//  a.MsmeStatus,
//  a.clearind,
//  a.InvRefNumber,
//  m.ProjectElement,
//  h.CostElement,
//  h.GLAccountName
