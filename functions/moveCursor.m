% moveCursor: Function that moves the computer cursor
%   params:
%     mouse: object that is an instance of the java.awt.Robot class
%     currentPoint: struct containing the X and Y coordinates of the 
%                   current position of the computer's cursor
%     direction: string containing the direction where the cursor should move
%       Valid Directions: up, down, left and right
%     steps: the number of pixels the cursor should move
function moveCursor(mouse, currentPoint, direction, steps)
  % For some reason every time i make a call to the mouse.mouseMove method
  % the cursor moves 1 pixel to the right no matter in what direction i decided to move it
  % This line moves back to the left the cursor by 1 pixel to correct the problem
  currentPoint.x = currentPoint.x - 1;
  
  % Change the current cursor coordinates based on the given direction by the number of steps
  switch direction
    case 'up'
      currentPoint.y = currentPoint.y - steps;
    case 'down'
      currentPoint.y = currentPoint.y + steps;
    case 'right'
      currentPoint.x = currentPoint.x + steps;
    case 'left'
      currentPoint.x = currentPoint.x - steps;
    otherwise
  end

  % Move the cursor to the specified X and Y coordinates
  mouse.mouseMove(currentPoint.x, currentPoint.y);
end