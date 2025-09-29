import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5B9FBF)),
  useMaterial3: true,
  fontFamily: 'Rubik',
  appBarTheme: const AppBarTheme(centerTitle: true),
  cardTheme: CardThemeData(elevation: 0.1),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Rubik',
  useMaterial3: true,
  primarySwatch: Constants.primaryColor,
  // cardColor: Constants.darkColor,
  colorScheme: const ColorScheme.dark(primary: Colors.green),
  appBarTheme: const AppBarTheme(centerTitle: true),
  scaffoldBackgroundColor: Color(0xFF121212),
  cardTheme: CardThemeData(color: Colors.grey[850], elevation: 0.1),
);
