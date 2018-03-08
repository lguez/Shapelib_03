module shp_create_03_m

  implicit none

contains

  subroutine shp_create_03(pszshapefile, nshapetype, hshp)

    use shapelib, only: shpfileobject, shpcreate, shpfileisnull, dbffileisnull

    CHARACTER(len=*), INTENT(in):: pszshapefile ! filename without extension
    INTEGER, INTENT(in):: nshapetype ! type of shapes in the dataset
    TYPE(shpfileobject), intent(out):: hshp

    !-------------------------------------------------------------

    hshp = shpcreate(pszshapefile, nshapetype)
    
    if (shpfileisnull(hshp) .or. dbffileisnull(hshp)) then
       print *, "shp_create_03: error"
       print *, "pszshapefile = ", pszshapefile
       print *, "nshapetype = ", nshapetype
       stop 1
    end if
    
  end subroutine shp_create_03

end module shp_create_03_m
