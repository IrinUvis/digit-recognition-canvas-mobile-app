part of 'canvas_bloc.dart';

class CanvasState extends Equatable {
  const CanvasState({
    required this.currentlyDrawnLine,
    required this.allDrawnLines,
    required this.digitPredictionDetails,
  });

  final DrawnLine? currentlyDrawnLine;
  final List<DrawnLine> allDrawnLines;
  final DigitPredictionDetails? digitPredictionDetails;

  @override
  List<Object?> get props => [currentlyDrawnLine, allDrawnLines, digitPredictionDetails];
}
