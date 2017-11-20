function showPlaceholder(placeholderAxes)
  placeholderImage = imread('./img/placeholder.jpg');
  axes(placeholderAxes);
  imshow(placeholderImage);