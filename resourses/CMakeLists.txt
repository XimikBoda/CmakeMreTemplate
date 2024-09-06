cmake_minimum_required (VERSION 3.8)

set(PROJECT_NAME "resourses")

add_library(${PROJECT_NAME} STATIC "null.cpp")

set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".res")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND "${TinyMRESDK}/bin/PackRes.exe" 
               -o "$<TARGET_FILE:${PROJECT_NAME}>" 
               --empty-logo
)