import 'package:flutter/material.dart';

import '../models/digit_prediction_details.dart';

/// Widget displaying details of prediction in scrollable manner if it is needed.
class PredictionDetailsSummary extends StatelessWidget {
  const PredictionDetailsSummary({
    Key? key,
    this.predictionDetails,
  }) : super(key: key);

  final DigitPredictionDetails? predictionDetails;

  @override
  Widget build(BuildContext context) {
    if (predictionDetails != null) {
      return Column(
        children: [
          Text(
            'Prediction summary:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ListView(
              children: [
                Text(
                  'Predicted digit:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Digit: ${predictionDetails!.digit.toString()}',
                ),
                Text(
                  'Probability: ${(predictionDetails!.predictionProbability * 100).toStringAsFixed(2)}%',
                ),
                Text(
                  'Second most probable digit:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Digit: ${predictionDetails!.secondMostProbableDigit.toString()}',
                ),
                Text(
                  'Probability: ${(predictionDetails!.secondMostProbableDigitProbability * 100).toStringAsFixed(2)}%',
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
