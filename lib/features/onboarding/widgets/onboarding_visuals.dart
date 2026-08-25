import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gentle_float.dart';
import '../onboarding_data.dart';

class OnboardingVisual extends StatelessWidget {
  const OnboardingVisual({required this.type, super.key});

  final OnboardingVisualType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      OnboardingVisualType.charging => const _ChargingVisual(),
      OnboardingVisualType.stations => const _StationsVisual(),
      OnboardingVisualType.features => const _FeaturesVisual(),
    };
  }
}

class _ChargingVisual extends StatelessWidget {
  const _ChargingVisual();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(constraints.maxWidth, 340.0);
        final cardWidth = width * 0.76;
        final cardHeight = math.min(constraints.maxHeight * 0.72, 205.0);

        return Center(
          child: SizedBox(
            width: width,
            height: constraints.maxHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                GentleFloat(
                  duration: const Duration(milliseconds: 6200),
                  phase: 1.4,
                  horizontalDistance: 4,
                  verticalDistance: 6,
                  rotation: 0.01,
                  child: Transform.rotate(
                    angle: -0.16,
                    child: Transform.translate(
                      offset: const Offset(-28, 8),
                      child: _BackCard(
                        width: cardWidth,
                        height: cardHeight,
                        icon: Icons.ev_station_rounded,
                        color: AppColors.softBlue,
                      ),
                    ),
                  ),
                ),
                GentleFloat(
                  duration: const Duration(milliseconds: 5400),
                  phase: 0.2,
                  horizontalDistance: 5,
                  verticalDistance: 4,
                  rotation: 0.014,
                  child: Transform.rotate(
                    angle: 0.11,
                    child: Transform.translate(
                      offset: const Offset(24, -4),
                      child: Container(
                        width: cardWidth,
                        height: cardHeight,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(
                            color: AppColors.surface,
                            width: 6,
                          ),
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x240F2940),
                              blurRadius: 24,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/auction_car.png',
                              fit: BoxFit.cover,
                            ),
                            const Positioned(
                              right: 12,
                              bottom: 12,
                              child: _LiveBadge(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BackCard extends StatelessWidget {
  const _BackCard({
    required this.width,
    required this.height,
    required this.icon,
    required this.color,
  });

  final double width;
  final double height;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: AppColors.surface, width: 6),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x160F2940),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, size: 52, color: AppColors.primaryDark),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(99),
      ),
      child: const Text(
        'AVAILABLE  •  8 PORTS',
        style: TextStyle(
          color: Color(0xFF0B1220),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _StationsVisual extends StatelessWidget {
  const _StationsVisual();

  static const stations = [
    ('Green Point', '8 ports • 4 available', 'GP', Color(0xFF6EE7B7)),
    ('City Supercharge', '12 ports • 9 available', 'CS', Color(0xFF93C5FD)),
    ('North Hub', '6 ports • 2 available', 'NH', Color(0xFFC4B5FD)),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(stations.length, (index) {
            final station = stations[index];
            return Transform.translate(
              offset: Offset(index == 1 ? 8 : -4, 0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GentleFloat(
                  duration: Duration(milliseconds: 5000 + (index * 650)),
                  phase: index * 1.7,
                  horizontalDistance: 3 + index.toDouble(),
                  verticalDistance: 4,
                  rotation: 0.006,
                  child: _StationCard(
                    name: station.$1,
                    status: station.$2,
                    initials: station.$3,
                    avatarColor: station.$4,
                    emphasized: index == 1,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  const _StationCard({
    required this.name,
    required this.status,
    required this.initials,
    required this.avatarColor,
    required this.emphasized,
  });

  final String name;
  final String status;
  final String initials;
  final Color avatarColor;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: emphasized ? Border.all(color: AppColors.primaryDark) : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x100F2940),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: avatarColor,
            child: Text(
              initials,
              style: const TextStyle(
                color: Color(0xFF0B1220),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_rounded,
                      size: 15,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  status,
                  style: const TextStyle(color: AppColors.muted, fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: emphasized ? AppColors.primary : AppColors.softBlue,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              'View',
              style: TextStyle(
                color: emphasized ? const Color(0xFF0B1220) : AppColors.ink,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesVisual extends StatelessWidget {
  const _FeaturesVisual();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.25,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final centerX = constraints.maxWidth / 2;
            final centerY = constraints.maxHeight / 2;
            return Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: _OrbitPainter())),
                Positioned(
                  left: centerX - 48,
                  top: centerY - 48,
                  child: const GentleFloat(
                    duration: Duration(milliseconds: 5600),
                    phase: 0.4,
                    horizontalDistance: 3,
                    verticalDistance: 4,
                    child: _CategoryCircle(
                      icon: Icons.route_rounded,
                      label: 'Plan',
                      size: 96,
                      dark: true,
                    ),
                  ),
                ),
                Positioned(
                  left: centerX - 126,
                  top: centerY - 90,
                  child: const GentleFloat(
                    duration: Duration(milliseconds: 6200),
                    phase: 1.2,
                    child: _CategoryCircle(
                      icon: Icons.near_me_rounded,
                      label: 'Nearby',
                    ),
                  ),
                ),
                Positioned(
                  left: centerX + 62,
                  top: centerY - 96,
                  child: const GentleFloat(
                    duration: Duration(milliseconds: 5300),
                    phase: 2.4,
                    horizontalDistance: 5,
                    verticalDistance: 3,
                    child: _CategoryCircle(
                      icon: Icons.bolt_rounded,
                      label: 'Fast',
                    ),
                  ),
                ),
                Positioned(
                  left: centerX + 74,
                  top: centerY + 34,
                  child: const GentleFloat(
                    duration: Duration(milliseconds: 6600),
                    phase: 3.7,
                    child: _CategoryCircle(
                      icon: Icons.favorite_rounded,
                      label: 'Saved',
                    ),
                  ),
                ),
                Positioned(
                  left: centerX - 125,
                  top: centerY + 42,
                  child: const GentleFloat(
                    duration: Duration(milliseconds: 5800),
                    phase: 5.1,
                    horizontalDistance: 3,
                    verticalDistance: 5,
                    child: _CategoryCircle(
                      icon: Icons.electrical_services_rounded,
                      label: 'Plugs',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCircle extends StatelessWidget {
  const _CategoryCircle({
    required this.icon,
    required this.label,
    this.size = 62,
    this.dark = false,
  });

  final IconData icon;
  final String label;
  final double size;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: dark ? AppColors.primary : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.outline, width: 4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x160F2940),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: dark ? const Color(0xFF0B1220) : AppColors.ink,
            size: size * 0.28,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: dark ? const Color(0xFF0B1220) : AppColors.muted,
              fontSize: size > 70 ? 10 : 8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.68,
        height: size.height * 0.66,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.92,
        height: size.height * 0.9,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
