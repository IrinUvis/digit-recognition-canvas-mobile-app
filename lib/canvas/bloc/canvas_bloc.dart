import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/drawn_line.dart';

part 'canvas_event.dart';

part 'canvas_state.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  CanvasBloc()
      : super(
          const CanvasState(
            currentlyDrawnLine: null,
            allDrawnLines: [],
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
      CanvasState(currentlyDrawnLine: null, allDrawnLines: allDrawnLines),
    );
  }

  void _onCanvasCleared(
    CanvasCleared event,
    Emitter<CanvasState> emit,
  ) {
    emit(
      const CanvasState(currentlyDrawnLine: null, allDrawnLines: []),
    );
  }

  void _onCanvasDrawingChecked(
    CanvasDrawingChecked event,
    Emitter<CanvasState> emit,
  ) {}
}
