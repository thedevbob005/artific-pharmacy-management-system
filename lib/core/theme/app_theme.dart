import 'package:fluent_ui/fluent_ui.dart';

class AppTheme {
  const AppTheme._();

  static final light = FluentThemeData(
    brightness: Brightness.light,
    accentColor: Colors.teal,
  );

  static final dark = FluentThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.teal,
  );
}
