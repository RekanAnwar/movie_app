import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

extension AsyncValueExtension<T> on AsyncValue<T> {
  Widget whenAnimated({
    required Widget? Function(T data) data,
    required Widget Function() loading,
    required Widget Function(Object error, StackTrace stackTrace) error,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
    bool isSliver = false,
    Duration duration = const Duration(milliseconds: 350),
    Duration? reverseDuration,
    Curve switchInCurve = Curves.linear,
    Curve switchOutCurve = Curves.linear,
    AnimatedSwitcherTransitionBuilder transitionBuilder =
        AnimatedSwitcher.defaultTransitionBuilder,
    AnimatedSwitcherLayoutBuilder? layoutBuilder,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
  }) {
    bool skip;
    if (isRefreshing) {
      skip = skipLoadingOnRefresh;
    } else if (isReloading) {
      skip = skipLoadingOnReload;
    } else {
      skip = false;
    }

    final shouldShowLoading = !skip && isLoading;

    if (shouldShowLoading) {
      final child = loading();

      if (isSliver) {
        return SliverAnimatedSwitcher(
          duration: duration,
          reverseDuration: reverseDuration,
          switchInCurve: switchInCurve,
          switchOutCurve: switchOutCurve,
          child: child,
        );
      }
      return AnimatedSwitcher(
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        transitionBuilder: transitionBuilder,
        layoutBuilder:
            layoutBuilder ??
            (currentChild, previousChildren) => Stack(
              alignment: alignment,
              children: [
                ...previousChildren,
                ?currentChild,
              ],
            ),
        child: child,
      );
    }

    if (hasError && (!hasValue || !skipError)) {
      return error(this.error!, stackTrace!);
    }

    final child = data(requireValue);

    if (isSliver) {
      return SliverAnimatedSwitcher(
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        child: child ?? const SliverToBoxAdapter(),
      );
    }

    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: transitionBuilder,
      layoutBuilder:
          layoutBuilder ??
          (currentChild, previousChildren) => Stack(
            alignment: alignment,
            children: [
              ...previousChildren,
              ?currentChild,
            ],
          ),
      child: child,
    );
  }
}
