cmake_minimum_required(VERSION 3.13)
project(Shapelib_03_project Fortran)

add_library(shapelib_03 dbf_add_field_03.f shp_append_null_03.f shp_open_03.f dbf_write_attribute_03.f shp_append_point_03.f shp_read_object_03.f shapelib_03.f shp_create_03.f shp_append_object_03.f shp_get_info_03.f dbf_get_field_index_03.f)

set_target_properties(shapelib_03 PROPERTIES Fortran_FORMAT FREE)
include(ConfigureCompilerFlags)
get_directory_property(my_parent PARENT_DIRECTORY)
find_path(fortrangis_INCLUDE_DIR shapelib.mod)
target_include_directories(shapelib_03 PRIVATE ${fortrangis_INCLUDE_DIR})
