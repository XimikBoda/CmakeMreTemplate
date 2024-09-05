cmake_minimum_required (VERSION 3.8)

set(PROJECT_NAME "core")

if(${CMAKE_SYSTEM_NAME} STREQUAL Generic) # For Phone
    add_executable (${PROJECT_NAME} "gccmain.c")

    target_link_libraries(${PROJECT_NAME} "-T ${PROJECT_SOURCE_DIR}/core/scat.ld")
    
    set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.axf")
elseif(WIN32) # For MoDis
    add_library(${PROJECT_NAME} SHARED "dll.def")
else()
    message(FATAL_ERROR "Wrong target system")
endif()

target_link_libraries(${PROJECT_NAME} main mreapi)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND "${PROJECT_SOURCE_DIR}/../TinyMRESDK/out/build/x64-Debug/PackApp/PackApp.exe" -a $<TARGET_FILE:${PROJECT_NAME}> -r ${PROJECT_SOURCE_DIR}/empty.res -o ${PROJECT_NAME}.vxp -tr 1000 -tdn "Noname" -tn "Cmake Test"
)

