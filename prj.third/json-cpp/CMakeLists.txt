project(json-cpp)

set(jsoncpp_HDRS
  autolink.h
  config.h
  features.h
  forwards.h
  json.h
  reader.h
  value.h
  writer.h)

set(jsoncpp_SRCS
  src/json_batchallocator.h
  src/json_internalarray.inl
  src/json_internalmap.inl
  src/json_reader.cpp
  src/json_value.cpp
  src/json_valueiterator.inl
  src/json_writer.cpp)

add_library(jsoncpp STATIC 
  ${jsoncpp_HDRS} 
  ${jsoncpp_SRCS})
