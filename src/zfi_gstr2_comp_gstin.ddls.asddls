@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Company GSTIN'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_COMP_GSTIN 
  as select from I_OperationalAcctgDocItem as a
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key BusinessPlace,
      case CompanyCode
//      when '1100' then '06ABNCS8610B1ZF'
//      when '1200' then '27AAJCN7374A1ZD'
//      when '1300' then '27ABNCS8537R1Z4'
      when 'MPPL' then ( case BusinessPlace
                            when 'MUD1' then '26AAOCM3634M1ZZ'
                            when 'MUD2' then '26AAOCM3634M1ZZ'
                            when 'MUD3' then '26AAOCM3634M1ZZ'
                            when 'MUD4' then '26AAOCM3634M1ZZ'
                            when 'MUV1' then '24AAOCM3634M2Z2'
                            when 'MUV2' then '24AAOCM3634M2Z2'
                            when 'MDAM' then '24AAOCM3634M1Z3'
                            when 'MDHR' then '05AAOCM3634M1Z3'
                            when 'MDHY' then '36AAOCM3634M1ZY'
                            when 'MDKN' then '09AAOCM3634M1ZV'
                            when 'MDKL' then '19AAOCM3634M1ZU'
                             end )


//      when '1000' then ( case BusinessPlace
//
//                            when '1009' then '09AAACD8005H1ZU'
//                            when '1010' then '10AAACD8005H1ZB'
//                            when '1008' then '08AAACD8005H1ZW'
//                            when '1006' then '06AAACD8005H1Z0'
//                            when '1022' then '22AAACD8005H1Z6'
//                            when '1027' then '27AAACD8005H1ZW'
//                            when '1005' then '05AAACD8005H2Z1'
//                            when '1023' then '23AAACD8005H1Z4'
//                         end )
//
//       when '3000' then ( case BusinessPlace
//                          when '3009' then '09AAFCD2604R2ZA'
//                          when '3027' then '27AAFCD2604R1ZD'
//                            end )
//
//       when '4000' then ( case BusinessPlace
//                            when '4009' then '09AABCD2003N1ZU'
//                            when '4010' then '10AABCD2003N2ZA'
//                            when '4027' then '27AABCD2003N2ZV' end )


           end as CompGSTIN

}
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  BusinessPlace
