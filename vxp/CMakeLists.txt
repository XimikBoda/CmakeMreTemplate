cmake_minimum_required (VERSION 3.8)

set(PROJECT_NAME "vxp")

add_custom_command( # repack triger 
   OUTPUT null.cpp
   COMMAND ${CMAKE_COMMAND} -E touch null.cpp
   DEPENDS core resourses
)

add_library(${PROJECT_NAME} STATIC "null.cpp")

set_target_properties(${PROJECT_NAME} PROPERTIES OUT_NAME "${APP_NAME}")
set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".vxp")
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

if(${CMAKE_SYSTEM_NAME} STREQUAL Generic) # For Phone
   set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".vxp")
elseif(WIN32) # For MoDis
   set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".vc.vxp")
else()
    message(FATAL_ERROR "Wrong target system")
endif()


if(BACKGROUND)
   set(TB 1)
else()
   set(TB 0)
endif()

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND "${TinyMRESDK}/bin/PackApp" 
               -a "$<TARGET_FILE:core>" 
               -r "$<TARGET_FILE:resourses>" 
               -o "$<TARGET_FILE:${PROJECT_NAME}>" 
               -tr "${RAM}" 
               -tn "${APP_NAME}"
               -tdn "${DEVELOPER_NAME}"
               -tb "${TB}"
               -ti "${IMSI}"
               -tapi "${API}"
)
