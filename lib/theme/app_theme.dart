import 'package:fluent_ui/fluent_ui.dart';

class AppTheme {
  static const Color primary = ColorTheme.orange;

  static final ThemeData lightTheme = ThemeData.light().copyWith(

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(

  );
}

class ColorTheme {
  static const Color red = Color.fromRGBO(255, 0, 0, 1);
  static const Color green = Color.fromRGBO(0, 255, 0, 1);
  static const Color blue = Color.fromRGBO(0, 0, 255, 1);

  static const Color darkBlue = Color.fromRGBO(0, 120, 215, 1);
  static const Color swamp = Color.fromRGBO(0, 131, 140, 1);
  static const Color darkPink = Color.fromRGBO(227, 0, 140, 1);
  static const Color orange = Color.fromRGBO(202, 79, 7, 1);
  static const Color darkRed = Color.fromRGBO(232, 17, 35, 1);
  static const Color darkGreen = Color.fromRGBO(16, 137, 62, 1);
  static const Color purple = Color.fromRGBO(136, 23, 152, 1);
  static const Color lightPink = Color.fromRGBO(194, 57, 179, 1);
}