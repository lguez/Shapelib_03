module dbf_add_field_03_m

  implicit none

contains

  subroutine dbf_add_field_03(ifield, hshp, pszfieldname, etype, nwidth, &
       ndecimals)

    use shapelib, only: shpfileobject, ftdouble, dbfaddfield

    INTEGER, intent(out):: ifield ! of the new field, starting from 0

    TYPE(shpfileobject), value:: hshp
    ! shapefile object to update

    CHARACTER(len=*), INTENT(in):: pszfieldname
    ! Name of the new field, at most 10 characters. The DBF API says
    ! "at most 11 character will be used", but it seems this includes
    ! the null character at the end.

    INTEGER, INTENT(in):: etype
    ! type of the new field, one of the ft* constants

    INTEGER, INTENT(in):: nwidth
    ! width of the field to be created in characters

    INTEGER, INTENT(in):: ndecimals
    ! number of decimals in a floating point representation for fields
    ! of type ftdouble, for the other types it should be 0

    !-----------------------------------------------------------------

    if (len(pszfieldname) > 10 .or. (etype /= ftdouble .and. ndecimals /= 0)) &
         call print_stop
    ifield = dbfaddfield(hshp, pszfieldname, etype, nwidth, ndecimals)
    if (ifield == - 1) call print_stop

  contains

    subroutine print_stop

      print *, "dbf_add_field_03: error"
      print *, "pszfieldname = ", pszfieldname
      print *, "etype = ", etype
      print *, "nwidth = ", nwidth
      print *, "ndecimals = ", ndecimals
      stop 1

    end subroutine print_stop

  end subroutine dbf_add_field_03

end module dbf_add_field_03_m
