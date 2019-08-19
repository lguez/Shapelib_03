module dbf_write_attribute_03_m

  implicit none

  interface dbf_write_attribute_03
     module procedure dbf_write_attribute_03_int, dbf_write_attribute_03_real
  end interface dbf_write_attribute_03

contains

  subroutine dbf_write_attribute_03_real(hshp, ishape, ifield, fieldvalue)

    use, INTRINSIC:: iso_c_binding
    use shapelib, only: shpfileobject, dbfwriteattribute

    type(shpfileobject), value:: hshp
    ! Access handle for the shapefile to be written. Value attribute
    ! to circumvent a bug in FortranGIS: dummy argument hshp of
    ! shpwriteobject should be intent(in).

    integer, intent(in):: ishape
    ! record number (shape number) to which the field value should be written

    integer, intent(in):: ifield
    ! field within the selected record that should be written

    real, intent(in):: fieldvalue ! value that should be written

    ! Local:
    integer j ! 0 or 1

    !------------------------------------------------------------------

    j = dbfwriteattribute(hshp, ishape, ifield, &
         real(fieldvalue, kind = c_double))

    if (j /= 1) then
       print *, "dbf_write_attribute_03_real: error"
       print *, "ishape = ", ishape
       print *, "ifield = ", ifield
       print *, "fieldvalue = ", fieldvalue
       stop 1
    end if

  end subroutine dbf_write_attribute_03_real

  !************************************************************************

  subroutine dbf_write_attribute_03_int(hshp, ishape, ifield, fieldvalue)

    use, INTRINSIC:: iso_c_binding
    use shapelib, only: shpfileobject, dbfwriteattribute

    type(shpfileobject), value:: hshp
    ! Access handle for the shapefile to be written. Value attribute
    ! to circumvent a bug in FortranGIS: dummy argument hshp of
    ! shpwriteobject should be intent(in).

    integer, intent(in):: ishape
    ! record number (shape number) to which the field value should be written

    integer, intent(in):: ifield
    ! field within the selected record that should be written

    integer, intent(in):: fieldvalue ! value that should be written

    ! Local:
    integer j ! 0 or 1

    !------------------------------------------------------------------

    j = dbfwriteattribute(hshp, ishape, ifield, int(fieldvalue, kind = c_int))

    if (j /= 1) then
       print *, "dbf_write_attribute_03_int: error"
       print *, "ishape = ", ishape
       print *, "ifield = ", ifield
       print *, "fieldvalue = ", fieldvalue
       stop 1
    end if

  end subroutine dbf_write_attribute_03_int

end module dbf_write_attribute_03_m
