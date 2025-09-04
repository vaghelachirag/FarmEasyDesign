import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  const ShimmerWidget({
    required this.height,
    required this.width,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness;
    return Shimmer.fromColors(
      baseColor:
          theme == Brightness.light
              ? AppColors.white
              : AppColors.darkScaffoldColor,
      highlightColor:
          theme == Brightness.light
              ? AppColors.slateGray
              : AppColors.darkGray,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
      ),
    );
  }
}
