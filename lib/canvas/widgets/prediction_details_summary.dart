import 'package:flutter/material.dart';

import '../models/prediction_details.dart';

class PredictionDetailsSummary extends StatelessWidget {
  const PredictionDetailsSummary({
    Key? key,
    this.predictionDetails,
  }) : super(key: key);

  final PredictionDetails? predictionDetails;

  @override
  Widget build(BuildContext context) {
    if (predictionDetails != null) {
      return Column(
        children: [
          Text(
            'Prediction summary:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Predicted digit: ${predictionDetails!.digit.toString()}',
          ),
          Text(
            'Second most probable digit: ${predictionDetails!.digit.toString()}',
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
