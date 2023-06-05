class ZCL_MUSTACHE_DEV_CHALLENGE definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ty_challenge,
           event_date TYPE string,
           event_text TYPE string,
           event_url  TYPE string,
         END OF ty_challenge .
  types:
    tt_challenges TYPE STANDARD TABLE OF ty_challenge .

  class-data GT_DATA type ZIF_MUSTACHE=>TY_STRUC_TT .
  class-data GT_CHALLENGES type TT_CHALLENGES .

  class-methods GET_CHALLENGE_RESPONSE
    exporting
      !EV_RESPONSE type STRING .
protected section.
private section.

  class-methods _SET_RENDERING_DATA .
ENDCLASS.



CLASS ZCL_MUSTACHE_DEV_CHALLENGE IMPLEMENTATION.


  METHOD get_challenge_response.

    DATA: lo_mustache   TYPE REF TO zcl_mustache.

    CONSTANTS: lc_nl TYPE abap_char1 VALUE cl_abap_char_utilities=>newline.

    _set_rendering_data( ).

    TRY.
        lo_mustache = zcl_mustache=>create(
          'SAP Developer Code Challenge - <b>{{challenge_descr}}</b>!' && lc_nl &&
          '<p></p>' && lc_nl &&
          '<b>The Tiemline:</b>' && lc_nl &&
          '<table>' && lc_nl &&
          ' {{#challenges}}' && lc_nl &&
          ' <tr><td>{{event_date}}</td><td>: <a href="{{event_url}}">{{event_text}}</a></td>' && lc_nl &&
          ' {{/challenges}}' && lc_nl &&
          '</table>' ).

        ev_response = lo_mustache->render( gt_data ).
      CATCH zcx_mustache_error INTO DATA(lo_error).
        ev_response = |<p>{ lo_error->get_text( ) }</p>|.
    ENDTRY.
  ENDMETHOD.


  METHOD _set_rendering_data.

    CLEAR gt_challenges.
    APPEND INITIAL LINE TO gt_challenges ASSIGNING FIELD-SYMBOL(<lfsc>).
    <lfsc>-event_date = 'May 10th, 2023'.
    <lfsc>-event_text = 'Start of Challenge: Week 1 Challenge'.
    <lfsc>-event_url = 'https://groups.community.sap.com/t5/application-development/sap-developer-code-challenge-open-source-abap-week-1/m-p/259306#M1284'.

    APPEND INITIAL LINE TO gt_challenges ASSIGNING <lfsc>.
    <lfsc>-event_date = 'May 17th, 2023'.
    <lfsc>-event_text = 'Week 2 Challenge'.
    <lfsc>-event_url = 'https://groups.community.sap.com/t5/application-development/sap-developer-code-challenge-open-source-abap-week-2/m-p/260727#M1372'.

    APPEND INITIAL LINE TO gt_challenges ASSIGNING <lfsc>.
    <lfsc>-event_date = 'May 24th, 2023'.
    <lfsc>-event_text = 'Week 3 Challenge'.
    <lfsc>-event_url = 'https://groups.community.sap.com/t5/application-development/sap-developer-code-challenge-ooen-source-week-3/m-p/262136#M1479'.

    APPEND INITIAL LINE TO gt_challenges ASSIGNING <lfsc>.
    <lfsc>-event_date = 'May 31st, 2023'.
    <lfsc>-event_text = 'Week 4 Challenge'.
    <lfsc>-event_url = 'https://groups.community.sap.com/t5/application-development/sap-developer-code-challenge-open-source-abap-week-4/td-p/263470'.

    APPEND INITIAL LINE TO gt_challenges ASSIGNING <lfsc>.
    <lfsc>-event_date = 'June 7th, 2023'.
    <lfsc>-event_text = 'End of Challenge'.
    <lfsc>-event_url = ''.

    CLEAR gt_data.
    APPEND INITIAL LINE TO gt_data ASSIGNING FIELD-SYMBOL(<lfs_data>).
    <lfs_data>-name = 'challenge_descr'.
    <lfs_data>-val = 'Open Sourrce ABAP!'.

    APPEND INITIAL LINE TO gt_data ASSIGNING <lfs_data>.
    <lfs_data>-name = 'challenges'.
    GET REFERENCE OF gt_challenges INTO <lfs_data>-dref.
  ENDMETHOD.
ENDCLASS.
