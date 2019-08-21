module dbf_read_attribute_03_m

  use shapelib, only: dbfreadattribute, shpfileobject

  implicit none

  interface dbf_read_attribute_03
     module procedure dbf_read_attribute_03_real, dbf_read_attribute_03_int
  end interface dbf_read_attribute_03

  ! Value attribute to circumvent a bug in FortranGIS: dummy
  ! argument hshp of dbfreadattribute should be intent(in).

  private
  public dbf_read_attribute_03

contains

  SUBROUTINE dbf_read_attribute_03_real(hshp, ishape, ifield, attr)

    use, INTRINSIC:: iso_c_binding

    TYPE(shpfileobject), value:: hshp
    INTEGER, INTENT(in):: ishape, ifield
    REAL, INTENT(out):: attr

    ! Local:
    real(c_double) attr_double

    !--------------------------------------------------------------------

    call dbfreadattribute(hshp, ishape, ifield, attr_double)
    attr = attr_double

  END SUBROUTINE dbf_read_attribute_03_real

  !**************************************************************************

  SUBROUTINE dbf_read_attribute_03_int(hshp, ishape, ifield, attr)

    use, INTRINSIC:: iso_c_binding

    TYPE(shpfileobject), value:: hshp
    INTEGER, INTENT(in):: ishape, ifield
    integer, INTENT(out):: attr

    !--------------------------------------------------------------------

    call dbfreadattribute(hshp, ishape, ifield, attr)

  END SUBROUTINE dbf_read_attribute_03_int

end module dbf_read_attribute_03_m
