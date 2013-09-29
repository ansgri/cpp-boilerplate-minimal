#pragma once

#ifndef OCV_INTEROP_H_INCLUDED
#define OCV_INTEROP_H_INCLUDED

#include <opencv2/opencv.hpp>

inline int minImgFromCvMat(MinImg *dst, const cv::Mat *src)
{
  if (!src || !dst || dst->pScan0)
    return BAD_ARGS;

  dst->width = src->cols;
  dst->height = src->rows;
  dst->channels = src->elemSize() / src->elemSize1();
  dst->channelDepth = src->elemSize1();

  switch (src->depth())
  {
  case CV_8U:
  case CV_16U:
    dst->format = FMT_UINT;
    break;

  case CV_8S:
  case CV_16S:
  case CV_32S:
    dst->format = FMT_INT;
    break;

  case CV_32F:
  case CV_64F:
    dst->format = FMT_FLOAT;
    break;

  default:
    return NOT_IMPLEMENTED;
  }

  dst->stride = src->step;
  dst->pScan0 = src->data;

  return NO_ERRORS;
}


inline int minImgToCvMat(const MinImg *src, cv::Mat *dst)
{
  if (!src || !dst || dst->data)
    return BAD_ARGS;

  int cvMatType;
  switch (src->format)
  {
  case FMT_UINT:
    if (src->channelDepth == 1)
      cvMatType = CV_8U;
    else if (src->channelDepth == 2)
      cvMatType = CV_16U;
    else 
      return NOT_IMPLEMENTED;
    break;

  case FMT_INT:
    if (src->channelDepth == 1)
      cvMatType = CV_8S;
    else if (src->channelDepth == 2)
      cvMatType = CV_16S;
    else if (src->channelDepth == 4)
      cvMatType = CV_32S;
    else
      return NOT_IMPLEMENTED;
    break;

  case FMT_FLOAT:
    if (src->channelDepth == 4)
      cvMatType = CV_32F;
    else if (src->channelDepth == 8)
      cvMatType = CV_64F;
    else
      return NOT_IMPLEMENTED;
    break;

  default:
    return NOT_IMPLEMENTED;
  }

  if (src->channels < 1 || src->channels > 4)
    return NOT_IMPLEMENTED;

  *dst = cv::Mat(src->height, src->width, CV_MAKETYPE(cvMatType, src->channels), src->pScan0, src->stride);
  return NO_ERRORS;
}

#endif  /* OCV_INTEROP_H_INCLUDED */