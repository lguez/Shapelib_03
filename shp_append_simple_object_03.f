module shp_append_simple_object_03_m

  implicit none

contains

  subroutine shp_append_simple_object_03(ishape, hshp, nshptype, padf)

    use, INTRINSIC:: iso_c_binding
    use shapelib, only: shpfileobject, shpobject, shpcreatesimpleobject, &
         shpisnull, shpwriteobject, shpdestroyobject

    integer, intent(out):: ishape
    ! entity number of the appended shape, starting from 0
    
    TYPE(shpfileobject), intent(inout):: hshp
    INTEGER, intent(in):: nshptype ! type of shape, one of the shpt_* constants

    REAL, intent(in):: padf(:, :) ! (2 or 3, nvertices)
    ! x, y and possibly z coordinates. Last vertex should repeat first vertex.

    ! Local:
    TYPE(shpobject) psobject

    !-----------------------------------------------------------------

    if (size(padf, 1) == 3) then
       psobject = shpcreatesimpleobject(nshptype, nvertices = size(padf, 2), &
            padfx = real(padf(1, :), kind = c_double), &
            padfy = real(padf(2, :), kind = c_double), &
            padfz = real(padf(3, :), kind = c_double))
    else
       psobject = shpcreatesimpleobject(nshptype, nvertices = size(padf, 2), &
            padfx = real(padf(1, :), kind = c_double), &
            padfy = real(padf(2, :), kind = c_double))
    end if

    if (shpisnull(psobject)) then
       print *, "shp_append_simple_object_03: error creating the object"
       print *, "nshptype = ", nshptype
       stop 1
    end if

    ishape = shpwriteobject(hshp, - 1, psobject)

    if (ishape == - 1) then
       print *, "shp_append_simple_object_03: error writing the object"
       print *, "nshptype = ", nshptype
       stop 1
    end if
    
    CALL shpdestroyobject(psobject)

  end subroutine shp_append_simple_object_03

end module shp_append_simple_object_03_m
