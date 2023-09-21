module dbf_read_attribute_03_m

  use shapelib, only: dbfreadattribute, shpfileobject, dbfisattributenull

  implicit none

  interface dbf_read_attribute_03
     module procedure dbf_read_attribute_03_real, dbf_read_attribute_03_int
  end interface dbf_read_attribute_03

  ! Value attribute to circumvent a bug in FortranGIS: dummy
  ! argument hshp of dbfreadattribute should be intent(in).

  private
  public dbf_read_attribute_03

contains

  SUBROUTINE dbf_read_attribute_03_real(attr, hshp, ifield, ishape)

    use, INTRINSIC:: iso_c_binding

    REAL, INTENT(out):: attr
    TYPE(shpfileobject), value:: hshp
    INTEGER, INTENT(in):: ifield, ishape ! 0-based

    ! Local:
    real(c_double) attr_double

    !--------------------------------------------------------------------

    if (dbfisattributenull(hshp, ishape, ifield)) then
       print *, "dbf_read_attribute_03_real: cannot read attribute"
       print *, "ifield = ", ifield
       print *, "ishape = ", ishape
       stop 1
    else
       call dbfreadattribute(hshp, ishape, ifield, attr_double)
       attr = attr_double
    end if

  END SUBROUTINE dbf_read_attribute_03_real

  !**************************************************************************

  SUBROUTINE dbf_read_attribute_03_int(attr, hshp, ifield, ishape)

    use, INTRINSIC:: iso_c_binding

    integer, INTENT(out):: attr
    TYPE(shpfileobject), value:: hshp
    INTEGER, INTENT(in):: ifield, ishape

    !--------------------------------------------------------------------

    if (dbfisattributenull(hshp, ishape, ifield)) then
       print *, "dbf_read_attribute_03_real: cannot read attribute"
       print *, "ifield = ", ifield
       print *, "ishape = ", ishape
       stop 1
    else
       call dbfreadattribute(hshp, ishape, ifield, attr)
    end if

  END SUBROUTINE dbf_read_attribute_03_int

end module dbf_read_attribute_03_m
