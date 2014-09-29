# ----------------------------------------------------------------------------
#  CMake file for leptonica. See root CMakeLists.txt
#
# ----------------------------------------------------------------------------
project(leptonica)

# List of C++ files:

# The .cpp files:
file(GLOB lib_srcs *.c)
file(GLOB lib_hdrs *.h)
if(MSVC)
  file(GLOB lib_rsrs *.rc)    
endif()
# ----------------------------------------------------------------------------------
# 				Define the library target:
# ----------------------------------------------------------------------------------
                                 	
set(thirdparty_LIBS jpeg tiff zlib)

if(MSVC)
  add_definitions("/wd4244 /wd4305 /wd4018 /wd4996")
endif()

add_library(leptonica STATIC ${lib_srcs} ${lib_hdrs} ${lib_rsrs})
target_link_libraries(leptonica ${thirdparty_LIBS})
add_dependencies(leptonica ${thirdparty_LIBS})
