% hasDirection: Function that returns true if the gaze is located at the
%               given direction
%   params:
%     bbox: array of coordinates representing a box that is considered the center of the gaze
%     center: array of coordinates representing a point that is the center of an eye
%     direction: string containing the name of a direction
%       Valid Directions: center, up, down, left and right
%   returned value:
%     bool: true or false value indicating if the point is located at the given direction
function bool = hasDirection(bbox, center, direction)
  switch direction
    case 'center'
      bool = isCentered(bbox, center);
    case 'up'
      bool = isTop(bbox, center);
    case 'down'
      bool = isBottom(bbox, center);
    case 'left'
      bool = isLeft(bbox, center);
    case 'right'
      bool = isRight(bbox, center);
    otherwise
      bool = false;
  end


% The following are a set of functions with the same signature
% they accept array of coordinates representing  a box that is considered the center of the gaze (bbox)
% and an array of coordinates representing a point that is the center of an eye (center).
% This functions return a true or false value indicating if the point is located at the given direction.

% Coordinates corresponding to the box
% bbox(1)   -> x1
% bbox(2)   -> y1
% bbox(3)   -> x2
% bbox(4)   -> y2

% Coordinates corresponding to a point on the image
% center(1) -> cx
% center(2) -> cy

% Function that determines if the point it's over the box
function bool = isCentered(bbox, center)
  bool = false;
  %         cx >= x1                cx <= x2                cy >= y1                cy <= y2 
  if center(1) >= bbox(1) && center(1) <= bbox(3) && center(2) >= bbox(2) && center(2) <= bbox(4)
    bool = true;
  end

% Function that determines if the point it's above the box
function bool = isTop(bbox, center)
  bool = false;
  %                                      cy < y1                cx >= x1                cx <= x2
  if ~isCentered(bbox, center) && center(2) < bbox(2) && center(1) >= bbox(1) && center(1) <= bbox(3)
    bool = true;
  end

% Function that determines if the point it's below the box
function bool = isBottom(bbox, center)
  bool = false;
  %                                      cy > y2                cx >= x1                cx <= x2
  if ~isCentered(bbox, center) && center(2) > bbox(4) && center(1) >= bbox(1) && center(1) <= bbox(3)
    bool = true;
  end

% Function that determines if the point it's at the left of box
function bool = isLeft(bbox, center)
  bool = false;
  %                                      cx < x1                cy >= y1                cy <= y2
  if ~isCentered(bbox, center) && center(1) < bbox(1) && center(2) >= bbox(2) && center(2) <= bbox(4)
    bool = true;
  end

% Function that determines if the point it's at the right box
function bool = isRight(bbox, center)
  bool = false;
  %                                      cx > x2                cy >= y1                cy <= y2
  if ~isCentered(bbox, center) && center(1) > bbox(3) && center(2) >= bbox(2) && center(2) <= bbox(4)
    bool = true;
  end