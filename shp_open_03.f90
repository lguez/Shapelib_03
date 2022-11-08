module shp_open_03_m

  implicit none

contains

  subroutine shp_open_03(hshp, pszshapefile, pszaccess, iostat)

    use shapelib, only: shpfileobject, shpopen, shpfileisnull, dbffileisnull

    TYPE(shpfileobject), intent(out):: hshp
    CHARACTER(len=*), INTENT(in):: pszshapefile ! filename without extension

    CHARACTER(len=*), INTENT(in):: pszaccess ! File access mode.
    ! Should be "rb" for reading or "rb+" for updating a file.

    integer, optional, intent(out):: iostat

    !-------------------------------------------------------------

    hshp = shpopen(pszshapefile, pszaccess)
    
    if (shpfileisnull(hshp) .or. dbffileisnull(hshp)) then
       if (present(iostat)) then
          iostat = 1
       else
          print *, "shp_open_03: error"
          print *, "pszshapefile = ", pszshapefile
          print *, "pszaccess = ", pszaccess
          stop 1
       end if
    else
       if (present(iostat)) iostat = 0
    end if
    
  end subroutine shp_open_03

end module shp_open_03_m
