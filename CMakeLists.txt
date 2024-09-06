cmake_minimum_required (VERSION 3.8)

project ("Demo")


set(APP_NAME "Demo" CACHE STRING "App name")
set(DEVELOPER_NAME "YouName" CACHE STRING "Developer name")
set(RAM "500" CACHE STRING "Ram requirement (in kb)")

set(MRE_SDK "$ENV{MRE_SDK}" CACHE STRING "MRE SDK dir")
set(TinyMRESDK "$ENV{TinyMRESDK}" CACHE STRING "TinyMRESDK dir")

add_subdirectory(resourses)
add_subdirectory(core)
add_subdirectory(mreapi)
add_subdirectory(vxp)

add_subdirectory(main)