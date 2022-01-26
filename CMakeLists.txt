cmake_minimum_required(VERSION 3.16)
list(APPEND CMAKE_MESSAGE_CONTEXT Shapelib_03)
project(Shapelib_03 LANGUAGES Fortran)
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release Profile)

if(NOT TARGET fortranGIS)
  find_package(fortrangis CONFIG REQUIRED)
endif()

add_library(shapelib_03 dbf_add_field_03.f90 shp_append_null_03.f90
  shp_open_03.f90 dbf_write_attribute_03.f90 shp_append_point_03.f90
  shp_read_object_03.f90 shapelib_03.f90 shp_create_03.f90
  shp_append_object_03.f90 shp_get_info_03.f90
  dbf_get_field_index_03.f90 dbf_read_attribute_03.f90)
set_target_properties(shapelib_03 PROPERTIES Fortran_MODULE_DIRECTORY
  ${PROJECT_BINARY_DIR}/modules)
target_include_directories(shapelib_03 PUBLIC
  $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/modules>)
target_link_libraries(shapelib_03 PUBLIC fortrangis::fortranGIS)
add_library(${PROJECT_NAME}::shapelib_03 ALIAS shapelib_03)
configure_file(${PROJECT_NAME}Config.cmake.in ${PROJECT_NAME}Config.cmake @ONLY)

# Start installation part

if(CMAKE_Fortran_COMPILER_ID MATCHES NAG|Intel|PGI)
  set(install_include_dir include/${PROJECT_NAME})
  install(DIRECTORY ${PROJECT_BINARY_DIR}/modules/ DESTINATION
    ${install_include_dir})
else()
  set(install_include_dir include)
  install(FILES ${PROJECT_BINARY_DIR}/modules/shapelib_03.mod TYPE INCLUDE)
endif()

install(TARGETS shapelib_03 EXPORT ${PROJECT_NAME}Targets INCLUDES
  DESTINATION ${install_include_dir})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  DESTINATION lib/cmake/${PROJECT_NAME})
install(EXPORT ${PROJECT_NAME}Targets DESTINATION
  lib/cmake/${PROJECT_NAME} NAMESPACE ${PROJECT_NAME}::)

# End installation part

export(EXPORT ${PROJECT_NAME}Targets NAMESPACE ${PROJECT_NAME}::)
