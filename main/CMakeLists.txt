set(TARGET_NAME "main")

add_library(${TARGET_NAME} STATIC "main.cpp")

target_link_libraries(${TARGET_NAME} mreapi)