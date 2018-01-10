# Gaze Tracker

Gaze Tracker is an application to detect in real time the location of the gaze of a person and later move the cursor of the computer in the corresponding direction.

<p align="center">
  <img src="https://im2.ezgif.com/tmp/ezgif-2-d75da614ba.gif" alt="Gif of the application working" width="300">
</p>

### Features

- Turn on gaze detection
- Turn off gaze detection
- Adjust the speed of the cursor
- Indication of the center of the pupil
- Indication of the center of the gaze
- Thresholding of the gaze

### Development

This application makes use of:
- [Viola-Jones](https://www.mathworks.com/help/vision/ref/vision.cascadeobjectdetector-system-object.html) algorithm to detect the eyes of the person
- [Hough Transform](https://www.mathworks.com/help/images/ref/imfindcircles.html) to detect the pupil using an snapshot of the detected eye
- [Java Robot class](https://docs.oracle.com/javase/7/docs/api/java/awt/Robot.html) to move the cursor outside of the Matlab application

### Installation

Clone this repo inside your Matlab directory and open the project with Matlab
```sh
$ git clone https://github.com/warborn/gaze-tracker.git
```

#### Requirements
- Matlab USB Webcam package
- Matlab Computer Vision System Toolbox