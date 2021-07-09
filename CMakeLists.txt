cmake_minimum_required(VERSION 3.13)
project(Shapelib_03 Fortran)
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release Profile)

add_library(shapelib_03 dbf_add_field_03.f90 shp_append_null_03.f90
  shp_open_03.f90 dbf_write_attribute_03.f90 shp_append_point_03.f90
  shp_read_object_03.f90 shapelib_03.f90 shp_create_03.f90
  shp_append_object_03.f90 shp_get_info_03.f90
  dbf_get_field_index_03.f90 dbf_read_attribute_03.f90)

find_path(fortrangis_INCLUDE_DIR shapelib.mod)
find_library(fortrangis_LIBRARY fortrangis)
find_library(fortranc_LIBRARY fortranc)
find_library(shapelib_LIBRARY shp)

set_target_properties(shapelib_03 PROPERTIES Fortran_MODULE_DIRECTORY
  ${PROJECT_BINARY_DIR}/modules)

target_include_directories(shapelib_03 PUBLIC
  ${fortrangis_INCLUDE_DIR}
  $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/modules>)

target_link_libraries(shapelib_03 PUBLIC ${fortrangis_LIBRARY}
   PRIVATE ${fortranc_LIBRARY} ${shapelib_LIBRARY})

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
include(ConfigureCompilerFlags)

include(CMakePackageConfigHelpers)
configure_package_config_file(Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION lib/cmake/${PROJECT_NAME})

if(CMAKE_Fortran_COMPILER_ID MATCHES NAG|Intel)
  set(install_include_dir include/${PROJECT_NAME})
  install(DIRECTORY ${PROJECT_BINARY_DIR}/modules/ DESTINATION
    ${install_include_dir})
else()
  set(install_include_dir include)
  install(FILES ${PROJECT_BINARY_DIR}/modules/shapelib_03.mod TYPE INCLUDE)
endif()

install(TARGETS shapelib_03 EXPORT ${PROJECT_NAME}Targets LIBRARY
  INCLUDES DESTINATION ${install_include_dir})
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  DESTINATION lib/cmake/${PROJECT_NAME})
install(EXPORT ${PROJECT_NAME}Targets DESTINATION lib/cmake/${PROJECT_NAME})
export(EXPORT ${PROJECT_NAME}Targets)
