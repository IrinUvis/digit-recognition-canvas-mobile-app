part of 'canvas_bloc.dart';

class CanvasState extends Equatable {
  const CanvasState({
    required this.currentlyDrawnLine,
    required this.allDrawnLines,
    required this.predictionDetails,
  });

  final DrawnLine? currentlyDrawnLine;
  final List<DrawnLine> allDrawnLines;
  final PredictionDetails? predictionDetails;

  @override
  List<Object?> get props => [currentlyDrawnLine, allDrawnLines, predictionDetails];
}
