@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'gstr2 report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_REP1
  as select distinct from I_OperationalAcctgDocItem  as a
    left outer join       I_Supplier                 as b on a.Supplier = b.Supplier
    left outer join       I_BusPartAddrDepdntTaxNmbr as c on a.Supplier = c.BusinessPartner
    left outer join       I_RegionText               as d on  b.Country  = d.Country
                                                          and b.Region   = d.Region
                                                          and d.Language = 'E'
    left outer join       I_JournalEntry             as e on  a.AccountingDocument = e.AccountingDocument
                                                          and a.FiscalYear         = e.FiscalYear
                                                          and a.CompanyCode        = e.CompanyCode
    left outer join       ZFI_GSTR2_PO_DETS          as f on  a.AccountingDocument = f.AccountingDocument
                                                          and a.FiscalYear         = f.FiscalYear
                                                          and a.CompanyCode        = f.CompanyCode
    left outer join       ZFI_GSTR2_PRCTR_DET        as g on  a.AccountingDocument = g.AccountingDocument
                                                          and a.FiscalYear         = g.FiscalYear
                                                          and a.CompanyCode        = g.CompanyCode
  //    left outer join ZFI_GSTR2_EXP_GL           as h on  a.AccountingDocument = h.AccountingDocument
  //                                                    and a.FiscalYear         = h.FiscalYear
  //                                                    and a.CompanyCode        = h.CompanyCode


    left outer join       I_OperationalAcctgDocItem  as z on  a.AccountingDocument = z.AccountingDocument //////// add by sandeep  start
                                                          and a.FiscalYear         = z.FiscalYear
                                                          and a.CompanyCode        = z.CompanyCode
    left outer join       ZFI_GSTR2_TAXAMT_F         as i on  z.AccountingDocument =  i.AccountingDocument
                                                          and z.FiscalYear         =  i.FiscalYear
                                                          and z.CompanyCode        =  i.CompanyCode
                                                          and z.TaxCompanyCode     <> '**' ////////end


  //    left outer join ZFI_GSTR2_TAXAMT_F         as i on  a.AccountingDocument = i.AccountingDocument
  //                                                    and a.FiscalYear         = i.FiscalYear
  //                                                    and a.CompanyCode        = i.CompanyCode
    left outer join       ZFI_GSTR2_COMP_GSTIN       as j on  a.AccountingDocument = j.AccountingDocument
                                                          and a.FiscalYear         = j.FiscalYear
                                                          and a.CompanyCode        = j.CompanyCode

    left outer join       ZFI_GSTR2_MSME_VEND1       as l on  a.AccountingDocument = l.AccountingDocument
                                                          and a.FiscalYear         = l.FiscalYear
                                                          and a.CompanyCode        = l.CompanyCode
    left outer join       ZFI_GSTR2_CLEARING_STATUS  as m on  a.AccountingDocument = m.AccountingDocument
                                                          and a.FiscalYear         = m.FiscalYear
                                                          and a.CompanyCode        = m.CompanyCode
  //    left outer join ZFI_GSTR2_HSN_SAC          as n on  a.AccountingDocument = n.AccountingDocument
  //                                                    and a.FiscalYear         = n.FiscalYear
  //                                                    and a.CompanyCode        = n.CompanyCode
    left outer join       ZFI_GSTR2_IRN              as o on  a.AccountingDocument = o.AccountingDocument
                                                          and a.FiscalYear         = o.FiscalYear
                                                          and a.CompanyCode        = o.CompanyCode
    left outer join       ZFI_GSTR2_WBS              as p on  a.AccountingDocument = p.AccountingDocument
                                                          and a.FiscalYear         = p.FiscalYear
                                                          and a.CompanyCode        = p.CompanyCode
//    left outer join       I_OperationalAcctgDocItem  as q on  q.AccountingDocument = a.AccountingDocument
//                                                          and a.FiscalYear         = z.FiscalYear
//                                                          and a.CompanyCode        = z.CompanyCode
//                                                          and q.TaxCode = 'C0'  
//                                                          and 
    left outer join       ZFI_GSTR2_TAX_AMT_ISA        as Q on  a.CompanyCode        = Q.CompanyCode
                                                            and a.AccountingDocument = Q.AccountingDocument
                                                            and a.FiscalYear         = Q.FiscalYear
                                                          


{
  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,
//  key a.AccountingDocumentItem,
  key g.ProfitCenter,
  key a.Supplier,
      //  key a.AccountingDocumentItem,
      j.CompGSTIN                             as CustGstin,
      //      h.CostElement                as ExpGLAcct,
      //      h.GLAccountName              as ExpGLDesp,
      a.AccountingDocumentType                as DocumentType,
      a.DocumentDate                          as DocumentDate,
      a.PostingDate                           as PostingDate,
      
      ''                                      as TaxCode,
      ''                                      as TaxCodeDesp,
      a.CompanyCodeCurrency,
      b.SupplierFullName,
      b.BPSupplierFullName,
      //      SupplierFullName,
      b.CityName,
      b.Region,
      d.RegionName,
      d.RegionName                            as PlaceOfSupply,
      b.TaxNumber3                            as SupplierGSTIN,
      e.DocumentReferenceID                   as InvoiceRefNum,
      f.PurchasingDocument                    as PoDocument,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //      i.TaxableAmt                 as ItemTaxAmt,
      cast( i.TaxableAmt  as abap.dec(13,2) ) as ItemTaxAmt,
//      i.TaxCode                               as taxcode1, ///////add by sandeepSV
      ''                                      as IgstRate,
      ''                                      as CgstRate,
      ''                                      as SgstRate,
      ''                                      as RcmIgstRate,
      ''                                      as RcmCgstRate,
      ''                                      as RcmSgstRate,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case when a.DebitCreditCode = 'H'
            then -1 * a.CashDiscountBaseAmount
          when a.DebitCreditCode = 'S'
            then -1 * a.CashDiscountBaseAmount
          else   a.CashDiscountBaseAmount
      end                                     as InvoiceVal,


      //      n.IN_HSNOrSACCode            as HsnSacCode,
      //      g.ProfitCenter,
      g.ProfitCenterName                      as ProfitCenterDesp,
      //      n.HSNNature                  as HsnNature,
      case
      when b.TaxNumber3 is not initial
      then 'Registered'
      else 'Non Registered'
      end                                     as GstinStatus,
      //      f.BaseUnit                   as Uom,
      //      f.PurchasingDocumentPriceUnit,
      //      @Semantics.quantity.unitOfMeasure: 'PurchasingDocumentPriceUnit'
      //      f.PurchaseOrderQty           as Qty,
      e.ParkedByUser                          as ParkBy,
      e.AccountingDocCreatedByUser            as PostBy,
      b.BusinessPartnerPanNumber              as Pan,
      a.BusinessPlace,
      l.MsmeStatus,
      m.clearind,
      o.IN_InvoiceReferenceNumber             as InvRefNumber,
      p.WBSElementInternalID,
      Q.IGSTAmtDec,
      Q.RIGST,
      e.AbsoluteExchangeRate,
      a.TransactionCurrency
}
where
(
      ( a.AccountingDocumentType = 'RE' or a.AccountingDocumentType = 'KR' or a.AccountingDocumentType = 'KG' ) 
   or ( a.AccountingDocumentType = 'KA' and a.FinancialAccountType = 'K' )
   or ( a.AccountingDocumentType = 'SA' and a.IsAutomaticallyCreated <> 'X' )
   or ( a.AccountingDocumentType = 'SJ' )
)
//  where
//(
//      ( a.AccountingDocumentType = 'RE' or a.AccountingDocumentType = 'KR' or a.AccountingDocumentType = 'KG'
//        or a.AccountingDocumentType = 'KA'  and a.FinancialAccountType = 'K' )
//   or ( a.AccountingDocumentType = 'SA' or a.IsAutomaticallyCreated <> 'X' ) or ( a.AccountingDocumentType = 'SJ' )
////   and ( a.AccountingDocumentType = 'SJ' )
//)
and a.TaxCode <> ''
and e.IsReversed <> 'X'
and e.IsReversal <> 'X'
  
//  (
//          -- For SJ → FinancialAccountType must be 'S'
//          (
//            a.AccountingDocumentType   =  'SJ'
//            and ( a.FinancialAccountType =  'S' or a.FinancialAccountType =  'K' )
//          )
//          
//     or (
//            a.AccountingDocumentType   =  'SA'
////            and ( a.GLAccount = '0000148000' or a.GLAccount = '0000148001' or a.GLAccount = '0000148002' or a.GLAccount = '0000148003' )
////            and a.IsAutomaticallyCreated <> 'X'
////            and a.FinancialAccountType =  'S'
//          )     
//
//    -- For other doc types → FinancialAccountType must be 'K'
//    or (
//          a.AccountingDocumentType     =  'RE'
//      or  a.AccountingDocumentType     =  'KR'
//      or  a.AccountingDocumentType     =  'KG'
//      or  a.AccountingDocumentType     =  'KA'
//      and   a.FinancialAccountType       =  'K'
//    )
////    and   a.FinancialAccountType       =  'K'
//  )
//
//  //where
//  //       ( a.FinancialAccountType   = 'K' or a.FinancialAccountType   = 'S' )
//  //
//  //  and(
//  //       a.AccountingDocumentType = 'RE'
//  //    or a.AccountingDocumentType = 'KR'
//  //    //    or a.AccountingDocumentType = 'RK'
//  //    or a.AccountingDocumentType = 'KG'
//  //    //    or a.AccountingDocumentType = 'GK'
//  //    or a.AccountingDocumentType = 'KA'
//  //    or a.AccountingDocumentType = 'SJ'
//  and     not(
//        a.AccountingDocumentType       =  'SJ'
//        and(
//              i.TaxCode                is null
//          or  i.TaxCode                =  ''
//        )
//      )
//
//  and     a.TaxCode                    <> ''
//  and     e.IsReversed                 <> 'X'
//  and     e.IsReversal                 <> 'X'
