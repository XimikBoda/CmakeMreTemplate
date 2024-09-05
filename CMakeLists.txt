cmake_minimum_required (VERSION 3.8)

project ("Demo")

set(MRE_SDK "$ENV{MRE_SDK}")

add_subdirectory(core)
add_subdirectory(mreapi)

add_subdirectory(main)