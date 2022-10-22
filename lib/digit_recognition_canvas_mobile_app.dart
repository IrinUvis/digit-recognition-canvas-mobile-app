import 'package:digit_recognition_canvas_mobile_app/canvas/views/canvas_page.dart';
import 'package:digit_recognition_canvas_mobile_app/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitRecognitionCanvasMobileApp extends StatelessWidget {
  const DigitRecognitionCanvasMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Setup edge to edge experience.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      title: 'Digit recognition canvas mobile app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const CanvasPage(),
    );
  }
}
