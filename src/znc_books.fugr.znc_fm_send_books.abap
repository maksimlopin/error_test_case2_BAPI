FUNCTION ZNC_FM_SEND_BOOKS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_BOOK_ID) TYPE  ZNC_RT_BOOK_ID OPTIONAL
*"     VALUE(IT_TYPE_ID) TYPE  ZNC_RT_TYPE_ID OPTIONAL
*"     VALUE(IT_RLS_DATE) TYPE  ZNC_RT_RLS_DATE OPTIONAL
*"     VALUE(IT_STATUS) TYPE  ZNC_RT_STATUS OPTIONAL
*"  EXPORTING
*"     VALUE(ET_BOOKS) TYPE  ZNC_T_BOOK
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
  DATA: lt_books TYPE znc_t_book.

  CLEAR et_books.

  IF lt_books IS NOT INITIAL.

    CLEAR lt_books.

  ENDIF.

  SELECT * FROM znc_book
    WHERE ( id     IN @it_book_id
      AND type     IN @it_type_id
      AND rls_date IN @it_rls_date
      AND status   IN @it_status )
    INTO CORRESPONDING FIELDS OF TABLE @lt_books.

  IF sy-subrc <> 0.
    RAISE not_found.
    RETURN.
  ENDIF.

  et_books = lt_books.

ENDFUNCTION.
