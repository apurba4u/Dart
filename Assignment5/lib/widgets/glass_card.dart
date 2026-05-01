import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = AppConstants.defaultPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: AppConstants.glassBackground,
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            border: Border.all(
              color: AppConstants.glassBorder,
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
