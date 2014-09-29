# ----------------------------------------------------------------------------
#  CMake file for libwebp. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
project(libwebp)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/cpu-features")

file(GLOB lib_srcs dec/*.c dsp/*.c enc/*.c mux/*.c utils/*.c webp/*.c)
file(GLOB lib_hdrs dec/*.h dsp/*.h enc/*.h mux/*.h utils/*.h webp/*.h)

if(ANDROID AND ARMEABI_V7A AND NOT NEON)
  foreach(file ${lib_srcs})
    if("${file}" MATCHES "_neon.c")
      set_source_files_properties("${file}" COMPILE_FLAGS "-mfpu=neon")
    endif()
  endforeach()
endif()

file(GLOB cpuf_s cpu-features/*.c)
file(GLOB cpuf_h cpu-features/*.h)

if(ANDROID)
  set(lib_srcs ${lib_srcs} ${cpuf_s})
  set(lib_hdrs ${lib_hdrs} ${cpuf_h})
endif()

# ----------------------------------------------------------------------------------
#         Define the library target:
# ----------------------------------------------------------------------------------

add_definitions(-DWEBP_USE_THREAD)

add_library(libwebp STATIC ${lib_srcs} ${lib_hdrs})

if(UNIX)
  if(CMAKE_COMPILER_IS_GNUCXX OR CV_ICC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-maybe-uninitialized")
  endif()
endif()

if (libwebp_INSTALL_CUSTOM)
  install(TARGETS libwebp
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib)
 INSTALL(DIRECTORY webp DESTINATION include)
endif()

