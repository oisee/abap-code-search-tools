"! <p class="shorttext synchronized" lang="en">Matcher for POSIX standard regular expressions</p>
CLASS zcl_adcoset_posix_regex_matchr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      zif_adcoset_pattern_matcher.

    METHODS:
      constructor
        IMPORTING
          pattern     TYPE string
          ignore_case TYPE abap_bool
        RAISING
          cx_sy_regex.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      regex       TYPE REF TO cl_abap_regex,
      pattern     TYPE string,
      ignore_case TYPE abap_bool.
ENDCLASS.



CLASS zcl_adcoset_posix_regex_matchr IMPLEMENTATION.


  METHOD constructor.
    me->pattern = pattern.
    me->ignore_case = ignore_case.
    regex = NEW #(
      pattern     = pattern
      ignore_case = ignore_case ).
  ENDMETHOD.


  METHOD zif_adcoset_pattern_matcher~find_matches.
    TRY.
        result = regex->create_matcher( table = source )->find_all( ).
      CATCH cx_sy_matcher ##NO_HANDLER.
        " should not happen. The regex exceptions will be handled in the constructor
    ENDTRY.
  ENDMETHOD.


ENDCLASS.
