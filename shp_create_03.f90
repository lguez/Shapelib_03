module shp_create_03_m

  implicit none

contains

  subroutine shp_create_03(pszshapefile, nshapetype, hshp)

    use, intrinsic:: ISO_FORTRAN_ENV

    use shapelib, only: shpfileobject, shpcreate, shpfileisnull, dbffileisnull

    CHARACTER(len=*), INTENT(in):: pszshapefile ! filename without extension
    INTEGER, INTENT(in):: nshapetype ! type of shapes in the dataset
    TYPE(shpfileobject), intent(out):: hshp

    !-------------------------------------------------------------

    hshp = shpcreate(pszshapefile, nshapetype)

    if (shpfileisnull(hshp) .or. dbffileisnull(hshp)) then
       write(unit = error_unit, fmt = *) "shp_create_03: error"
       write(unit = error_unit, fmt = *) "pszshapefile = ", pszshapefile
       write(unit = error_unit, fmt = *) "nshapetype = ", nshapetype
       stop 1
    end if

  end subroutine shp_create_03

end module shp_create_03_m
