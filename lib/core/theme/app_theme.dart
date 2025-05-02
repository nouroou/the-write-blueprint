import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';

class AppTheme {
  static var darkMode = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      bottomNavigationBarTheme: _bottomNavigationBarTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      appBarTheme: _appBarTheme(),
      primaryIconTheme: IconThemeData(color: AppPallete.gradient2),
      iconTheme: IconThemeData(color: AppPallete.borderColor),
      floatingActionButtonTheme: _floatingActionButtonThemeData(),
      chipTheme: _chipTheme(),
      tabBarTheme: _tabBarTheme());

  static TabBarThemeData _tabBarTheme() {
    return TabBarThemeData(
      indicatorColor: AppPallete.gradient3,
      labelColor: AppPallete.gradient3,
    );
  }

  static ChipThemeData _chipTheme() {
    return ChipThemeData(
        color: WidgetStatePropertyAll(AppPallete.backgroundColor),
        side: BorderSide.none);
  }

  static FloatingActionButtonThemeData _floatingActionButtonThemeData() =>
      FloatingActionButtonThemeData(backgroundColor: AppPallete.gradient3);

  static AppBarTheme _appBarTheme() => AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: AppPallete.gradient2),
      );

  static BottomNavigationBarThemeData _bottomNavigationBarTheme() =>
      BottomNavigationBarThemeData(
        backgroundColor: AppPallete.borderColor,
        selectedItemColor: AppPallete.gradient2,
        unselectedItemColor: AppPallete.greyColor,
      );

  static InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
        contentPadding: EdgeInsets.all(20),
        focusedBorder: _border(AppPallete.gradient2),
        enabledBorder: _border(),
        errorBorder: _border(AppPallete.errorColor),
        focusedErrorBorder: _border(),
      );

  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          color: color,
          width: 2.5,
        ),
      );
}
