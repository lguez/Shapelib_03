module shp_open_03_m

  implicit none

contains

  subroutine shp_open_03(hshp, pszshapefile, pszaccess, iostat)

    use, intrinsic:: ISO_FORTRAN_ENV

    use shapelib, only: shpfileobject, shpopen, shpfileisnull, dbffileisnull

    TYPE(shpfileobject), intent(out):: hshp
    CHARACTER(len=*), INTENT(in):: pszshapefile ! filename without extension

    CHARACTER(len=*), INTENT(in):: pszaccess ! File access mode.
    ! Should be "rb" for reading or "rb+" for updating a file.

    integer, optional, intent(out):: iostat

    !-------------------------------------------------------------

    hshp = shpopen(pszshapefile, pszaccess)
    ! Note that the shapelib C library prints a message if opening
    ! fails, we cannot prevent this.
    
    if (shpfileisnull(hshp) .or. dbffileisnull(hshp)) then
       if (present(iostat)) then
          iostat = 1
       else
          write(unit = error_unit, fmt = *) "shp_open_03: error"
          write(unit = error_unit, fmt = *) "pszshapefile = ", pszshapefile
          write(unit = error_unit, fmt = *) "pszaccess = ", pszaccess
          stop 1
       end if
    else
       if (present(iostat)) iostat = 0
    end if
    
  end subroutine shp_open_03

end module shp_open_03_m
