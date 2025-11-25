@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZFI_GSTR2_REPORT
  as select distinct from ZFI_GSTR2_REP1               as a
    left outer join       ZFI_GSTR2_SUPP_ATTR_REV      as b on  a.CompanyCode        = b.CompanyCode
                                                            and a.AccountingDocument = b.AccountingDocument
                                                            and a.FiscalYear         = b.FiscalYear

    left outer join       ZFI_GSTR2_TAX_AMT_FINAL      as c1 on  a.CompanyCode        = c1.CompanyCode
                                                            and a.AccountingDocument = c1.AccountingDocument
                                                            and a.FiscalYear         = c1.FiscalYear
//                                                            and a.taxcode1           = c.TaxCode ////////add by sandeep
    left outer join      ZFI_GSTR2_TAX_AMT_COMBINED as C on  a.CompanyCode        = C.CompanyCode
                                                            and a.AccountingDocument = C.AccountingDocument
                                                            and a.FiscalYear         = C.FiscalYear

    left outer join       ZR_FIT_TAX_PERC              as n on c1.TaxCode = n.Taxcode
    left outer join       I_TaxCodeText                as k on  c1.TaxCode  = k.TaxCode
                                                            and k.Language = 'E'
    left outer join       I_EnterpriseProjectElement_2 as m on a.WBSElementInternalID = m.WBSElementInternalID
  ////    left outer join ZFI_GSTR2_CGST_AMT      as d on  a.CompanyCode        = d.CompanyCode
  ////                                                 and a.AccountingDocument = d.AccountingDocument
  ////                                                 and a.FiscalYear         = d.FiscalYear
  ////
  ////    left outer join ZFI_GSTR2_SGST_AMT      as e on  a.CompanyCode        = e.CompanyCode
  ////                                                 and a.AccountingDocument = e.AccountingDocument
  ////                                                 and a.FiscalYear         = e.FiscalYear
    left outer join       ZFI_GSTR2_EXP_GL             as h on  C.AccountingDocument = h.AccountingDocument
                                                            and C.FiscalYear         = h.FiscalYear
                                                            and C.CompanyCode        = h.CompanyCode
                                                            and c1.TaxCode            = h.TaxCode
    left outer join       ZFI_GSTR2_TAX_AMT_ISA        as i on  a.CompanyCode        = i.CompanyCode
                                                            and a.AccountingDocument = i.AccountingDocument
                                                            and a.FiscalYear         = i.FiscalYear
    left outer join       ZFI_GSTR2_TAX_AMT_SSA        as j on  a.CompanyCode        = j.CompanyCode
                                                            and a.AccountingDocument = j.AccountingDocument
                                                            and a.FiscalYear         = j.FiscalYear
    left outer join       ZFI_GSTR2_TAX_AMT_CSA        as L on  a.CompanyCode        = L.CompanyCode
                                                            and a.AccountingDocument = L.AccountingDocument
                                                            and a.FiscalYear         = L.FiscalYear
    left outer join       ZFI_GSTR2_TAX_AMT_USA        as t on  a.CompanyCode        = t.CompanyCode
                                                            and a.AccountingDocument = t.AccountingDocument
                                                            and a.FiscalYear         = t.FiscalYear
    left outer join       ZFI_GSTR2_HSN                as u on  a.CompanyCode        = u.CompanyCode
                                                            and a.AccountingDocument = u.AccountingDocument
                                                            and a.FiscalYear         = u.FiscalYear

{
  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,
//  key a.AccountingDocumentItem,
  key c1.TaxCode,
  key a.ProfitCenter,
  key b.SuppAttRevChrge,
  key a.Supplier,
      //  key h.CostElement   as ExpGLAcct,
      a.CompanyCodeCurrency,
      a.CustGstin,
      a.BusinessPlace,
      //      h.CostElement   as ExpGLAcct,
      //      h.GLAccountName as ExpGLDesp,
      a.InvoiceRefNum,
      a.DocumentType,
      a.DocumentDate,
      a.PostingDate,
      //      a.Supplier,
      a.BPSupplierFullName,
      //      SupplierFullName,
      a.SupplierGSTIN,
      a.CityName,
      a.RegionName,
      a.PlaceOfSupply,
      //      b.SuppAttRevChrge,
      //      a.PoDocument,
      //      c.TaxCode,
      k.TaxCodeName                 as TaxCodeDesp,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
        case
          when a.TransactionCurrency = 'USD' then cast(a.ItemTaxAmt * a.AbsoluteExchangeRate as abap.dec(15,2))
          when a.TransactionCurrency = 'INR' then cast(a.ItemTaxAmt as abap.dec(15,2))
          else cast(0 as abap.dec(15,2))
        end
        as abap.dec(15,2)
      )                             as ItemTaxAmt,
      //cast(
      //  case
      //    when a.TransactionCurrency = 'USD' then cast(0 as abap.dec(15,2))
      //    when a.TransactionCurrency = 'INR' then cast(a.ItemTaxAmt as abap.dec(15,2))
      //    else cast(0 as abap.dec(15,2))
      //  end
      //  as abap.dec(15,2)
      //) as ItemTaxAmt,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
        case
          when a.TransactionCurrency = 'USD' then cast(a.ItemTaxAmt as abap.dec(15,2))
          when a.TransactionCurrency = 'INR' then cast(0 as abap.dec(15,2))
          else cast(0 as abap.dec(15,2))
        end
        as abap.dec(15,2)
      )                             as ItemTaxAmt1,
      //      a.ItemTaxAmt,
      //      a.ItemTaxAmt                  as itemtaxamt1,
      n.IgstRate,
      n.CgstRate,
      n.SgstRate,
      n.UgstRate,
      n.RcmIgstRate,
      n.RcmCgstRate,
      n.RcmSgstRate,
      n.RcmUgstRate,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //      c.IGSTAmt,
      //      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //      case when i.AccountingDocumentType = 'SA'
      //      then I.AmountInTransactionCurrency
      //      ELSE
      //      c.IGSTAmt end AS IGSTAmt,
      cast(
      case
      when i.AccountingDocumentType = 'SA' then cast(i.IGSTAmtDec as abap.curr(15,2))
      else cast(C.IGSTAmt as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as IGSTAmt,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when i.AccountingDocumentType = 'SA' then cast(i.RIGST as abap.curr(15,2))
      else cast(C.RcmIGST as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as RcmIGST,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      c1.NonDedIGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      c1.NonDedRcmIGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when L.AccountingDocumentType = 'SA' then cast(L.cGSTAmtDec as abap.curr(15,2))
      else cast(C.CGSTAmt as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as CGSTAmt,
      //      c.CGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when L.AccountingDocumentType = 'SA' then cast(L.cGSTAmtDec as abap.curr(15,2))
      else cast(C.RcmCGST as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as RcmCGST,
      //      c.RcmCGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      c1.NonDedCGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      c1.NonDedRcmCGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when j.AccountingDocumentType = 'SA' then cast(j.sGSTAmtDec as abap.curr(15,2))
      else cast(C.SGSTAmt as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as SGSTAmt,

      //      c.SGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when j.AccountingDocumentType = 'SA' then cast(j.SGST as abap.curr(15,2))
      else cast(C.RcmSGST as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as RcmSGST,
      //      c.RcmSGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when t.AccountingDocumentType = 'SA' then cast(t.uGSTAmtDec as abap.curr(15,2))
      else cast(C.UGSTAmt as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as UGSTAmt,

      //      c.UGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when t.AccountingDocumentType = 'SA' then cast(t.uGST as abap.curr(15,2))
      else cast(C.RcmUGST as abap.curr(15,2))
      end
      as abap.curr(15,2)
      )                             as RcmUGST,
      //      c.RcmUGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      c1.NonDedSGST,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      c1.NonDedRcmSGST,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
        case
          when a.TransactionCurrency = 'USD'
            then cast(
              (
                (case when coalesce(cast(C.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
                  then coalesce(cast(C.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
                  else coalesce(cast(C.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
                + (case when coalesce(cast(C.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
                  then coalesce(cast(C.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
                  else coalesce(cast(C.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
                + (case when coalesce(cast(C.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
                  then coalesce(cast(C.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
                  else coalesce(cast(C.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
                + (case when coalesce(cast(C.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
                  then coalesce(cast(C.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
                  else coalesce(cast(C.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
                + (case when coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
                  then coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
                  else coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
              )
              as abap.dec(15,2)
            )
          else cast(0 as abap.dec(15,2))
        end
        as abap.dec(15,2)
      )                             as InvoiceVal1,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(
      case
      when a.TransactionCurrency = 'USD'
      then cast(
        (
      /* full InvoiceVal1 expression here */
          (case when coalesce(cast(C.IGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.IGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.IGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(C.CGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.CGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.CGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(C.SGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.SGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.SGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(C.UGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.UGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.UGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), 0) end)
        )
        * a.AbsoluteExchangeRate
        as abap.dec(15,2)
      )
      when a.TransactionCurrency = 'INR'
      then cast(
        (
          (case when coalesce(cast(C.IGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.IGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.IGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(C.CGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.CGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.CGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(C.SGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.SGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.SGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(C.UGSTAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(C.UGSTAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(C.UGSTAmt as abap.dec(15,2)), 0) end)
          + (case when coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), 0) < 0
            then coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), 0) * -1
            else coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), 0) end)
        )
        as abap.dec(15,2)
      )
      else 0
      end
      as abap.dec(15,2)
      )                             as InvoiceVal,
      //      cast(
      //       (case when coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
      //        then coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      //        else coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
      //      + (case when coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
      //        then coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      //        else coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
      //      + (case when coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
      //        then coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      //        else coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
      //      + (case when coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
      //        then coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      //        else coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
      //      + (case when coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
      //             then coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      //             else coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
      //      //   as abap.dec(15,2)
      //      as abap.dec(15,2)
      //      )             as InvoiceVal1,
      //      a.ItemTaxAmt                  as InvoiceVal,
      
      b.NDGst,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      u.AmountInTransactionCurrency as round,
      //      a.HsnSacCode,
      //      a.ProfitCenter,
      a.ProfitCenterDesp,
      //      a.HsnNature,
      a.GstinStatus,
      //      @Semantics.quantity.unitOfMeasure: 'Uom'
      //      a.Qty,
      //      a.Uom,
      a.ParkBy,
      a.PostBy,
      a.Pan,
      a.MsmeStatus,
      case a.clearind
      when 'X'
      then 'Cleared'
      else 'Open'
      end                           as ClearStatus,
      a.InvRefNumber,
      m.ProjectElement,
      a.AbsoluteExchangeRate,
      a.TransactionCurrency

}
//where
//  a.Supplier <> ''
//where c.TaxCode <> 'C0'
group by
  a.CompanyCode,
  a.FiscalYear,
  a.AccountingDocument,
//  a.AccountingDocumentItem,
  a.CompanyCodeCurrency,
  a.CustGstin,
  a.BusinessPlace,
  //  a.ExpGLAcct,
  //  a.ExpGLDesp,
  a.InvoiceRefNum,
  a.DocumentType,
  a.DocumentDate,
  a.PostingDate,
  a.Supplier,
  a.BPSupplierFullName,
  a.SupplierGSTIN,
  a.CityName,
  a.RegionName,
  a.PlaceOfSupply,
  b.SuppAttRevChrge,
  //  a.PoDocument,
  c1.TaxCode,
  k.TaxCodeName,
  a.ItemTaxAmt,
  n.IgstRate,
  n.CgstRate,
  n.SgstRate,
  n.UgstRate,
  n.RcmIgstRate,
  n.RcmCgstRate,
  n.RcmSgstRate,
  n.RcmUgstRate,
  i.AccountingDocumentType,
  //  i.AmountInTransactionCurrency,
  i.IGSTAmtDec,
  i.RIGST,
  C.IGSTAmt,
  C.RcmIGST,
  c1.NonDedIGST,
  c1.NonDedRcmIGST,
  C.CGSTAmt,
  C.RcmCGST,
  c1.NonDedCGST,
  c1.NonDedRcmCGST,
  C.SGSTAmt,
  C.RcmSGST,
  C.UGSTAmt,
  C.RcmUGST,
  c1.NonDedSGST,
  c1.NonDedRcmSGST,
  //  InvoiceVal1,
  //  a.InvoiceVal,
  b.NDGst,
  //  a.HsnSacCode,
  a.ProfitCenter,
  a.ProfitCenterDesp,
  //  a.HsnNature,
  a.GstinStatus,
  //  a.Qty,
  //  a.Uom,
  a.ParkBy,
  a.PostBy,
  a.Pan,
  a.BusinessPlace,
  a.MsmeStatus,
  a.clearind,
  a.InvRefNumber,
  m.ProjectElement,
  h.CostElement,
  h.GLAccountName,
  j.AccountingDocumentType,
  j.sGSTAmtDec,
  j.SGST,
  L.cGSTAmtDec,
  L.AccountingDocumentType,
  t.AccountingDocumentType,
  t.uGSTAmtDec,
  t.uGST,
  u.AmountInTransactionCurrency,
  a.AbsoluteExchangeRate,
  a.TransactionCurrency
