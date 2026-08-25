import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    required this.currentIndex,
    required this.itemCount,
    super.key,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          width: index == currentIndex ? 24 : 7,
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: index == currentIndex ? AppColors.ink : AppColors.outline,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ),
    );
  }
}
