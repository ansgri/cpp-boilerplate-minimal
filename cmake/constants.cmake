# --- architecture ---
if(WIN32)
  set(CPPBP_OPERATING_SYSTEM "win")
elseif(UNIX)
  set(CPPBP_OPERATING_SYSTEM "linux")
else()
  message(FATAL_ERROR "Unknown operating system")
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL "4")
  set(CPPBP_CPU_BITNESS "32")
elseif(CMAKE_SIZEOF_VOID_P EQUAL "8")
  set(CPPBP_CPU_BITNESS "64")
else()
  message(FATAL_ERROR "Unsupported CPU bitness")
endif()

set(CPPBP_ARCH ${CPPBP_OPERATING_SYSTEM}${CPPBP_CPU_BITNESS})
message(STATUS "Target architecture: ${CPPBP_ARCH}")

# --- directories ---
set(CPPBP_ROOT ${cppbp_SOURCE_DIR})
set(CPPBP_INCLUDE_ROOT ${CPPBP_ROOT}/include)
set(CPPBP_LIB_ROOT ${CPPBP_ROOT}/lib/${CPPBP_ARCH})
if(WIN32 AND NOT MSVC_IDE)
  set(CPPBP_LIB_ROOT ${CPPBP_LIB_ROOT} ${CPPBP_LIB_ROOT}/${CMAKE_BUILD_TYPE})
endif()



# --- lists of libraries for linking ---
if(WIN32)
  set(CPPBP_OPENCV_LIBS 
    optimized opencv_core242
    optimized opencv_highgui242
    optimized opencv_imgproc242
    optimized opencv_video242
    debug opencv_core242d
    debug opencv_highgui242d
    debug opencv_imgproc242d
    debug opencv_video242d
  )
elseif(UNIX)
  set(CPPBP_OPENCV_LIBS 
    opencv_core
    opencv_highgui
    opencv_imgproc
    opencv_video
  )
endif()

if(WIN32)
  set(CPPBP_JRTP_LIBS 
    optimized jrtplib
    debug jrtplib_d
  )
elseif(UNIX)
  set(CPPBP_JRTP_LIBS
    jrtp
  )
endif()

set(CPPBP_FFMPEG_LIBS
  avcodec
  avcore
  avdevice
  avfilter
  avformat
  avutil
  swscale
)
