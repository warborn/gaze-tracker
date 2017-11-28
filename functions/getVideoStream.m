% getVideoStream: Function that creates a video object
%   params:
%     dimension: array containing the width and height of the resolution 
%       in the form of: [width, height]
%   returned value:
%     videoStream: a video object
function [videoStream] = getVideoStream(dimension)
  % Define a string containing the given resolution
  % for example: YUY2_640x480
  resolution = 'YUY2_' + string(dimension(1)) + 'x' + string(dimension(2));
  % Create a video object
  videoStream = videoinput('winvideo', 1, resolution);
  % Set the color space to rgb
  videoStream.ReturnedColorSpace = 'rgb';
end