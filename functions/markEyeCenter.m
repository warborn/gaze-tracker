function outputImage = markEyeCenter(image, bbox)
  outputImage = image;
  if ~ isempty(bbox)
    border = 2;
    x1 = bbox(1);
    y1 = bbox(2);
    x2 = x1 + bbox(3);
    y2 = y1 + bbox(4);

    % horizontal lines
    outputImage(y1:y1+border, x1:x2, 1) = 255;
    outputImage(y2-border:y2, x1:x2, 1) = 255;
    % vertical lines
    outputImage(y1:y2, x1:x1+border, 1) = 255;
    outputImage(y1:y2, x2-border:x2, 1) = 255;

    eyeFrame = image(y1:y2, x1:x2, :);
    [centers, ~] = imfindcircles(eyeFrame,[10 30], 'ObjectPolarity', 'dark', 'Sensitivity', 0.8, 'Method', 'twostage', 'EdgeThreshold', .05);

    if ~ isempty(centers)
      center = centers(1, :) + [x1, y1];
      center = round(center);
      outputImage(center(2) - 1 : center(2) + 1, center(1) - 7 : center(1) + 7, 1) = 255;
      outputImage(center(2) - 7 : center(2) + 7, center(1) - 1 : center(1) + 1, 1) = 255;
    end
  end
end