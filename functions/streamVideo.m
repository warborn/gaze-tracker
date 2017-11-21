function streamVideo(videoStream, resolution, hObject)
  handles = guidata(ancestor(hObject, 'figure') );
  hImage = image(zeros(resolution(1), resolution(2)), 'Parent', handles.webcamAxes);
  callback = formatVideo(hObject);
  setappdata(hImage, 'UpdatePreviewWindowFcn', callback);
  preview(videoStream, hImage);
end

function func = formatVideo(hObject)
  function prepareVideo(obj, event, himage)
    handles = guidata(ancestor(hObject, 'figure') );
    handles.speed
    % Rotate frame
    frame = flip(event.Data, 2);
    % Crop frame
    frame = frame(:, 80:560, :);
    % Place a mark arround each detected eye
    [markedImage, bbox, center] = locateEyes(frame);
    % Transmit image
    set(himage, 'cdata', markedImage);

    % Check if there was an eye on the image
    if ~isempty(bbox) && ~isempty(center) && ~hasDirection(bbox, center, 'center')
      makeMouseMovement(bbox, center, handles)
    % else
    %   outside = outside + 1;
    %   strcat('outside', string(outside))
    end
  end
  func = @prepareVideo;
end