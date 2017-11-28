% streamVideo: Function that starts the webcam preview
%   params:
%     videoStream: reference to a video object
%     resolution: array containing the width and height of the resolution 
%       in the form of: [width, height]
%     hObject: reference to the hObject coming from the main UI
function streamVideo(videoStream, resolution, hObject)
  % Get a reference to the handles object
  % this reference will be used to update the GUI inside the functions called by the
  % formatVideo function
  handles = guidata(ancestor(hObject, 'figure') );
  % Create an empty image that will be used to show the video stream
  % this will show the video over the webcam axes on the GUI
  hImage = image(zeros(resolution(1), resolution(2)), 'Parent', handles.webcamAxes);
  % Get a callback function (function handle) that will be called
  % for every frame of the video stream
  callback = formatVideo(hObject);
  % Indicate the callback needs to be called every time the frame (image) changes
  setappdata(hImage, 'UpdatePreviewWindowFcn', callback);
  % Preview the video stream over the empty image
  preview(videoStream, hImage);
end