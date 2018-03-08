module shp_append_null_03_m

  implicit none

contains

  subroutine shp_append_null_03(ishape, hshp)

    use, INTRINSIC:: iso_c_binding
    use shapelib, only: shpfileobject, shpobject, shpcreatesimpleobject, &
         shpisnull, shpwriteobject, shpdestroyobject, shpt_null

    integer, intent(out):: ishape
    ! entity number of the appended shape, starting from 0
    
    TYPE(shpfileobject), intent(inout):: hshp

    ! Local:
    REAL(kind = c_double) padf(0)
    TYPE(shpobject) psobject

    !-----------------------------------------------------------------

    psobject = shpcreatesimpleobject(shpt_null, 0, padf, padf)

    if (shpisnull(psobject)) then
       print *, "shp_append_null_03: error creating the object"
       stop 1
    end if

    ishape = shpwriteobject(hshp, - 1, psobject)

    if (ishape == - 1) then
       print *, "shp_append_null_03: error writing the object"
       stop 1
    end if
    
    CALL shpdestroyobject(psobject)

  end subroutine shp_append_null_03

end module shp_append_null_03_m
