import 'dart:ui';

import 'package:digit_recognition_canvas_mobile_app/canvas/models/digit.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/models/prediction_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../models/drawn_line.dart';

part 'canvas_event.dart';

part 'canvas_state.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  CanvasBloc()
      : super(
          const CanvasState(
            currentlyDrawnLine: null,
            allDrawnLines: [],
            predictionDetails: null,
          ),
        ) {
    on<CanvasDrawingStarted>(_onDrawingStarted);
    on<CanvasDrawingInProgress>(_onDrawingNextPoint);
    on<CanvasDrawingFinished>(_onDrawingFinished);
    on<CanvasCleared>(_onCanvasCleared);
    on<CanvasDrawingChecked>(_onCanvasDrawingChecked);
  }

  void _onDrawingStarted(
    CanvasDrawingStarted event,
    Emitter<CanvasState> emit,
  ) {
    final line = DrawnLine(path: [event.firstPoint]);
    emit(
      CanvasState(
        currentlyDrawnLine: line,
        allDrawnLines: state.allDrawnLines,
        predictionDetails: state.predictionDetails,
      ),
    );
  }

  void _onDrawingNextPoint(
    CanvasDrawingInProgress event,
    Emitter<CanvasState> emit,
  ) {
    final path = List.of(state.currentlyDrawnLine!.path)..add(event.newPoint);
    emit(
      CanvasState(
        currentlyDrawnLine: DrawnLine(path: path),
        allDrawnLines: state.allDrawnLines,
        predictionDetails: state.predictionDetails,
      ),
    );
  }

  void _onDrawingFinished(
    CanvasDrawingFinished event,
    Emitter<CanvasState> emit,
  ) {
    final allDrawnLines = List.of(state.allDrawnLines);
    allDrawnLines.add(state.currentlyDrawnLine!);
    emit(
      CanvasState(
        currentlyDrawnLine: null,
        allDrawnLines: allDrawnLines,
        predictionDetails: state.predictionDetails,
      ),
    );
  }

  void _onCanvasCleared(
    CanvasCleared event,
    Emitter<CanvasState> emit,
  ) {
    emit(
      const CanvasState(
        currentlyDrawnLine: null,
        allDrawnLines: [],
        predictionDetails: null,
      ),
    );
  }

  Future<void> _onCanvasDrawingChecked(
    CanvasDrawingChecked event,
    Emitter<CanvasState> emit,
  ) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final lines = state.allDrawnLines;
    final strokeWidth = event.strokeWidth;
    final canvasSize = event.canvasSize.toInt();

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawColor(Colors.white, BlendMode.src);

    for (int i = 0; i < lines.length; ++i) {
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(canvasSize, canvasSize);

    // Now we scale the image to 28x28
    const outputImageSize = 28;

    final scalingRecorder = PictureRecorder();
    final scalingCanvas = Canvas(scalingRecorder);
    paintImage(
      canvas: scalingCanvas,
      rect: Rect.fromLTWH(
        0,
        0,
        outputImageSize.toDouble(),
        outputImageSize.toDouble(),
      ),
      image: image,
      fit: BoxFit.scaleDown,
      filterQuality: FilterQuality.high,
    );
    final scaledPicture = scalingRecorder.endRecording();
    final scaledImage =
        await scaledPicture.toImage(outputImageSize, outputImageSize);
    final byteData = await scaledImage.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    await ImageGallerySaver.saveImage(
      pngBytes,
      quality: 100,
      name: DateTime.now().toIso8601String(),
      isReturnImagePathOfIOS: true,
    );

    // TODO: use .tflite model
    emit(
      CanvasState(
        currentlyDrawnLine: state.currentlyDrawnLine,
        allDrawnLines: state.allDrawnLines,
        predictionDetails: PredictionDetails(digit: Digit.seven),
      ),
    );
  }
}
