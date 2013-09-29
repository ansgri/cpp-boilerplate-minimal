# --- minstopwatch ---
option(ENABLE_MINSTOPWATCH "Enable collecting execution timing with minstopwatch" ON)
if(ENABLE_MINSTOPWATCH)
  message(STATUS "Minstopwatch timing code enabled")
  add_definitions(-DMINSTOPWATCH_ENABLED)
  set(WITH_TIMING YES)
else()
  message(STATUS "Minstopwatch timing code disabled")
endif()

# --- demo projects ---
option(BUILD_DEMOS "Build demo projects" OFF)
if(BUILD_DEMOS)
  message(STATUS "Demo projects included")
endif()

# --- gprof support ---
if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
  option(ENABLE_GPROF "Compile with gprof support" OFF)
  if (ENABLE_GPROF)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -pg")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -pg")
  endif()
endif()

# --- debug info in release build ---
if(WIN32)
  set(RELEASE_WITH_DEBUG_INFO_DEFAULT OFF)
else()
  set(RELEASE_WITH_DEBUG_INFO_DEFAULT ON)
endif()
option(RELEASE_WITH_DEBUG_INFO "Build release with debug info" ${RELEASE_WITH_DEBUG_INFO_DEFAULT})
if(RELEASE_WITH_DEBUG_INFO)
  message(STATUS "Release will be built with debug info")
  if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -g")
  elseif(MSVC)
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /Zi")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /DEBUG")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /DEBUG")
    set(CMAKE_MODULE_LINKER_FLAGS_RELEASE "${CMAKE_MODULE_LINKER_FLAGS_RELEASE} /DEBUG")
  endif()
endif()

# --- fast-math compiler option ---
if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
  option(ENABLE_FAST_MATH "Compile with -ffast-math flag." ON)
  if (ENABLE_FAST_MATH)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffast-math")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffast-math")
  endif()
endif()