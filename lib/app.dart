import 'package:digit_recognition_canvas_mobile_app/canvas/views/canvas_page.dart';
import 'package:digit_recognition_canvas_mobile_app/theme/bloc/theme_cubit.dart';
import 'package:digit_recognition_canvas_mobile_app/theme/color_scheme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DigitRecognitionCanvasMobileApp extends StatelessWidget {
  const DigitRecognitionCanvasMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final brightness = state.brightness;

          // Setup edge to edge experience.
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
              statusBarIconBrightness: brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
            ),
          );

          return MaterialApp(
            title: 'Digit recognition canvas mobile app',
            debugShowCheckedModeBanner: false,
            themeMode: brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
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
        },
      ),
    );
  }
}
