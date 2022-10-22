part of 'canvas_bloc.dart';

abstract class CanvasEvent extends Equatable {
  const CanvasEvent();

  @override
  List<Object?> get props => [];
}

class CanvasDrawingStarted extends CanvasEvent {
  const CanvasDrawingStarted({
    required this.firstPoint,
  });

  final Offset firstPoint;

  @override
  List<Object?> get props => [firstPoint];
}

class CanvasDrawingInProgress extends CanvasEvent {
  const CanvasDrawingInProgress({
    required this.newPoint,
  });

  final Offset newPoint;

  @override
  List<Object?> get props => [newPoint];
}

class CanvasDrawingFinished extends CanvasEvent {
  const CanvasDrawingFinished();
}

class CanvasCleared extends CanvasEvent {
  const CanvasCleared();
}

class CanvasDrawingChecked extends CanvasEvent {
  const CanvasDrawingChecked();
}
