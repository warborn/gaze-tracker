function [outputImage, bbox, center] = markEyes(image)
  rightEyeLocation = detectEye(image, 'Right');
  data = markEyeCenter(image, rightEyeLocation);
  outputImage = data.image;
  bbox = data.bbox;
  center = data.center;
end