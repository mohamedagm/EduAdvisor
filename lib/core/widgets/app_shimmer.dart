import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// The single shimmer treatment used by student-facing loading states.
class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      return child;
    }

    return Shimmer.fromColors(
      baseColor: baseColor ?? context.themeColors.shimmerBase,
      highlightColor: highlightColor ?? context.themeColors.shimmerHighlight,
      period: const Duration(milliseconds: 1400),
      child: child,
    );
  }
}

class AppShimmerBox extends StatelessWidget {
  const AppShimmerBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8,
    this.shape = BoxShape.rectangle,
  });

  final double? width;
  final double height;
  final double borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.themeColors.shimmerBase,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(borderRadius)
            : null,
      ),
    );
  }
}

/// Keeps remote image loading consistent with the rest of the skeleton UI.
class AppShimmerNetworkImage extends StatelessWidget {
  const AppShimmerNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.errorWidget,
  });

  final String imageUrl;
  final BoxFit fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;

        return AppShimmer(
          child: ColoredBox(color: context.themeColors.shimmerBase),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            ColoredBox(
              color: context.themeColors.mutedSurface,
              child: Center(child: Icon(Icons.image_not_supported_outlined)),
            );
      },
    );
  }
}
