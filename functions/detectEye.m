function [location] = detectEye(image, eyeType)
  location = [];
  eyeDetector = vision.CascadeObjectDetector(strcat(eyeType, 'EyeCART'));

  bbox = step(eyeDetector, image);
  [~, location] = max(bbox(:, 1));
  bbox = bbox(location, :);

  if ~ isempty(bbox)
    location = bbox;
  end
end