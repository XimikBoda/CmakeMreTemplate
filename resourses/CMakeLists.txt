cmake_minimum_required (VERSION 3.8)

set(PROJECT_NAME "resourses")

set(RESOURSES_FILES
      demo.png
      demo.txt
)

add_custom_command( # repack triger 
   OUTPUT null.cpp
   COMMAND ${CMAKE_COMMAND} -E touch null.cpp
   DEPENDS ${RESOURSES_FILES}
)

add_library(${PROJECT_NAME} STATIC "null.cpp")

set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".res")
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
   COMMAND "${TinyMRESDK}/bin/PackRes" 
               -o "$<TARGET_FILE:${PROJECT_NAME}>"
               -f ${RESOURSES_FILES}
               --empty-logo
)