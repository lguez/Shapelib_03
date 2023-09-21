module shp_read_object_03_m

  implicit none

contains

  subroutine shp_read_object_03(hshp, ishape, psobject)

    use, intrinsic:: iso_fortran_env, only: error_unit

    use shapelib, only: shpfileobject, shpobject, shpreadobject, shpisnull

    type(shpfileobject), value:: hshp
    ! Value attribute to circumvent a bug in FortranGIS: dummy
    ! argument hshp of shpreadobject should be intent(in).

    integer, intent(in):: ishape
    TYPE(shpobject), intent(out):: psobject

    !-------------------------------------------------------------------

    psobject = shpreadobject(hshp, ishape)

    if (shpisnull(psobject)) then
       write(error_unit, fmt = *) "shp_read_object_03: error"
       write(error_unit, fmt = *) "ishape = ", ishape
       stop 1
    end if

  end subroutine shp_read_object_03

end module shp_read_object_03_m
