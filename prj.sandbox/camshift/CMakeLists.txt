project(ocv_camshift)
find_package(OpenCV REQUIRED)
add_executable(ocv_camshift
  src/camshiftdemo.cpp
)

target_link_libraries(ocv_camshift
  ${OpenCV_LIBS}
)
