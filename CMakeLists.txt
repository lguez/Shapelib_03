cmake_minimum_required(VERSION 3.13)
project(Shapelib_03_project Fortran)

add_library(shapelib_03 dbf_add_field_03.f90 shp_append_null_03.f90
  shp_open_03.f90 dbf_write_attribute_03.f90 shp_append_point_03.f90
  shp_read_object_03.f90 shapelib_03.f90 shp_create_03.f90
  shp_append_object_03.f90 shp_get_info_03.f90
  dbf_get_field_index_03.f90)

include(ConfigureCompilerFlags)
find_path(fortrangis_INCLUDE_DIR shapelib.mod)
target_include_directories(shapelib_03 PRIVATE ${fortrangis_INCLUDE_DIR})
