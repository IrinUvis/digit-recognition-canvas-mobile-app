import 'dart:ui';

import 'package:digit_recognition_canvas_mobile_app/canvas/models/digit_prediction_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tflite/classifiers/digit_classifier.dart';
import '../models/drawn_line.dart';

part 'canvas_event.dart';

part 'canvas_state.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  CanvasBloc()
      : super(
          const CanvasState(
            currentlyDrawnLine: null,
            allDrawnLines: [],
            digitPredictionDetails: null,
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
        digitPredictionDetails: state.digitPredictionDetails,
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
        digitPredictionDetails: state.digitPredictionDetails,
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
        digitPredictionDetails: state.digitPredictionDetails,
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
        digitPredictionDetails: null,
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

    canvas.drawColor(Colors.black, BlendMode.src);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < lines.length; ++i) {
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(canvasSize, canvasSize);
    final classifier = await DigitClassifier.create();
    final digitPredictionDetails = await classifier.classify(image);
    classifier.close();

    emit(
      CanvasState(
        currentlyDrawnLine: state.currentlyDrawnLine,
        allDrawnLines: state.allDrawnLines,
        digitPredictionDetails: digitPredictionDetails,
      ),
    );
  }
}
