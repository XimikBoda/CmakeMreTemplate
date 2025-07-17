set(TARGET_NAME "core")

if(${CMAKE_SYSTEM_NAME} STREQUAL Generic) # For Phone
    add_executable (${TARGET_NAME} "gccmain.c")

    target_link_libraries(${TARGET_NAME} "-T ${CMAKE_CURRENT_SOURCE_DIR}/scat.ld")
    
    set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".axf")
elseif(WIN32) # For MoDis
    add_library(${TARGET_NAME} SHARED "null.cpp" "dll.def")
else()
    message(FATAL_ERROR "Wrong target system")
endif()

target_link_libraries(${TARGET_NAME} main mreapi)
