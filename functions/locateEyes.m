function outputImage = markEyes(image)
  rightEyeLocation = detectEye(image, 'Right');
  outputImage = markEyeCenter(image, rightEyeLocation);
end