# Option independent functions and macros are defined here.


# each argument past the last expected argument is appended to the variable
# listName with the given prefix
# for example:
#   create_prefixed_list(sources src/ a.c b.c d.c)
# will set sources=src/a.c;src/b.c;src/d.c
#
function(create_prefixed_list listName prefix)
  if (${listName})
    message(WARNING "list is not empty and its content will be lost")
  endif()
  unset(lst)
  foreach(item ${ARGN})
    set(item "${prefix}${item}")
    list(APPEND lst ${item})
  endforeach(item)
  set(${listName} ${lst} PARENT_SCOPE)
endfunction(create_prefixed_list)



# prints the specified variable
#
function(print_var varName)
  if (${varName})
    message("${varName}=${${varName}}")
  else()
    message(WARNING "variable ${varName} is not defined")
  endif()
endfunction(print_var)



# Locates boost libraries of the specific version used in our project.
# Argument(s): the components required.
# 
# After invocation of this macro the variable ${Boost_LIBRARIES} will
# contain the list of boost libraries you need to link against (for 
# usage with target_link_libraries()).
#
# EXAMPLE:
# find_boost_libs(thread)
# target_link_libraries(myapp ${Boost_LIBRARIES})
#
macro(find_boost_libs libs)
  if(WIN32)
    set(Boost_USE_STATIC_LIBS        ON)
  else()
    set(Boost_USE_STATIC_LIBS        OFF)
  endif()
  set(Boost_USE_MULTITHREADED      ON)
  set(Boost_USE_STATIC_RUNTIME    OFF)
  #find_package(Boost ${TTR_BOOST_VERSION} EXACT REQUIRED COMPONENTS ${ARGV})
  find_package(Boost ${TTR_BOOST_VERSION} REQUIRED COMPONENTS ${ARGV})
endmacro(find_boost_libs)



# performs add_subdirectory() on all subdirectories of the current
# directory which contain CMakeLists.txt. Any arguments given to 
# this function will be treated as exceptions (i.e. the specified
# directories will not be processed)
#
function(add_all_subdirectories)
  file(GLOB fileList *)
  foreach(item ${fileList})
    get_filename_component(name ${item} NAME)
    list(FIND ARGV ${name} index)
    if (("${index}" STREQUAL "-1") AND IS_DIRECTORY ${item} AND EXISTS ${item}/CMakeLists.txt)
      add_subdirectory(${item})
    endif()
  endforeach(item)
endfunction(add_all_subdirectories)
