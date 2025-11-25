@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REP1 
 as select from    I_OperationalAcctgDocItem    as a
    left outer join zsd_so_book_tb               as b on a.Customer = b.sold_p
    left outer join I_Customer                   as c on a.Customer = c.Customer
    left outer join I_RegionText                 as d on  c.Country = d.Country
                                                      and c.Region  = d.Region
                                                      and d.Language = 'E'  
    left outer join ZFI_GSTR1_SUPP_ATTR_REV      as e on  a.CompanyCode        = e.CompanyCode
                                                      and a.AccountingDocument = e.AccountingDocument
                                                      and a.FiscalYear         = e.FiscalYear
    left outer join ZFI_GSTR1_PO_DETS            as f on  a.AccountingDocument = f.AccountingDocument
                                                      and a.FiscalYear         = f.FiscalYear
                                                      and a.CompanyCode        = f.CompanyCode
    left outer join ZFI_GSTR2_PRCTR_DET          as g on  a.AccountingDocument = g.AccountingDocument
                                                      and a.FiscalYear         = g.FiscalYear
                                                      and a.CompanyCode        = g.CompanyCode
    left outer join I_GLAccountTextRawData       as h on  a.GLAccount = h.GLAccount
                                                      and h.Language  = 'E'
    left outer join ZFI_GSTR1_TAXABLE_AMT        as i on  a.AccountingDocument = i.AccountingDocument
                                                      and a.FiscalYear         = i.FiscalYear
                                                      and a.CompanyCode        = i.CompanyCode
    left outer join ZFI_GSTR2_COMP_GSTIN         as j on  a.AccountingDocument = j.AccountingDocument
                                                      and a.FiscalYear         = j.FiscalYear
                                                      and a.CompanyCode        = j.CompanyCode
    left outer join I_JournalEntry               as k on  a.AccountingDocument = k.AccountingDocument
                                                      and a.FiscalYear         = k.FiscalYear
                                                      and a.CompanyCode        = k.CompanyCode

    left outer join ZFI_GSTR2_IRN                as o on  a.AccountingDocument = o.AccountingDocument
                                                      and a.FiscalYear         = o.FiscalYear
                                                      and a.CompanyCode        = o.CompanyCode
    left outer join ZFI_GSTR2_HSN_SAC            as n on  a.AccountingDocument = n.AccountingDocument
                                                      and a.FiscalYear         = n.FiscalYear
                                                      and a.CompanyCode        = n.CompanyCode
    left outer join I_AccountingDocumentTypeText as l on a.AccountingDocumentType = l.AccountingDocumentType
                                                      and l.Language = 'E'          
    left outer join I_CompanyCode                as m on a.CompanyCode = m.CompanyCode
    left outer join I_JournalEntry               as p on  a.AccountingDocument = p.AccountingDocument
                                                      and a.FiscalYear         = p.FiscalYear
                                                      and a.CompanyCode        = p.CompanyCode
   left outer join I_BuPaIdentification as q on c.Customer = q.BusinessPartner
                                                and q.BPIdentificationType = 'PAN'                                                   

{

  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,
  key h.GLAccount,
      a.Customer,
      
      h.GLAccountName,
      c.CustomerName,
      a.BusinessPlace,
      a.AccountingDocumentType      as DocumentType,
      j.CompGSTIN,
      l.AccountingDocumentTypeName  as DocTypeDesc,
      a.DocumentDate                as DocumentDate,
      a.PostingDate                 as PostingDate,
      d.RegionName                  as PlaceOfSupply,
      e.SuppAttRevChrge,
      c.TaxNumber3                  as CustGstin,
      ''                            as TaxCode,
      ''                            as TaxCodeDesp,
      a.CompanyCodeCurrency,
      f.PurchasingDocument          as PoDocument,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      i.TaxableAmt                  as ItemTaxAmt,
      ''                            as IgstRate,
      ''                            as CgstRate,
      ''                            as SgstRate,
      n.IN_HSNOrSACCode             as HsnSacCode,
      g.ProfitCenter,
      g.ProfitCenterName            as ProfitCenterDesp,
      n.HSNNature                   as HsnNature,
      case
      when c.TaxNumber3 is not initial
      then 'Registered'
      else 'Non Registered'
      end                           as GstinStatus,
      j.CompGSTIN                   as OurGSTIN,
      b.cust_b_date                 as BookingDate,
      b.area                        as CarpetArea,
      b.mat                         as UnitNo,
      f.BaseUnit                    as Uom,
      f.PurchasingDocumentPriceUnit,
      @Semantics.quantity.unitOfMeasure: 'PurchasingDocumentPriceUnit'
      f.PurchaseOrderQty            as Qty,
      k.ParkedByUser                as ParkBy,
      k.AccountingDocCreatedByUser  as PostBy,
      o.IN_InvoiceReferenceNumber   as IRN,
//      a.DocumentDate                as IRNDate,
      k.DocumentReferenceID         as InvRefNumber,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      a.AmountInTransactionCurrency as InvoiceAmt,
      p.Reference1InDocumentHeader  as CSreference,
      a.DocumentItemText            as MilestoneDescp,
      m.CompanyCodeName,
      q.BPIdentificationNumber as Pan
}
where
       a.FinancialAccountType   = 'D'
  and(
       a.AccountingDocumentType = 'DR'
    or a.AccountingDocumentType = 'CD'
    or a.AccountingDocumentType = 'RV'
    or a.AccountingDocumentType = 'DG'
  )
group by
  a.CompanyCode,
  a.FiscalYear,
  a.AccountingDocument,
  a.Customer,
  h.GLAccount,
  h.GLAccountName,
  c.CustomerName,
  a.BusinessPlace,
  a.AccountingDocumentType,
  j.CompGSTIN,
  a.DocumentDate,
  a.PostingDate,
  d.RegionName,
  e.SuppAttRevChrge,
  c.TaxNumber3,
  a.CompanyCodeCurrency,
  f.PurchasingDocument,
  i.TaxableAmt,
  n.IN_HSNOrSACCode,
  g.ProfitCenter,
  g.ProfitCenterName,
  n.HSNNature,
  c.TaxNumber3,
  j.CompGSTIN,
  b.cust_b_date,
  b.area,
  b.mat,
  f.BaseUnit,
  f.PurchasingDocumentPriceUnit,
  f.PurchaseOrderQty,
  k.ParkedByUser,
  k.AccountingDocCreatedByUser,
  o.IN_InvoiceReferenceNumber,
  a.DocumentDate,
  k.DocumentReferenceID,
  l.AccountingDocumentTypeName,
  a.AmountInTransactionCurrency,
  a.DocumentItemText,
  m.CompanyCodeName,
  p.Reference1InDocumentHeader,
  q.BPIdentificationNumber
