% stopVideoStream: Function that stops the webcam preview
%   params:
%     videoStream: reference to a video object
function stopVideoStream(videoStream)
  % Stop the webcam preview
  stoppreview(videoStream);
  % Clear and delete references to the video object
  delete(videoStream);
  clear videoStream;