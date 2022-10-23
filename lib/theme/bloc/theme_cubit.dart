import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

/// Cubit for management of [ThemeState].
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required Brightness initialBrightness,
  }) : super(ThemeState(brightness: initialBrightness));

  void toggleTheme() {
    final brightness = state.brightness;
    emit(
      ThemeState(
        brightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
