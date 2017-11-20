function streamVideo(videoStream, resolution, output)
  hImage = image(zeros(resolution(1), resolution(2)), 'Parent', output);
  setappdata(hImage, 'UpdatePreviewWindowFcn', @format_video);
  preview(videoStream, hImage);

function format_video(obj, event, himage)
    rot_image = flip(event.Data, 2);
    cut_image = rot_image(:, 80:560, :);
    set(himage, 'cdata', cut_image);