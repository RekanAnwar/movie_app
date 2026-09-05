import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ColorScheme get _colorScheme => Theme.of(this).colorScheme;

  bool get isDark => _colorScheme.brightness == Brightness.dark;

  Color get grey10 => _colorScheme.inverseSurface.withValues(alpha: 0.01);
  Color get grey20 => _colorScheme.inverseSurface.withValues(alpha: 0.02);
  Color get grey30 => _colorScheme.inverseSurface.withValues(alpha: 0.03);
  Color get grey40 => _colorScheme.inverseSurface.withValues(alpha: 0.04);
  Color get grey50 => _colorScheme.inverseSurface.withValues(alpha: 0.05);

  Color get grey100 => _colorScheme.inverseSurface.withValues(alpha: 0.1);
  Color get grey200 => _colorScheme.inverseSurface.withValues(alpha: 0.2);
  Color get grey300 => _colorScheme.inverseSurface.withValues(alpha: 0.3);
  Color get grey400 => _colorScheme.inverseSurface.withValues(alpha: 0.4);
  Color get grey500 => _colorScheme.inverseSurface.withValues(alpha: 0.5);
  Color get grey600 => _colorScheme.inverseSurface.withValues(alpha: 0.6);
  Color get grey700 => _colorScheme.inverseSurface.withValues(alpha: 0.7);
  Color get grey800 => _colorScheme.inverseSurface.withValues(alpha: 0.8);
  Color get grey900 => _colorScheme.inverseSurface.withValues(alpha: 0.9);

  Color get primary100 => _colorScheme.primary.withValues(alpha: 0.1);
  Color get primary200 => _colorScheme.primary.withValues(alpha: 0.2);
  Color get primary300 => _colorScheme.primary.withValues(alpha: 0.3);
  Color get primary400 => _colorScheme.primary.withValues(alpha: 0.4);
  Color get primary500 => _colorScheme.primary.withValues(alpha: 0.5);
  Color get primary600 => _colorScheme.primary.withValues(alpha: 0.6);
  Color get primary700 => _colorScheme.primary.withValues(alpha: 0.7);
  Color get primary800 => _colorScheme.primary.withValues(alpha: 0.8);
  Color get primary900 => _colorScheme.primary.withValues(alpha: 0.9);

  Color get secondary100 => _colorScheme.secondary.withValues(alpha: 0.1);
  Color get secondary200 => _colorScheme.secondary.withValues(alpha: 0.2);
  Color get secondary300 => _colorScheme.secondary.withValues(alpha: 0.3);
  Color get secondary400 => _colorScheme.secondary.withValues(alpha: 0.4);
  Color get secondary500 => _colorScheme.secondary.withValues(alpha: 0.5);
  Color get secondary600 => _colorScheme.secondary.withValues(alpha: 0.6);
  Color get secondary700 => _colorScheme.secondary.withValues(alpha: 0.7);
  Color get secondary800 => _colorScheme.secondary.withValues(alpha: 0.8);
  Color get secondary900 => _colorScheme.secondary.withValues(alpha: 0.9);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get viewInsetsTop => mediaQuery.viewInsets.top;
  // HACK: check these, do you need them?
  // double get viewInsetsBottom => mediaQuery.viewInsets.bottom;
  // double get viewInsetsLeft => mediaQuery.viewInsets.left;
  // double get viewInsetsRight => mediaQuery.viewInsets.right;

  double get paddingLeft => mediaQuery.padding.left;
  double get paddingRight => mediaQuery.padding.right;
}
