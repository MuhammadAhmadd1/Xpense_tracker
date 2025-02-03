import 'package:flutter/material.dart';
import 'package:xtrack/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

var kDarkscheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(MaterialApp(
    //darkMode
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkscheme,
      //cardTheme
      cardTheme: CardTheme().copyWith(
        color: kDarkscheme.secondaryContainer,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      //elevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkscheme.primaryContainer,
          foregroundColor: kDarkscheme.onPrimaryContainer,
        ),
      ),
      //text theme
    ),
    //lightMode
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      //app bar
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryFixedVariant,
        foregroundColor: kColorScheme.surfaceBright,
      ),
      //card
      cardTheme: CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      //elevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),
    ),
    home: Expenses(),
  ));
}
