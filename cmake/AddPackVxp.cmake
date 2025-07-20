function(add_pack_vxp TARGET_NAME)
    cmake_parse_arguments(ARG 
        ""
        "MREEXEC;RESOURCES;APP_NAME;DEVELOPER_NAME;APPID;BACKGROUND;API;RAM;CERT;CERTID;IMSI;AGGS"
        ""
        ${ARGN}
    )

    if(${CMAKE_SYSTEM_NAME} STREQUAL Generic)
        set(SUFFIX ".vxp")
    elseif(WIN32)
        set(SUFFIX ".vc.vxp")
    else()
        message(FATAL_ERROR "Unsupported target system for VXP packing.")
    endif()

    set(NULL_CPP "null_${TARGET_NAME}.cpp")

    add_custom_command( # repack triger
        OUTPUT ${NULL_CPP} 
        COMMAND ${CMAKE_COMMAND} -E touch ${NULL_CPP} 
        DEPENDS ${ARG_MREEXEC} ${ARG_RESOURCES}
    )

    add_library(${TARGET_NAME} STATIC ${NULL_CPP} )

    set_target_properties(${TARGET_NAME} PROPERTIES
        OUTPUT_NAME "${ARG_APP_NAME}"
        SUFFIX "${SUFFIX}"
        PREFIX ""
    )

    if(ARG_BACKGROUND)
        set(TB 1)
    else()
        set(TB 0)
    endif()

    set(_DEVELOPER_NAME "${ARG_DEVELOPER_NAME}")
    if(NOT _DEVELOPER_NAME)
        set(_DEVELOPER_NAME "${DEVELOPER_NAME}")
    endif()

    set(_CERT "${ARG_CERT}")
    if(NOT _CERT)
        set(_CERT "${CERT}")
    endif()

    set(_CERTID "${ARG_CERTID}")
    if(NOT _CERTID)
        set(_CERTID "${CERTID}")
    endif()

    set(_IMSI "${ARG_IMSI}")
    if(NOT _IMSI)
        set(_IMSI "${IMSI}")
    endif()

    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND "${TinyMRESDK}/bin/PackApp"
            -a "$<TARGET_FILE:${ARG_MREEXEC}>"
            -r "$<TARGET_FILE:${ARG_RESOURCES}>"
            -o "$<TARGET_FILE:${TARGET_NAME}>"
            -tr "${ARG_RAM}"
            -tn "${ARG_APP_NAME}"
            -tdn "${_DEVELOPER_NAME}"
            -crt "${_CERT}"
            -tai "${ARG_APPID}"
            -tci "${_CERTID}"
            -tb "${TB}"
            -ti "${_IMSI}"
            -tapi "${ARG_API}"
            ${ARG_AGGS}    
        VERBATIM
    )
endfunction()