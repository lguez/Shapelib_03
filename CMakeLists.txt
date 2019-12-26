cmake_minimum_required(VERSION 3.13)
project(Shapelib_03_project Fortran)

add_library(shapelib_03 dbf_add_field_03.f90 shp_append_null_03.f90
  shp_open_03.f90 dbf_write_attribute_03.f90 shp_append_point_03.f90
  shp_read_object_03.f90 shapelib_03.f90 shp_create_03.f90
  shp_append_object_03.f90 shp_get_info_03.f90
  dbf_get_field_index_03.f90 dbf_read_attribute_03.f90)

find_path(fortrangis_INCLUDE_DIR shapelib.mod)
target_include_directories(shapelib_03 PRIVATE ${fortrangis_INCLUDE_DIR})

get_directory_property(my_parent PARENT_DIRECTORY)

if(NOT my_parent)
  find_package(EZMPI CONFIG REQUIRED)
endif()

target_link_libraries(shapelib_03 ezmpi)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
include(ConfigureCompilerFlags)
