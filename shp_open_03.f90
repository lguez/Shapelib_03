module shp_open_03_m

  implicit none

contains

  subroutine shp_open_03(hshp, pszshapefile, pszaccess)

    use shapelib, only: shpfileobject, shpopen, shpfileisnull, dbffileisnull

    TYPE(shpfileobject), intent(out):: hshp
    CHARACTER(len=*), INTENT(in):: pszshapefile ! filename without extension

    CHARACTER(len=*), INTENT(in):: pszaccess ! File access mode.
    ! Should be "rb" for reading or "rb+" for updating a file.

    !-------------------------------------------------------------

    hshp = shpopen(pszshapefile, pszaccess)
    
    if (shpfileisnull(hshp) .or. dbffileisnull(hshp)) then
       print *, "shp_open_03: error"
       print *, "pszshapefile = ", pszshapefile
       print *, "pszaccess = ", pszaccess
       stop 1
    end if
    
  end subroutine shp_open_03

end module shp_open_03_m
