part of 'theme_cubit.dart';

/// State object containing information about currently active [ThemeMode].
class ThemeState extends Equatable {
  const ThemeState({
    required this.brightness,
  });

  final Brightness brightness;

  @override
  List<Object?> get props => [brightness];
}
