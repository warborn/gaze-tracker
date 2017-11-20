function streamVideo(videoStream, resolution, output)
  hImage = image(zeros(resolution(1), resolution(2)), 'Parent', output);
  setappdata(hImage, 'UpdatePreviewWindowFcn', @format_video);
  preview(videoStream, hImage);

function format_video(obj, event, himage)
  % Rotate frame
  frame = flip(event.Data, 2);
  % Crop frame
  frame = frame(:, 80:560, :);
  % Place a mark arround each detected eye
  frame = locateEyes(frame);
  set(himage, 'cdata', frame);