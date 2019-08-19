module shp_get_info_03_m

  implicit none

contains

  subroutine shp_get_info_03(hshp, n_entities, shapetype, minbound, maxbound, &
       dbf_field_count, dbf_record_count)

    use, intrinsic:: ISO_C_BINDING

    use shapelib, only: shpfileobject, shpgetinfo

    TYPE(shpfileobject), INTENT(in):: hshp ! shapefile object to query
    INTEGER, INTENT(out), optional:: n_entities ! number of shapes

    INTEGER, INTENT(out), optional:: shapetype
    ! type of shapes in the file, one of the shpt_* constants

    REAL(kind=c_double), INTENT(out), optional:: minbound(:) ! (4)
    ! lower bounds of shape values

    REAL(kind=c_double), INTENT(out), optional:: maxbound(:) ! (4)
    ! upper bounds of shape values

    INTEGER, INTENT(out), optional:: dbf_field_count ! number of dbf fields

    INTEGER, INTENT(out), optional:: dbf_record_count
    ! number of dbf records, it should be equal to n_entities, but it
    ! is not guaranteed

    ! Local:
    INTEGER n_entities_loc
    INTEGER shapetype_loc
    REAL(kind=c_double) minbound_loc(4)
    REAL(kind=c_double) maxbound_loc(4)
    INTEGER dbf_field_count_loc
    INTEGER dbf_record_count_loc

    !---------------------------------------------------------------------

    call shpgetinfo(hshp, n_entities_loc, shapetype_loc, minbound_loc, &
         maxbound_loc, dbf_field_count_loc, dbf_record_count_loc)
    if (present(n_entities)) n_entities = n_entities_loc
    if (present(shapetype)) shapetype = shapetype_loc
    if (present(minbound)) minbound = minbound_loc
    if (present(maxbound)) maxbound = maxbound_loc
    if (present(dbf_field_count)) dbf_field_count = dbf_field_count_loc
    if (present(dbf_record_count)) dbf_record_count = dbf_record_count_loc

  end subroutine shp_get_info_03

end module shp_get_info_03_m
