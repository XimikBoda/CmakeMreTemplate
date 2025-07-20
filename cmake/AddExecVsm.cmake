function(add_exec_vsm TARGET_NAME)
    cmake_parse_arguments(ARG
        ""
        "RESOURCES;APP_NAME;APPID;API;RAM;BACKGROUND;CERT;CERTID;IMSI;DEVELOPER_NAME;AGGS"
        "SRCS"
        ${ARGN}
    )

    add_mre_exec(${TARGET_NAME} ${ARG_SRCS})

    add_pack_vsm("${TARGET_NAME}_vsm"
        MREEXEC     ${TARGET_NAME}
        RESOURCES   ${ARG_RESOURCES}
        APP_NAME    "${ARG_APP_NAME}"
        APPID       "${ARG_APPID}"
        API         "${ARG_API}"
        RAM         "${ARG_RAM}"
        BACKGROUND  ${ARG_BACKGROUND}
        CERT        "${ARG_CERT}"
        CERTID      "${ARG_CERTID}"
        IMSI        "${ARG_IMSI}"
        DEVELOPER_NAME "${ARG_DEVELOPER_NAME}"
        AGGS        "${ARG_AGGS}"
    )
endfunction()