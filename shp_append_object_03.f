module shp_append_object_03_m

  use, INTRINSIC:: iso_c_binding
  use shapelib, only: shpfileobject, shpobject, shpcreateobject, &
       shpcreatesimpleobject, shpisnull, shpwriteobject, shpdestroyobject

  implicit none

  interface shp_append_object_03
     module procedure shp_append_object_03_single, shp_append_object_03_c_double
     ! Not for MultiPatch shape type. No measure. The difference
     ! between the procedures is the kind of argument padf.
  end interface shp_append_object_03

  integer, parameter:: shpp_ring = 5

  private
  public shp_append_object_03

contains

  subroutine shp_append_object_03_single(ishape, hshp, nshptype, padf, &
       pan_part_start)

    integer, intent(out):: ishape
    ! entity number of the appended shape, starting from 0

    TYPE(shpfileobject), value:: hshp
    ! value attribute to circumvent a bug in FortranGIS: dummy
    ! argument hshp of shpwriteobject should be intent(in)

    INTEGER, intent(in):: nshptype ! type of shape, one of the shpt_* constants

    REAL, intent(in):: padf(:, :) ! (2 or 3, nvertices)
    ! x, y and possibly z coordinates for all the rings. For each
    ! ring, the last vertex must repeat the first vertex.

    integer, intent(in), optional:: pan_part_start(:) ! (nparts)
    ! The list of zero based start vertices for the rings (parts) in
    ! this object. The first should always be zero.

    ! Local:
    TYPE(shpobject) psobject
    integer nparts, i

    !-----------------------------------------------------------------

    if (present(pan_part_start)) then
       nparts = size(pan_part_start)

       if (size(padf, 1) == 3) then
          psobject = shpcreateobject(nshptype, ishape = - 1, nparts = nparts, &
               panpartstart = pan_part_start, &
               panparttype = [(shpp_ring, i = 1, nparts)], &
               nvertices = size(padf, 2), &
               padfx = real(padf(1, :), kind = c_double), &
               padfy = real(padf(2, :), kind = c_double), &
               padfz = real(padf(3, :), kind = c_double))
       else
          psobject = shpcreateobject(nshptype, ishape = - 1, nparts = nparts, &
               panpartstart = pan_part_start, &
               panparttype = [(shpp_ring, i = 1, nparts)], &
               nvertices = size(padf, 2), &
               padfx = real(padf(1, :), kind = c_double), &
               padfy = real(padf(2, :), kind = c_double))
       end if
    else
       if (size(padf, 1) == 3) then
          psobject = shpcreatesimpleobject(nshptype, &
               nvertices = size(padf, 2), &
               padfx = real(padf(1, :), kind = c_double), &
               padfy = real(padf(2, :), kind = c_double), &
               padfz = real(padf(3, :), kind = c_double))
       else
          psobject = shpcreatesimpleobject(nshptype, &
               nvertices = size(padf, 2), &
               padfx = real(padf(1, :), kind = c_double), &
               padfy = real(padf(2, :), kind = c_double))
       end if
    end if

    if (shpisnull(psobject)) then
       print *, "shp_append_object_03_single: error creating the object"
       print *, "nshptype = ", nshptype
       stop 1
    end if

    ishape = shpwriteobject(hshp, - 1, psobject)

    if (ishape == - 1) then
       print *, "shp_append_object_03_single: error writing the object"
       print *, "nshptype = ", nshptype
       stop 1
    end if

    CALL shpdestroyobject(psobject)

  end subroutine shp_append_object_03_single

  !************************************************************************

  subroutine shp_append_object_03_c_double(ishape, hshp, nshptype, padf, &
       pan_part_start)

    integer, intent(out):: ishape
    ! entity number of the appended shape, starting from 0

    TYPE(shpfileobject), value:: hshp
    ! value attribute to circumvent a bug in FortranGIS: dummy
    ! argument hshp of shpwriteobject should be intent(in)
    
    INTEGER, intent(in):: nshptype ! type of shape, one of the shpt_* constants

    REAL(c_double), intent(in):: padf(:, :) ! (2 or 3, nvertices)
    ! x, y and possibly z coordinates for all the rings. For each
    ! ring, the last vertex must repeat the first vertex.

    integer, intent(in), optional:: pan_part_start(:) ! (nparts)
    ! The list of zero based start vertices for the rings (parts) in
    ! this object. The first should always be zero.

    ! Local:
    TYPE(shpobject) psobject
    integer nparts, i

    !-----------------------------------------------------------------

    if (present(pan_part_start)) then
       nparts = size(pan_part_start)

       if (size(padf, 1) == 3) then
          psobject = shpcreateobject(nshptype, ishape = - 1, nparts = nparts, &
               panpartstart = pan_part_start, &
               panparttype = [(shpp_ring, i = 1, nparts)], &
               nvertices = size(padf, 2), padfx = padf(1, :), &
               padfy = padf(2, :), padfz = padf(3, :))
       else
          psobject = shpcreateobject(nshptype, ishape = - 1, nparts = nparts, &
               panpartstart = pan_part_start, &
               panparttype = [(shpp_ring, i = 1, nparts)], &
               nvertices = size(padf, 2), padfx = padf(1, :), &
               padfy = padf(2, :))
       end if
    else
       if (size(padf, 1) == 3) then
          psobject = shpcreatesimpleobject(nshptype, &
               nvertices = size(padf, 2), padfx = padf(1, :), &
               padfy = padf(2, :), padfz = padf(3, :))
       else
          psobject = shpcreatesimpleobject(nshptype, &
               nvertices = size(padf, 2), padfx = padf(1, :), &
               padfy = padf(2, :))
       end if
    end if

    if (shpisnull(psobject)) then
       print *, "shp_append_object_03_c_double: error creating the object"
       print *, "nshptype = ", nshptype
       stop 1
    end if

    ishape = shpwriteobject(hshp, - 1, psobject)

    if (ishape == - 1) then
       print *, "shp_append_object_03_c_double: error writing the object"
       print *, "nshptype = ", nshptype
       stop 1
    end if

    CALL shpdestroyobject(psobject)

  end subroutine shp_append_object_03_c_double

end module shp_append_object_03_m
