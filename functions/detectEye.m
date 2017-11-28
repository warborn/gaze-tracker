% detectEye: It's a function that detects an eye on an image
%   params:
%     image: matrix representing the image
%     eyeType: string that contains the value 'Left' or 'Right' 
%   returned value:
%     location: an array of coordinates in the form of [x1, y1, y2, y2]
function [location] = detectEye(image, eyeType)
  % Initialize coordinates to an empty array
  location = [];
  % Create a Right Eye detector
  eyeDetector = vision.CascadeObjectDetector(strcat(eyeType, 'EyeCART'));

  % Apply the detector to the image
  bbox = step(eyeDetector, image);
  % In case the dectector, detects more than 1 eye
  % Get only the greater bbox
  [~, location] = max(bbox(:, 1));
  bbox = bbox(location, :);

  % If an eye is detected, return the coordinates
  if ~ isempty(bbox)
    location = bbox;
  end
end