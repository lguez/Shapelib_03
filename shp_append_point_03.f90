module shp_append_point_03_m

  implicit none

contains

  subroutine shp_append_point_03(ishape, hshp, padf)

    use, INTRINSIC:: iso_c_binding
    use shapelib, only: shpfileobject, shpobject, shpcreatesimpleobject, &
         shpisnull, shpwriteobject, shpdestroyobject, shpt_pointz, shpt_point

    integer, intent(out):: ishape
    ! entity number of the appended shape, starting from 0
    
    TYPE(shpfileobject), value:: hshp
    ! value attribute to circumvent a bug in FortranGIS: dummy
    ! argument hshp of shpwriteobject should be intent(in)

    REAL, intent(in):: padf(:)
    ! (2 or 3) x, y and possibly z coordinates

    ! Local:
    TYPE(shpobject) psobject

    !-----------------------------------------------------------------

    if (size(padf) == 3) then
       psobject = shpcreatesimpleobject(shpt_pointz, 1, &
            [real(padf(1), kind = c_double)], &
            [real(padf(2), kind = c_double)], &
            [real(padf(3), kind = c_double)])
    else
       psobject = shpcreatesimpleobject(shpt_point, 1, &
            [real(padf(1), kind = c_double)], &
            [real(padf(2), kind = c_double)])
    end if

    if (shpisnull(psobject)) then
       print *, "shp_append_point_03: error creating the object"
       print *, "padf = ", padf
       stop 1
    end if

    ishape = shpwriteobject(hshp, - 1, psobject)

    if (ishape == - 1) then
       print *, "shp_append_point_03: error writing the object"
       print *, "padf = ", padf
       stop 1
    end if
    
    CALL shpdestroyobject(psobject)

  end subroutine shp_append_point_03

end module shp_append_point_03_m
