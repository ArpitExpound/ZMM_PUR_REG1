CLASS zcl_purchase_register1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PURCHASE_REGISTER1 IMPLEMENTATION.


 METHOD if_rap_query_provider~select.
*     IF io_request->is_data_requested( ).
         DATA: lt_response TYPE TABLE OF ZCE_PUR_REG1,
            ls_response TYPE ZCE_PUR_REG1.
      DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
      DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
      DATA(lt_fields)        = io_request->get_requested_elements( ).
      DATA(lt_sort)          = io_request->get_sort_elements( ).

      IF lv_top < 0.
        lv_top = 1.
      ENDIF.

      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
      ENDTRY.

      DATA(lr_fkdat)   =  VALUE #( lt_filter_cond[ name   = 'FKDAT' ]-range OPTIONAL ).
      DATA(lr_bukrs)   =  VALUE #( lt_filter_cond[ name   = 'BUKRS' ]-range OPTIONAL ).
      DATA(lr_werks)   =  VALUE #( lt_filter_cond[ name   = 'WERKS' ]-range OPTIONAL ).
      DATA(lr_fkart)   =  VALUE #( lt_filter_cond[ name   = 'FKART' ]-range OPTIONAL ).
      DATA(lr_lifnr)   =  VALUE #( lt_filter_cond[ name   = 'SUPPLIER' ]-range OPTIONAL ).
      DATA(lr_ebeln)   =  VALUE #( lt_filter_cond[ name   = 'PURCHASEORDER' ]-range OPTIONAL ).

            SELECT FROM I_PurchaseOrderAPI01 AS a
             JOIN I_PurchaseOrderItemAPI01 AS b
             ON ( a~PurchaseOrder = b~PurchaseOrder )
      FIELDS a~PurchaseOrder,
             b~PurchaseOrderItem
       WHERE a~PurchaseOrderDate IN @lr_fkdat
       AND   a~companycode IN @lr_bukrs
       AND   a~PurchaseOrderType IN @lr_fkart
       AND   a~SUPPLIER IN @lr_lifnr
       AND   a~PurchaseOrder IN @lr_ebeln
       AND   b~plant IN @lr_werks
       INTO TABLE @DATA(lt_data).

       SELECT FROM I_PurchaseOrderAPI01 AS a
             JOIN I_PurchaseOrderItemAPI01 AS b
             ON ( a~PurchaseOrder = b~PurchaseOrder )
             JOIN i_supplier as c
             on ( a~Supplier = c~Supplier  )
        FIELDS a~PurchaseOrder,
             b~PurchaseOrderItem,
             a~PurchaseOrderDate,
             a~companycode,
             a~Supplier,
             b~Plant,
             b~Material,
             b~PurchaseOrderQuantityUnit,
             b~OrderQuantity,
             b~NetPriceAmount,
             b~DocumentCurrency,
             c~SupplierName
       WHERE a~PurchaseOrderDate IN @lr_fkdat
       AND   a~companycode IN @lr_bukrs
       AND   a~PurchaseOrderType IN @lr_fkart
       AND   a~SUPPLIER IN @lr_lifnr
       AND   a~PurchaseOrder IN @lr_ebeln
       AND   b~plant IN @lr_werks
       ORDER BY a~PurchaseOrder, b~PurchaseOrderItem
       INTO TABLE @DATA(lt_inv)
       UP TO @lv_top ROWS OFFSET @lv_skip.

       LOOP AT lt_inv INTO DATA(ls_inv).
*        ls_response-PurchaseOrder = ls_inv-PurchaseOrder.
*        ls_response-PurchaseOrderItem = ls_inv-PurchaseOrderItem.
*        ls_response-PurchaseOrderDate = ls_inv-PurchaseOrderDate.
*        ls_response-Supplier = ls_inv-Supplier.
*        ls_response-SupplierName = ls_inv-SupplierName.
*        ls_response-CompanyCode = ls_inv-CompanyCode.
*        ls_response-Material = ls_inv-Material.
*        ls_response-NetOrderAmount = ls_inv-NetPriceAmount.
*        ls_response-OrderCurrency = ls_inv-DocumentCurrency.
*        ls_response-OrderQuantity  = ls_inv-OrderQuantity.
*        ls_response-UoM = ls_inv-PurchaseOrderQuantityUnit.
*        ls_response-Plant = ls_inv-Plant.
        APPEND ls_response TO lt_response.
        CLEAR ls_response.
       ENDLOOP.

       io_response->set_total_number_of_records( lines( lt_data ) ).
       io_response->set_data( lt_response ).

*    ENDIF.
    ENDMETHOD.
ENDCLASS.
