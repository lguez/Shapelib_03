module shp_read_object_03_m

  implicit none

contains

  subroutine shp_read_object_03(hshp, ishape, psobject)

    use shapelib, only: shpfileobject, shpobject, shpreadobject, shpisnull

    type(shpfileobject), intent(inout):: hshp
    integer, intent(in):: ishape
    TYPE(shpobject), intent(out):: psobject

    !-------------------------------------------------------------------

    psobject = shpreadobject(hshp, ishape)

    if (shpisnull(psobject)) then
       print *, "shp_read_object_03: error"
       print *, "ishape = ", ishape
       stop 1
    end if

  end subroutine shp_read_object_03

end module shp_read_object_03_m
