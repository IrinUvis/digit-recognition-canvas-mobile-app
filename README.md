# Digit recognition canvas mobile app

A canvas app, that classifies the drawings as digits using the pre-trained model.
The mobile app allows to draw on a square canvas, and if prompted to classify the drawing as one of the digits.
For this purpose a pre-trained model will be used, which I have trained using Google Colaboratory [notebook](https://colab.research.google.com/drive/1H0VFjxyzi7F1tKkkQH1V6MySd66fphsW?usp=sharing).

The program is made as a project for Artificial Intelligence class, which is a part of my bachelor studies.

## Before running

Before running additional setup needs to be made, due to usage of [tflite_flutter](https://pub.dev/packages/tflite_flutter) plugin.
Execute `sh install.sh` (Linux) / `install.bat` (Windows) at the root of your project to automatically download and place binaries at appropriate folders.
These scripts install pre-built binaries based on latest stable tensorflow release. 

## How it works

![App demo](readme/app_recording.gif)