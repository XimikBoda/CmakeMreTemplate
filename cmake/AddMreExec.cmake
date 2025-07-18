set(COMMON_DIR ${PROJECT_SOURCE_DIR}/common)

function(add_mre_exec TARGET_NAME)
    set(TARGET_NAME ${ARGV0})
    list(REMOVE_AT ARGV 0) 
    set(SRCS ${ARGV})

    if(${CMAKE_SYSTEM_NAME} STREQUAL Generic) # For Phone
        add_executable(${TARGET_NAME} ${SRCS} "${COMMON_DIR}/gccmain.c")

        target_link_options(${TARGET_NAME} PRIVATE 
            "-T${COMMON_DIR}/scat.ld"
            "-Wl,--no-warn-rwx-segment"
        )

        set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".axf")
    elseif(WIN32) # For MoDis
        add_library(${TARGET_NAME} SHARED ${SRCS} "${COMMON_DIR}/dll.def")
    else()
        message(FATAL_ERROR "Unsupported target system: ${CMAKE_SYSTEM_NAME}")
    endif()

    #target_link_libraries(${TARGET_NAME} mreapi)
endfunction()