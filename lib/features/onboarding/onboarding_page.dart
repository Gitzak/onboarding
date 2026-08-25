import 'package:flutter/material.dart';

import 'onboarding_data.dart';
import 'widgets/onboarding_visuals.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({required this.data, required this.isActive, super.key});

  final OnboardingData data;
  final bool isActive;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
    );
    if (widget.isActive) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visualAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.72, curve: Curves.easeOutCubic),
    );
    final copyAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 1, curve: Curves.easeOutCubic),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: AnimatedBuilder(
              animation: visualAnimation,
              child: OnboardingVisual(type: widget.data.visualType),
              builder: (context, child) => Opacity(
                opacity: visualAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, 22 * (1 - visualAnimation.value)),
                  child: Transform.scale(
                    scale: 0.96 + (0.04 * visualAnimation.value),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: copyAnimation,
            builder: (context, child) => Opacity(
              opacity: copyAnimation.value,
              child: Transform.translate(
                offset: Offset(0, 14 * (1 - copyAnimation.value)),
                child: child,
              ),
            ),
            child: Column(
              children: [
                Text(
                  widget.data.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: MediaQuery.sizeOf(context).height < 700 ? 24 : 28,
                  ),
                ),
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Text(
                    widget.data.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: MediaQuery.sizeOf(context).height < 700
                          ? 13
                          : 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
