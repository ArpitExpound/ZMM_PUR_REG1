//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'TEST'
//@Metadata.ignorePropagatedAnnotations: true
//define root view entity ZFI_GSTR1_TEST as select from data_source_name
//composition of target_data_source_name as _association_name
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZFI_GSTR1_TEST 
    as select from ZFI_GSTR1_REP1    as a
    left outer join ZFI_GSTR1_TAX_AMT as c on  a.CompanyCode        = c.CompanyCode
                                           and a.AccountingDocument = c.AccountingDocument
                                           and a.FiscalYear         = c.FiscalYear
    left outer join ZR_FIT_TAX_PERC   as n on c.TaxCode = n.Taxcode
    left outer join I_TaxCodeText     as k on c.TaxCode = k.TaxCode
{
  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,

  a.GLAccount,
  a.GLAccountName,
  a.Customer,
  a.CustGstin,
  a.CustomerName,
  a.BusinessPlace,
  a.InvRefNumber,
  a.DocumentType,
  a.DocTypeDesc,
  a.DocumentDate,
  a.PostingDate,
  a.PlaceOfSupply,
  a.SuppAttRevChrge,
  c.TaxCode,

  case c.TaxCode
    when 'ZE' then 'GST Output Tax (CGST + UGST - 5%)'
    when 'ZF' then 'GST Output Tax (CGST + UGST - 12%)'
    when 'ZG' then 'GST Output Tax (CGST + UGST - 18%)'
    when 'ZH' then 'GST Output Tax (CGST + UGST - 28%)'
    else k.TaxCodeName
  end as TaxCodeName,

  /* ItemTaxAmt (cast CURR -> DEC before using COALESCE / arithmetic) */
  cast(
    case 
      when coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0 
        then coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1 
      else coalesce(cast(a.ItemTaxAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
    end
  as abap.dec(15,2)) as ItemTaxAmt,

  n.IgstRate,
  n.CgstRate,
  n.SgstRate,

  case c.TaxCode
    when 'ZE' then '2.5'
    when 'ZF' then '6.0'
    when 'ZG' then '9.0'
    when 'ZH' then '14.0'
  end as UgstRate,

  cast(
    case
      when coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
        then coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      else coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
    end
  as abap.dec(15,2)) as IGSTAmt,

  cast(
    case
      when coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
        then coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      else coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
    end
  as abap.dec(15,2)) as CGSTAmt,

  cast(
    case
      when coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
        then coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      else coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
    end
  as abap.dec(15,2)) as SGSTAmt,

  cast(
    case
      when coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
        then coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      else coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
    end
  as abap.dec(15,2)) as UGSTAmt,

  cast(
    case
      when coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0
        then coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1
      else coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
    end
  as abap.dec(15,2)) as InvoiceAmt,

//  /* InvoiceVal1: null-safe sum (all operands cast to DEC) */
//  cast(
////    coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
//  + coalesce(cast(c.IGSTAmt  as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
//  + coalesce(cast(c.CGSTAmt  as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
//  + coalesce(cast(c.SGSTAmt  as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
//  + coalesce(cast(c.UGSTAmt  as abap.dec(15,2)), cast(0 as abap.dec(15,2)))
//  as abap.dec(15,2)
//  ) as InvoiceVal1,
  
  cast(
//  (case when coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0 
//        then coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1 
//        else coalesce(cast(a.InvoiceAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
  (case when coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0 
        then coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1 
        else coalesce(cast(c.IGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
+ (case when coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0 
        then coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1 
        else coalesce(cast(c.CGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
+ (case when coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0 
        then coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1 
        else coalesce(cast(c.SGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
+ (case when coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) < 0 
        then coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) * -1 
        else coalesce(cast(c.UGSTAmt as abap.dec(15,2)), cast(0 as abap.dec(15,2))) end)
as abap.dec(15,2)
) as InvoiceVal1,
  
  a.HsnSacCode,
  a.ProfitCenter,
  a.ProfitCenterDesp,
  a.HsnNature,
  a.GstinStatus,
  a.OurGSTIN,
  a.BookingDate,
  a.CarpetArea,
  a.UnitNo,
  a.PurchasingDocumentPriceUnit,
  @Semantics.quantity.unitOfMeasure: 'PurchasingDocumentPriceUnit'
  a.Qty,
  a.Uom,
  a.IRN,
  a.ParkBy,
  a.PostBy,
  a.CompanyCodeCurrency,
  a.CompanyCodeName,
  a.CSreference,
  a.MilestoneDescp,
  a.Pan
}
group by
  a.CompanyCode,
  a.FiscalYear,
  a.AccountingDocument,
  a.GLAccount,
  a.GLAccountName,
  a.Customer,
  a.CustGstin,
  a.CustomerName,
  a.BusinessPlace,
  a.InvRefNumber,
  a.DocumentType,
  a.DocTypeDesc,
  a.DocumentDate,
  a.PostingDate,
  a.PlaceOfSupply,
  a.SuppAttRevChrge,
  c.TaxCode,
  k.TaxCodeName,
  a.ItemTaxAmt,
  n.IgstRate,
  n.CgstRate,
  n.SgstRate,
  c.IGSTAmt,
  c.CGSTAmt,
  c.SGSTAmt,
  a.InvoiceAmt,
  a.HsnSacCode,
  a.ProfitCenter,
  a.ProfitCenterDesp,
  a.HsnNature,
  a.GstinStatus,
  a.OurGSTIN,
  a.BookingDate,
  a.CarpetArea,
  a.UnitNo,
  a.PurchasingDocumentPriceUnit,
  a.Qty,
  a.Uom,
  a.IRN,
  a.Pan,
  a.ParkBy,
  a.PostBy,
  a.CompanyCodeCurrency,
  a.CompanyCodeName,
  c.UGSTAmt,
  a.CSreference,
  a.MilestoneDescp
