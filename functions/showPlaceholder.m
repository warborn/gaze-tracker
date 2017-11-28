% showPlaceholder: Function that places a default image over the webcam axes
%   params:
%     placeholderAxes: reference to an axes
function showPlaceholder(placeholderAxes)
  % Read the image
  placeholderImage = imread('./img/placeholder.jpg');
  % Place the image over the axes
  axes(placeholderAxes);
  imshow(placeholderImage);