cmake_minimum_required (VERSION 3.8)

set(PROJECT_NAME "main")

add_library(${PROJECT_NAME} STATIC "main.cpp")

target_link_libraries(${PROJECT_NAME} mreapi)