import 'dart:ui';

import 'package:digit_recognition_canvas_mobile_app/canvas/models/digit.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/models/digit_prediction_details.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img_lib;

/// Class allowing use of TFLite model, for predicting drawn digit from an [Image].
/// After using the classifier, the interpreter needs to be closed. Therefore be sure to close it.
///
/// Example use:
/// ```dart
/// const classifier = await DigitClassifier.create();
/// const predictionDetails = classifier.classify(image);
/// classifier.close();
/// ```
class DigitClassifier {
  DigitClassifier._create({
    required this.interpreter,
    required this.labels,
  });

  static Future<DigitClassifier> create() async {
    final interpreter = await Interpreter.fromAsset(_modelFileName);
    final labels = Digit.values.map((digit) => digit.toString()).toList();
    final classifier = DigitClassifier._create(
      interpreter: interpreter,
      labels: labels,
    );
    return classifier;
  }

  static const _modelFileName = 'model/digit_classification.tflite';

  final Interpreter interpreter;
  final List<String> labels;

  Future<DigitPredictionDetails> classify(Image image) async {
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final libImg = img_lib.decodeImage(byteData!.buffer.asUint8List().toList());
    final resizedImg = img_lib.copyResize(
      libImg!,
      width: 28,
      height: 28,
      interpolation: img_lib.Interpolation.average,
    );

    List<List<double>> input = [];
    List<double> tempYPixels = [];
    for (int y = 0; y < resizedImg.height; y++) {
      for (int x = 0; x < resizedImg.width; x++) {
        final pixel = resizedImg.getPixel(x, y);
        final string = pixel.toRadixString(16);
        final oneChannel = string.substring(6);
        final val = int.parse(oneChannel, radix: 16);
        final scaledDownVal = val / 255;
        tempYPixels.add(scaledDownVal);
      }
      input.add(List.of(tempYPixels));
      tempYPixels.clear();
    }

    final output = List.filled(10, 0).reshape([1, 10]);

    interpreter.run(input, output);

    final result = output[0] as List<double>;
    final sortedList = List.of(result)..sort();
    final predictionProbability = sortedList[sortedList.length - 1];
    final secondHighestPredictionProbability =
        sortedList[sortedList.length - 2];
    final predictedDigit = result.indexOf(predictionProbability).toDigit();
    final secondMostProbable =
        result.indexOf(secondHighestPredictionProbability).toDigit();
    return DigitPredictionDetails(
      digit: predictedDigit,
      secondMostProbableDigit: secondMostProbable,
      predictionProbability: predictionProbability,
      secondMostProbableDigitProbability: secondHighestPredictionProbability,
    );
  }

  void close() {
    interpreter.close();
  }
}
