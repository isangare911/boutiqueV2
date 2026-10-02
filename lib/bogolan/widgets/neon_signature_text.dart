import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/bogolan_theme.dart';

// ═══════════════════════════════════════════════════════════
// NEON SIGNATURE TEXT — Version réduite
// ═══════════════════════════════════════════════════════════
class NeonSignatureText extends StatelessWidget {
  const NeonSignatureText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      child: Transform.rotate(
        angle: -15 * math.pi / 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSignatureLine(
              text: 'Ensemble',
              fontSize: 18,
              delay: 0,
            ),
            const SizedBox(height: 0),
            _buildSignatureLine(
              text: 'pour une Afrique',
              fontSize: 16,
              delay: 200,
            ),
            const SizedBox(height: 0),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildSignatureLine(
                  text: 'digitale',
                  fontSize: 18,
                  delay: 400,
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    width: 45,
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x00B85C32),
                          Color(0xFFB85C32),
                          Color(0xFFB85C32),
                          Color(0x00B85C32),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )
                      .animate(delay: 600.ms)
                      .fadeIn(duration: 400.ms)
                      .scaleX(begin: 0.3, end: 1.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureLine({
    required String text,
    required double fontSize,
    required int delay,
  }) {
    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      effects: [
        FadeEffect(
          duration: 1500.ms,
          begin: 0.65,
          end: 1.0,
          curve: Curves.easeInOut,
        ),
      ],
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'GreatVibes',
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: BogolanColors.terracotta,
          height: 1.0,
          letterSpacing: 0.2,
          shadows: [
            // ⚡ Ombres plus légères
            Shadow(
              color: BogolanColors.terracotta.withOpacity(0.3),
              blurRadius: 5,
            ),
            Shadow(
              color: BogolanColors.terracotta.withOpacity(0.15),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    )
        .animate(delay: delay.ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, end: 0);
  }
}
