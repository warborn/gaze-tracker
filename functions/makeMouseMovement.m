% makeMouseMovement: Function that determines where to move the computer's cursor
%                    bases on the direction of the gaze
%   params:
%     bbox: array of coordinates representing a box that is considered the center of the gaze
%     center: array of coordinates representing a point that is the center of an eye
%     handles: Object containing references to the elements on the UI
function makeMouseMovement(bbox, center, handles)
  % Get current pointer location
  pointerLocation = get(0, 'PointerLocation');

  % Store the X coordinate
  handles.currentPoint.x = pointerLocation(1);
  % Store the Y coordinate
  handles.currentPoint.y = handles.screenHeight - pointerLocation(2);

  % Set the direction to a default of an empty string
  direction = '';
  % Move the cursor based on the direction of the eye

  % Up direction
  if hasDirection(bbox, center, 'up')
    direction = 'up';
    % Display an arrow image indicating the 'up' direction
    axes(handles.directionImageAxes)
    imshow(handles.directionUpImage);
  % Down direction
  elseif hasDirection(bbox, center, 'down')
    direction = 'down';
    % Display an arrow image indicating the 'down' direction
    axes(handles.directionImageAxes)
    imshow(handles.directionDownImage);
  % Left direction
  elseif hasDirection(bbox, center, 'left')
    direction = 'left';
    % Display an arrow image indicating the 'left' direction
    axes(handles.directionImageAxes)
    imshow(handles.directionLeftImage);
  % Right direction
  elseif hasDirection(bbox, center, 'right')
    direction = 'right';
    % Display an arrow image indicating the 'right' direction
    axes(handles.directionImageAxes)
    imshow(handles.directionRightImage);
  end

  % If the direction it's not the default empty string
  if ~isempty(direction)
    % Move 3 times the cursor
    for i = 1:3
      moveCursor(handles.mouse, handles.currentPoint, direction, handles.speed);
    end
  end
end