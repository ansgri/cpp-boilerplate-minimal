#pragma once
#include <stdexcept>
#include <boost/lexical_cast.hpp>


class MinErrException : public std::runtime_error
{
public:
  MinErrException(int code)
  : std::runtime_error("MinErrException: " + boost::lexical_cast<std::string>(code))
  { }

  MinErrException(int code,
                  std::string const& expr, 
                  std::string const& file, 
                  int line)
  : std::runtime_error("MinErrException: " + boost::lexical_cast<std::string>(code)
                       + " in '" + expr 
                       + "' at " + file + ":"  + boost::lexical_cast<std::string>(line))
  { }
};

inline void throwOnMinerr(int code)
{
  if (code < 0)
    throw MinErrException(code);
}

#define THROW_ON_MINERR(expr) do { \
    int const _ret_THROW_ON_MINERR = (expr); \
    if (_ret_THROW_ON_MINERR < 0) \
      throw MinErrException(_ret_THROW_ON_MINERR, #expr, __FILE__, __LINE__); \
  } while (false)
