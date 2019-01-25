#set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(IOS_PLATFORM iPhoneOS.platform)
set(IOS_DEVELOPER_ROOT "/Applications/Xcode.app/Contents/Developer/Platforms/${IOS_PLATFORM}/Developer")
set(IOS_SDK_ROOT ${IOS_DEVELOPER_ROOT}/SDKs/iPhoneOS.sdk)
set(CMAKE_OSX_SYSROOT ${IOS_SDK_ROOT} CACHE PATH "Sysroot used for iOS support")
set(CMAKE_OSX_ARCHITECTURES "arm64 armv7 armv7s" CACHE STRING "Build architecture for iOS")
set(CMAKE_OSX_DEPLOYMENT_TARGET 10 CACHE STRING "Build deployment target for iOS")
set(CMAKE_FIND_ROOT_PATH ${IOS_DEVELOPER_ROOT} ${IOS_SDK_ROOT})
set(CMAKE_FIND_FRAMEWORK FIRST)
set(CMAKE_SYSTEM_FRAMEWORK_PATH
	${CMAKE_IOS_SDK_ROOT}/System/Library/Frameworks
	${CMAKE_IOS_SDK_ROOT}/System/Library/PrivateFrameworks
	${CMAKE_IOS_SDK_ROOT}/Developer/Library/Frameworks
)

# only search the iOS sdks, not the remainder of the host filesystem
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
