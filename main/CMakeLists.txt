set(TARGET_NAME "main")

add_mre_exec(${TARGET_NAME} "main.cpp")

target_link_libraries(${TARGET_NAME} mreapi)