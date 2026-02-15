import 'package:flutter/material.dart';

import 'app_palette.dart';

sealed class AppTheme {
  static OutlineInputBorder _inputBorder({
    Color color = AppPalette.borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: .circular(10),
      borderSide: BorderSide(color: color, width: 3),
    );
  }

  static final ThemeData darkTheme = ThemeData.dark(useMaterial3: true)
      .copyWith(
        scaffoldBackgroundColor: AppPalette.backgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const .all(27),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(color: AppPalette.gradient2),
          errorBorder: _inputBorder(color: AppPalette.errorColor),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPalette.backgroundColor,
        ),
      );
}
