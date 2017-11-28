% formatVideo: Function in charge of creating a function handle
%              that will format every frame of the webcam streaming
%   params:
%     hObject: reference to the hObject coming from the main UI
%   return value:
%       func: function handle (callback)
function func = formatVideo(hObject)
  % prepareVideo is a closure that will be used as a function handle
  function prepareVideo(obj, event, himage)
    % Get a reference to the handles object
    % this reference will be used to update the GUI
    handles = guidata(ancestor(hObject, 'figure') );

    % Rotate frame horizontally
    frame = flip(event.Data, 2);
    % Crop frame to show the person in front of the webcam on the center of the axes
    % This cropping it's assuming a resolution of 640x480
    frame = frame(:, 80:560, :);
    % Place a mark arround each detected eye
    % and get the 
    % markedImage: image with a mark placed where the eye was located
    % bbox: array of coordinates representing a box that is considered the center of the gaze
    % center: array of coordinates representing a point that is the center of an eye
    [markedImage, bbox, center] = locateEyes(frame, handles);

    % Preview the marked image on the webcam axes
    set(himage, 'cdata', markedImage);

    % Set the direction image showed on the axes to a default of 'center'
    axes(handles.directionImageAxes)
    imshow(handles.directionCenterImage);

    % Check if there was an eye on the image
    % and if there is one, check if the gaze isn't located at the center
    if ~isempty(bbox) && ~isempty(center) && ~hasDirection(bbox, center, 'center')
      % move the computer's cursor
      makeMouseMovement(bbox, center, handles)
    end
  end

  % Return the function handle
  func = @prepareVideo;
end