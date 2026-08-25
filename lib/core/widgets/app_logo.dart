import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    this.size = 40,
    this.withShadow = false,
    this.darkVersion = false,
    super.key,
  });

  final double size;
  final bool withShadow;
  final bool darkVersion;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * (darkVersion ? 0.08 : 0.2)),
      decoration: BoxDecoration(
        color: darkVersion ? AppColors.splashSurface : AppColors.primary,
        shape: darkVersion ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: darkVersion ? null : BorderRadius.circular(size * 0.3),
        border: darkVersion
            ? Border.all(color: const Color(0xFF253248), width: 1)
            : null,
        boxShadow: withShadow
            ? const [
                BoxShadow(
                  color: Color(0x446EE7B7),
                  blurRadius: 30,
                  offset: Offset(0, 12),
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: SvgPicture.asset(
        darkVersion
            ? 'assets/images/voltway_icon.svg'
            : 'assets/images/charge_logo.svg',
      ),
    );
  }
}
