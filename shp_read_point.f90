module shp_read_point_m

  implicit none

contains

  subroutine shp_read_point(point, hshp, ishape)

    use, intrinsic:: iso_fortran_env, only: error_unit
    
    use shapelib, only: shpfileobject, shpobject, shpreadobject, shpisnull, &
         shpdestroyobject

    real, intent(out):: point(:) ! (2)

    type(shpfileobject), value:: hshp
    ! Value attribute to circumvent a bug in FortranGIS: dummy
    ! argument hshp of shpreadobject should be intent(in).

    integer, intent(in):: ishape

    ! Local:
    TYPE(shpobject) psobject

    !-------------------------------------------------------------------

    psobject = shpreadobject(hshp, ishape)

    if (shpisnull(psobject)) then
       write(error_unit, fmt = *) "shp_read_point: error"
       write(error_unit, fmt = *) "ishape = ", ishape
       stop 1
    end if

    point = [psobject%padfx(1), psobject%padfy(1)]
    call shpdestroyobject(psobject)

  end subroutine shp_read_point

end module shp_read_point_m
