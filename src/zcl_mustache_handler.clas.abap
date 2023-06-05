class ZCL_MUSTACHE_HANDLER definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MUSTACHE_HANDLER IMPLEMENTATION.


  METHOD if_http_extension~handle_request.
    zcl_mustache_dev_challenge=>get_challenge_response(
      IMPORTING
        ev_response = DATA(lv_resp)
    ).

    server->response->set_cdata( lv_resp ).
    server->response->set_status( code = 200 reason = 'success' ).
  ENDMETHOD.
ENDCLASS.
