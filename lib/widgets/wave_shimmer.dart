import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class WaveShimmer extends StatelessWidget {
  const WaveShimmer({
    required this.height,
    super.key,
    this.width,
    this.duration,
    this.baseColor,
    this.highlightColor,
    this.radius,
    this.padding,
    this.isEnglish = true,
  });

  final double height;
  final double? width;
  final Duration? duration;
  final Color? baseColor;
  final Color? highlightColor;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final bool isEnglish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: Shimmer.fromColors(
          direction: isEnglish ? ShimmerDirection.ltr : ShimmerDirection.rtl,
          period: duration ?? const Duration(seconds: 1),
          baseColor: baseColor ?? context.grey50,
          highlightColor: highlightColor ?? context.grey100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
            ),
          ),
        ),
      ),
    );
  }
}
