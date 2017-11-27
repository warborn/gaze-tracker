function [outputImage, bbox, center] = markEyes(image, handles)
  rightEyeLocation = detectEye(image, 'Right');
  data = markEyeCenter(image, rightEyeLocation, handles);
  outputImage = data.image;
  bbox = data.bbox;
  center = data.center;
end