part of 'canvas_bloc.dart';

/// Abstract Canvas event from, which all other Canvas Events should inherit.
abstract class CanvasEvent extends Equatable {
  const CanvasEvent();

  @override
  List<Object?> get props => [];
}

/// Canvas event to be called, when user starts drawing on the canvas.
class CanvasDrawingStarted extends CanvasEvent {
  const CanvasDrawingStarted({
    required this.firstPoint,
  });

  final Offset firstPoint;

  @override
  List<Object?> get props => [firstPoint];
}

/// Canvas event to be called, when user continues touching the canvas.
class CanvasDrawingInProgress extends CanvasEvent {
  const CanvasDrawingInProgress({
    required this.newPoint,
  });

  final Offset newPoint;

  @override
  List<Object?> get props => [newPoint];
}

/// Canvas event to be called, when user stops drawing on the canvas.
class CanvasDrawingFinished extends CanvasEvent {
  const CanvasDrawingFinished();
}

/// Canvas event to be called, when canvas should be cleared.
class CanvasCleared extends CanvasEvent {
  const CanvasCleared();
}

/// Canvas event to be called, in order to attempt predicting digit from canvas drawing.
class CanvasDrawingChecked extends CanvasEvent {
  const CanvasDrawingChecked({
    required this.canvasSize,
    required this.strokeWidth,
  });

  final double canvasSize;
  final double strokeWidth;
}
