% markEyeCenter: Function that places marks over an eye on an image
%   params:
%     image: matrix representing the image
%     bbox: array of coordinates representing a box that is considered the center of the gaze
%     handles: Object containing references to the elements on the UI
%   returned value:
%     data: a structure containing
%       image: modified image if an eye was detected
%       bbox: coordinates of the center of the gaze if an eye was detected
%       center: coordinates of the center of the located eye if an eye was detected
function [data] = markEyeCenter(image, bbox, handles)
  % Initialize the data that will be returned from this function
  % in case the given image doesn't contain an eye
  data = {};  
  data.image = image;
  data.bbox = [];
  data.center = [];

  % If there are coordinates of a located eye
  if ~ isempty(bbox)
    % Size of the border of the square placed arround the located eye
    border = 2;
    % Shrink value for the y1 and y2 coordinates to make 
    % smallerthe located eye coordinates
    shrinkYValue = 20;
    % Value to adjust the right side of the box by the specified amount of pixels
    adjustXRight = 3;

    % Four coordinates that will be used to form a box
    % Original x1 coordinated of the located eye
    x1 = bbox(1);
    % Modified y1 coordinate of the located eye
    % it was modified to make the top side a little smaller
    y1 = bbox(2) + shrinkYValue;
    % Modified x2 coordinate of the located eye
    % it was modified to make the right side a little smaller
    x2 = x1 + bbox(3) - adjustXRight;
    % Modified y2 coordinate of the located eye
    % it was modified to make the bottom side a little smaller
    y2 = (y1 - shrinkYValue) + bbox(4);

    % If the Display Gaze Option on the main UI isn't Threshold Eye
    % draw a red square over the located eye
    if ~strcmp(handles.gazeOption, 'threshold')
      % draw horizontal lines
      data.image(y1:y1+border, x1:x2, 1) = 255;
      data.image(y2-border:y2, x1:x2, 1) = 255;
      % draw vertical lines
      data.image(y1:y2, x1:x1+border, 1) = 255;
      data.image(y1:y2, x2-border:x2, 1) = 255;
    end

    % From the original image, extract only the portion of that contains
    % the located eye
    eyeFrame = image(y1:y2, x1:x2, :);
    % Get the height and width of the image of the eye
    [eyeH, eyeW, ~] = size(eyeFrame);
    % Determine the middle coordinates of the image of the eye
    % this middle coordinates will be used to form a green box
    % that will indicate the center of the gaze
    midY = round(eyeH / 2) + y1;
    midX = round(eyeW / 2) + x1;

    % Amount of pixels that will be used as the space inside every
    % side of the green box
    space = round(eyeH / 2 / 2) - 5;

    % x1 coordinate of the green box (left side)
    bx1 = midX - space + 1;
    % x2 coordinate of the green box (right side)
    bx2 = midX + space - 4;
    % y1 coordinate of the green box (top side)
    by1 = midY - space + 5;
    % y2 coordinate of the green box (bottom side)
    by2 = midY + space - 4;
    
    % If the Display Gaze Option on the main UI is Center & Space
    % draw a green box over the coordinates that are considered
    % the center of the gaze
    if strcmp(handles.gazeOption, 'center & space')
      data.image(by1:by2, bx1:bx2, 2) = 255;
    end

    % Assign the green box coordinates to the returned data
    data.bbox = [bx1, by1, bx2, by2];

    % Find circles using the circular Hough Transform 
    % over the image that contains the located eye
    % and get only the coordinates indicating the center of the circles
    [centers, ~] = imfindcircles(eyeFrame, [10 30], 'ObjectPolarity', 'dark', 'Sensitivity', 0.8, 'Method', 'twostage', 'EdgeThreshold', .05);

    % If the Display Gaze Option on the main UI is Threshold Eye
    % binarize the area where the eye was detected
    if strcmp(handles.gazeOption, 'threshold')
      % Binarize the area where the eye is located
      binimage = imbinarize(rgb2gray(data.image(y1:y2, x1:x2, :)), 75 / 255);
      % Get the size of the binarized image
      [rows, cols] = size(binimage);
      % Create a back image with the same dimensions of the binarized image
      thresholdedImage = zeros(rows, cols);
      % Calculate a new y1 and y2 coordinates
      % this coordinates will be used to only cover the area where the 
      % eyelids and the pupil are displayed
      midy1 = max([round(rows / 2 - 10), 0]);
      midy2 = round(rows / 2 + 10);

      % Convert the 1 values (representing the white color) on the binarized image to 255
      for i = 1:rows
        for j = 1:cols
          % If the current pixel value is 1
          if binimage(i, j) == 1
            % Assign the value 255 to the current pixel of the thresholded image
            thresholdedImage(i, j) = 255;
          end
        end
      end

      % Condition to prevent an error
      % Sometimes the midy1 variable can be negative     
      if midy1 > 0
        % For every color channel of the original image
        for i = 1:3
          % Replace the pixels corresponding the eye area to black and white colors
          % Using the thresholded image
          data.image(y1+midy1:y1+midy2, x1:x2, i) = thresholdedImage(midy1:midy2, :);
        end
      end
    end

    % If some circles were found using the Hough Transform
    if ~isempty(centers)
      % Number of pixels used to ajust the center x coordinate
      adjustX = 3;
      % Number of pixels used to ajust the center y coordinate
      adjustY = 3;

      % Extract the only the coordinates of the center of the first circle
      % Since the center coordinates were taken using only the cropped image of the eye
      % it's necessary to make and adjustment, so that the coordinates now indicate 
      % the center of the eye in the image where the whole person is shown, 
      % not only where the eye is shown
      center = centers(1, :) + [x1 - adjustX, y1 - adjustY];
      % Round the coordinates to an integer number
      center = round(center);
      % Assign the eye center coordinates to the returned data
      data.center = [center(1), center(2)];

      % If the Display Gaze Option on the main UI is Center or Center & Space
      % draw a red cross over the center of the located eye
      if strcmp(handles.gazeOption, 'center') || strcmp(handles.gazeOption, 'center & space')
        data.image(center(2) - 1 : center(2) + 1, center(1) - 7 : center(1) + 7, 1) = 255;
        data.image(center(2) - 7 : center(2) + 7, center(1) - 1 : center(1) + 1, 1) = 255;
      end
    end
  end
end