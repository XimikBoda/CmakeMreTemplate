set(TARGET_NAME "main")

add_mre_exec(${TARGET_NAME} "main.cpp")

target_link_libraries(${TARGET_NAME} mreapi)

add_pack_vxp(vxp
   MREEXEC ${TARGET_NAME}
   RESOURSES resourses
   APP_NAME "${APP_NAME}"
   APPID "${APPID}"
   BACKGROUND ${BACKGROUND}
   API "${API}"
   RAM "${RAM}"
)