import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
