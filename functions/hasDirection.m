function bool = hasDirection(bbox, center, direction)
  switch direction
    case 'center'
      bool = isCentered(bbox, center);
    case 'top'
      bool = isTop(bbox, center);
    case 'bottom'
      bool = isBottom(bbox, center);
    case 'left'
      bool = isLeft(bbox, center);
    case 'right'
      bool = isRight(bbox, center);
    otherwise
      bool = false;
  end

% bbox(1)   -> x1
% bbox(2)   -> y1
% bbox(3)   -> x2
% bbox(4)   -> y2
% center(1) -> cx
% center(2) -> cy
function bool = isCentered(bbox, center)
  bool = false;
  %         cx >= x1                cx <= x2                cy >= y1                cy <= y2 
  if center(1) >= bbox(1) && center(1) <= bbox(3) && center(2) >= bbox(2) && center(2) <= bbox(4)
    bool = true;
  end

function bool = isTop(bbox, center)
  bool = false;
  %                                      cy < y1                cx >= x1                cx <= x2
  if ~isCentered(bbox, center) && center(2) < bbox(2) && center(1) >= bbox(1) && center(1) <= bbox(3)
    bool = true;
  end

function bool = isBottom(bbox, center)
  bool = false;
  %                                      cy > y2                cx >= x1                cx <= x2
  if ~isCentered(bbox, center) && center(2) > bbox(4) && center(1) >= bbox(1) && center(1) <= bbox(3)
    bool = true;
  end

function bool = isLeft(bbox, center)
  bool = false;
  %                                      cx < x1                cy >= y1                cy <= y2
  if ~isCentered(bbox, center) && center(1) < bbox(1) && center(2) >= bbox(2) && center(2) <= bbox(4)
    bool = true;
  end

function bool = isRight(bbox, center)
  bool = false;
  %                                      cx > x2                cy >= y1                cy <= y2
  if ~isCentered(bbox, center) && center(1) > bbox(3) && center(2) >= bbox(2) && center(2) <= bbox(4)
    bool = true;
  end