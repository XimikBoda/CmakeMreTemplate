cmake_minimum_required (VERSION 3.10)

project ("Demo")

set(APP_NAME "Demo")
set(DEVELOPER_NAME "YouName")
set(RAM "500") #Ram requirement (in kb)
set(IMSI "1234567890" CACHE STRING "Imsi of first SIM-card")
set(API "File SIM_card ProMng") #Api for app, 
set(APPID "0") #App id, special values: -1 is personal (imsi), 0 is in developing
set(CERTID "1" CACHE STRING "") #Cert id use from you cert, 1 is personal (imsi)
set(CERT "none" CACHE STRING "Path to cert, used when APPID!=-1 and CERTID!=1")
option(BACKGROUND "App can work background" OFF)

set(MRE_SDK "$ENV{MRE_SDK}" CACHE STRING "MRE SDK dir")
set(TinyMRESDK "$ENV{TinyMRESDK}" CACHE STRING "TinyMRESDK dir")

if(BACKGROUND)
    add_definitions(-DSUPPORT_BG)
endif()

include(cmake/MreUtils.cmake)

add_subdirectory(resourses)
add_subdirectory(mreapi)
add_subdirectory(run)

add_subdirectory(main)

#Full api list: Audio Camera Call TCP File HTTP Sensor SIM_card Record SMS_person SMS_SP BitStream Contact LBS MMS ProMng SMSMng Video XML Sec SysStorage Payment BT PUSH UDP SysFile