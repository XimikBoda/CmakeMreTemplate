set(TARGET_NAME "resources")

set(RESOURCES_FILES
      demo.png
      demo.txt
)

add_custom_command( # repack triger 
   OUTPUT null.cpp
   COMMAND ${CMAKE_COMMAND} -E touch null.cpp
   DEPENDS ${RESOURCES_FILES}
)

add_library(${TARGET_NAME} STATIC "null.cpp")

set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".res")
set_target_properties(${TARGET_NAME} PROPERTIES PREFIX "")

add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
   WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
   COMMAND "${TinyMRESDK}/bin/PackRes" 
               -o "$<TARGET_FILE:${TARGET_NAME}>"
               -f ${RESOURCES_FILES}
               --empty-logo
)