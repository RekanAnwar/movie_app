import 'package:flutter/material.dart';

class MaterialTheme {
  const MaterialTheme(this.textTheme);

  final TextTheme textTheme;

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff855300),
      surfaceTint: Color(0xff855300),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff59e0b),
      onPrimaryContainer: Color(0xff613b00),
      secondary: Color(0xff904d00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffe932c),
      onSecondaryContainer: Color(0xff663500),
      tertiary: Color(0xff505f76),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa2b2cb),
      onTertiaryContainer: Color(0xff35455a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff131b2e),
      onSurfaceVariant: Color(0xff534434),
      outline: Color(0xff867461),
      outlineVariant: Color(0xffd8c3ad),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff283044),
      inversePrimary: Color(0xffffb95f),
      primaryFixed: Color(0xffffddb8),
      onPrimaryFixed: Color(0xff2a1700),
      primaryFixedDim: Color(0xffffb95f),
      onPrimaryFixedVariant: Color(0xff653e00),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff2f1500),
      secondaryFixedDim: Color(0xffffb77d),
      onSecondaryFixedVariant: Color(0xff6e3900),
      tertiaryFixed: Color(0xffd3e4fe),
      onTertiaryFixed: Color(0xff0b1c30),
      tertiaryFixedDim: Color(0xffb7c8e1),
      onTertiaryFixedVariant: Color(0xff38485d),
      surfaceDim: Color(0xffd2d9f4),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3ff),
      surfaceContainer: Color(0xfff1f5f9),
      surfaceContainerHigh: Color(0xffe2e7ff),
      surfaceContainerHighest: Color(0xffdae2fd),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffc174),
      surfaceTint: Color(0xffffb95f),
      onPrimary: Color(0xff472a00),
      primaryContainer: Color(0xfff59e0b),
      onPrimaryContainer: Color(0xff613b00),
      secondary: Color(0xffffb77d),
      onSecondary: Color(0xff4d2600),
      secondaryContainer: Color(0xffd97707),
      onSecondaryContainer: Color(0xff432100),
      tertiary: Color(0xffc4cce3),
      onTertiary: Color(0xff283042),
      tertiaryContainer: Color(0xffa8b1c7),
      onTertiaryContainer: Color(0xff3b4456),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f131d),
      onSurface: Color(0xffdfe2f1),
      onSurfaceVariant: Color(0xffd8c3ad),
      outline: Color(0xffa08e7a),
      outlineVariant: Color(0xff534434),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe2f1),
      inversePrimary: Color(0xff855300),
      primaryFixed: Color(0xffffddb8),
      onPrimaryFixed: Color(0xff2a1700),
      primaryFixedDim: Color(0xffffb95f),
      onPrimaryFixedVariant: Color(0xff653e00),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff2f1500),
      secondaryFixedDim: Color(0xffffb77d),
      onSecondaryFixedVariant: Color(0xff6e3900),
      tertiaryFixed: Color(0xffdae2fa),
      onTertiaryFixed: Color(0xff121c2c),
      tertiaryFixedDim: Color(0xffbec6dd),
      onTertiaryFixedVariant: Color(0xff3e475a),
      surfaceDim: Color(0xff0f131d),
      surfaceBright: Color(0xff353944),
      surfaceContainerLowest: Color(0xff0a0e18),
      surfaceContainerLow: Color(0xff171b26),
      surfaceContainer: Color(0xff1c1f2a),
      surfaceContainerHigh: Color(0xff262a35),
      surfaceContainerHighest: Color(0xff313540),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    appBarTheme: AppBarThemeData(
      scrolledUnderElevation: 0,
      backgroundColor: colorScheme.surface,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 48),
        foregroundColor: colorScheme.onPrimaryFixed,
        backgroundColor: colorScheme.primaryContainer,
        textStyle: textTheme.titleLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );
}
