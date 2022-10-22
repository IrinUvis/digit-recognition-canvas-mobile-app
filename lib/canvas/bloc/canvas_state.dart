part of 'canvas_bloc.dart';

class CanvasState extends Equatable {
  const CanvasState({
    required this.currentlyDrawnLine,
    required this.allDrawnLines,
  });

  final DrawnLine? currentlyDrawnLine;
  final List<DrawnLine> allDrawnLines;

  @override
  List<Object?> get props => [currentlyDrawnLine, allDrawnLines];
}
