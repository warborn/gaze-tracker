function [data] = markEyeCenter(image, bbox)
  data = {};  
  data.image = image;
  data.bbox = [];
  data.center = [];

  if ~ isempty(bbox)
    border = 2;
    shrinkValue = 20;
    adjustY = 3;
    adjustXRight = 3;
    x1 = bbox(1);
    y1 = bbox(2) + shrinkValue;
    x2 = x1 + bbox(3) - adjustXRight;
    y2 = (y1 - shrinkValue) + bbox(4);

    % horizontal lines
    data.image(y1:y1+border, x1:x2, 1) = 255;
    data.image(y2-border:y2, x1:x2, 1) = 255;
    % vertical lines
    data.image(y1:y2, x1:x1+border, 1) = 255;
    data.image(y1:y2, x2-border:x2, 1) = 255;

    eyeFrame = image(y1:y2, x1:x2, :);
    [eyeH, eyeW, ~] = size(eyeFrame);
    midY = round(eyeH / 2) + y1;
    midX = round(eyeW / 2) + x1;

    space = round(eyeH / 2 / 2) - 5;
    bx1 = midX - space - 1;
    bx2 = midX + space + 3;
    by1 = midY - space;
    by2 = midY + space - 3;

    data.image(by1:by2, bx1:bx2, 2) = 255;
    data.bbox = [bx1, by1, bx2, by2];
    % outputImage(midY - space: midY + space, midX - space:midX + space, 2) = 255;

    [centers, ~] = imfindcircles(eyeFrame,[10 30], 'ObjectPolarity', 'dark', 'Sensitivity', 0.8, 'Method', 'twostage', 'EdgeThreshold', .05);

    if ~isempty(centers)
      center = centers(1, :) + [x1, y1 - adjustY];
      center = round(center);
      data.center = [center(1), center(2)];
      data.image(center(2) - 1 : center(2) + 1, center(1) - 7 : center(1) + 7, 1) = 255;
      data.image(center(2) - 7 : center(2) + 7, center(1) - 1 : center(1) + 1, 1) = 255;
    end
  end
end