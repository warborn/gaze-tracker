function [videoStream] = getVideoStream(dimension)
  resolution = 'YUY2_' + string(dimension(1)) + 'x' + string(dimension(2));
  videoStream = videoinput('winvideo', 1, resolution);
  videoStream.ReturnedColorSpace = 'rgb';
end