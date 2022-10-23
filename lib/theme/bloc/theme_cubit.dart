import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(brightness: Brightness.light));

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
