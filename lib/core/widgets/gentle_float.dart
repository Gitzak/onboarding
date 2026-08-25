import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Adds a tiny looping drift around the child's original center.
class GentleFloat extends StatefulWidget {
  const GentleFloat({
    required this.child,
    this.duration = const Duration(milliseconds: 5400),
    this.phase = 0,
    this.horizontalDistance = 4,
    this.verticalDistance = 5,
    this.rotation = 0.012,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final double phase;
  final double horizontalDistance;
  final double verticalDistance;
  final double rotation;

  @override
  State<GentleFloat> createState() => _GentleFloatState();
}

class _GentleFloatState extends State<GentleFloat>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          final angle = (_controller.value * math.pi * 2) + widget.phase;
          final dx = math.sin(angle) * widget.horizontalDistance;
          final dy = math.sin((angle * 2) + 0.7) * widget.verticalDistance;
          final tilt = math.sin(angle + 1.1) * widget.rotation;

          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.rotate(angle: tilt, child: child),
          );
        },
      ),
    );
  }
}
