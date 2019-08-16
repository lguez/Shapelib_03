module dbf_get_field_index_03_m

  implicit none

contains
  
  subroutine dbf_get_field_index_03(hshp, pszfieldname, ifield)

    use shapelib, only: shpfileobject, dbfgetfieldindex

    TYPE(shpfileobject), INTENT(in):: hshp
    CHARACTER(len=*), INTENT(in):: pszfieldname
    INTEGER, intent(out):: ifield

    !------------------------------------------------------------------

    ifield = dbfgetfieldindex(hshp, pszfieldname)
    
    if (ifield == - 1) then
       print *, "dbf_get_field_index_03: field is not found or shapefile ", &
            "object is not valid"
       print *, "pszfieldname = ", pszfieldname
       stop 1
    end if
    
  end subroutine dbf_get_field_index_03
  
end module dbf_get_field_index_03_m
