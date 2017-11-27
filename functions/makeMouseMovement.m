function makeMouseMovement(bbox, center, handles)
  % Get current pointer location
  pointerLocation = get(0, 'PointerLocation');

  % Store the X coordinate
  handles.currentPoint.x = pointerLocation(1);
  % Store the Y coordinate
  handles.currentPoint.y = handles.screenHeight - pointerLocation(2);

  direction = '';
  % Move the cursor based on the direction of the eye
  if hasDirection(bbox, center, 'top')
    direction = 'up';
    axes(handles.directionImageAxes)
    imshow(handles.directionUpImage);
    % top = top + 1;
    % strcat('top', string(top))
  elseif hasDirection(bbox, center, 'bottom')
    direction = 'down';
    axes(handles.directionImageAxes)
    imshow(handles.directionDownImage);
    % bottom = bottom + 1;
    % strcat('bottom', string(bottom))
  elseif hasDirection(bbox, center, 'left')
    direction = 'left';
    axes(handles.directionImageAxes)
    imshow(handles.directionLeftImage);
    % left = left + 1;
    % strcat('left', string(left))
  elseif hasDirection(bbox, center, 'right')
    direction = 'right';
    axes(handles.directionImageAxes)
    imshow(handles.directionRightImage);
    % right = right + 1;
    % strcat('right', string(right))
  end

  if ~isempty(direction)
    for i = 1:3
      moveCursor(handles.mouse, handles.currentPoint, direction, handles.speed);
    end
  end
end