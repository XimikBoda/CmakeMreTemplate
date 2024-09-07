cmake_minimum_required (VERSION 3.8)

set(PROJECT_NAME "run_in_MoDis")

add_custom_command( # repack triger 
   OUTPUT null.cpp
   COMMAND ${CMAKE_COMMAND} -E touch null.cpp
   DEPENDS vxp
)

add_library(${PROJECT_NAME} STATIC "null.cpp")

set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".bat")
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

set(MODIS_PATH "${MRE_SDK}/models/Model01_QVGA_MRE3.0/")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "$<TARGET_FILE:vxp>" "${MODIS_PATH}/WIN32FS/DRIVE_E/mre/${APP_NAME}.vc.vxp"
   COMMAND echo "${MODIS_PATH}/MoDIS/Release/MoDIS.exe" > "$<TARGET_FILE:${PROJECT_NAME}>" 
)