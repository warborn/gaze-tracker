% locateEyes: Function in charge of locating and placing a mark over the detected eye
%   params:
%     image: matrix representing the image
%     handles: Object containing references to the elements on the UI
%   returned value:
%     outputImage: matrix representing the modified image
%     bbox: array of coordinates representing a box that is considered the center of the gaze
%     center: array of coordinates representing a point that is the center of an eye
function [outputImage, bbox, center] = locateEyes(image, handles)
  % Get the location of the right eye
  rightEyeLocation = detectEye(image, 'Right');
  % Place a cross over the center of the right eye
  data = markEyeCenter(image, rightEyeLocation, handles);
  % Return modified image, box coordinates and center coordinates
  outputImage = data.image;
  bbox = data.bbox;
  center = data.center;
end