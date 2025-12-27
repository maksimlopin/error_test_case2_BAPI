class ZNC_CL_FLIGHT_BOOKING_01_IN definition
  public
  create public .

public section.

  interfaces ZNC_II_FLIGHT_BOOKING_01_IN .
protected section.
private section.
ENDCLASS.



CLASS ZNC_CL_FLIGHT_BOOKING_01_IN IMPLEMENTATION.


  METHOD znc_ii_flight_booking_01_in~post_bookings_01.

    DATA: lv_bookkey  TYPE bapisbokey,
          lv_bookdata TYPE bapisbonew,
          lt_bapiret  TYPE TABLE OF bapiret2.

*Convert inputdata
    lv_bookdata = VALUE #( airlineid  = input-flight_booking_order_request-flight_id-airline_id
                           connectid  = input-flight_booking_order_request-flight_id-connection_id
                           flightdate = input-flight_booking_order_request-flight_id-flight_date
                           customerid = '1'
                           class      = input-flight_booking_order_request-class_code
                           agencynum  = input-flight_booking_order_request-agency_data-agency_id
                           passname   = input-flight_booking_order_request-passenger_name
                           passform   = input-flight_booking_order_request-passenger_form_of_address
                           passbirth  = input-flight_booking_order_request-passenger_birthdate ).

* Call internal flight booking function
    CALL FUNCTION 'BAPI_FLBOOKING_CREATEFROMDATA'
      EXPORTING
        reserve_only  = ' '
        booking_data  = lv_bookdata
      IMPORTING
        airlineid     = lv_bookkey-airlineid
        bookingnumber = lv_bookkey-bookingid
      TABLES
        return        = lt_bapiret.

  ENDMETHOD.
ENDCLASS.
