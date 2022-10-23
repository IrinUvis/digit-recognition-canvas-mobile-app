import 'package:equatable/equatable.dart';

import 'digit.dart';

class DigitPredictionDetails extends Equatable {
  const DigitPredictionDetails({
    required this.digit,
    required this.secondMostProbableDigit,
    required this.predictionProbability,
    required this.secondMostProbableDigitProbability,
  });

  final Digit digit;
  final Digit secondMostProbableDigit;
  final double predictionProbability;
  final double secondMostProbableDigitProbability;

  @override
  List<Object?> get props => [digit];
}
