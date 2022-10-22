import 'package:equatable/equatable.dart';

import 'digit.dart';

class PredictionDetails extends Equatable {
  const PredictionDetails({
    required this.digit,
  });

  final Digit digit;

  @override
  List<Object?> get props => [digit];
}
