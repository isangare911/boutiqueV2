import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';

class BogolanBackground extends StatelessWidget {
  final Widget child;
  final bool showTopCorners;
  final bool showSideStripes;

  const BogolanBackground({
    super.key,
    required this.child,
    this.showTopCorners = true,
    this.showSideStripes = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: BogolanGradients.background,
          ),
        ),
        if (showTopCorners)
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: const Size(140, 140),
              painter: _CornerMotifPainter(
                primary: BogolanColors.terracotta.withOpacity(0.12),
                accent: BogolanColors.ochre.withOpacity(0.10),
                mirrored: false,
              ),
            ),
          ),
        if (showTopCorners)
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(140, 140),
              painter: _CornerMotifPainter(
                primary: BogolanColors.ochre.withOpacity(0.12),
                accent: BogolanColors.terracotta.withOpacity(0.10),
                mirrored: true,
              ),
            ),
          ),
        if (showSideStripes)
          Positioned(
            top: 300,
            right: 0,
            child: CustomPaint(
              size: const Size(30, 350),
              painter: _SideStripePainter(
                color: BogolanColors.ochre.withOpacity(0.08),
              ),
            ),
          ),
        child,
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// PAINTER — Motif de coin
// ═══════════════════════════════════════════════════════════
class _CornerMotifPainter extends CustomPainter {
  final Color primary;
  final Color accent;
  final bool mirrored;

  _CornerMotifPainter({
    required this.primary,
    required this.accent,
    required this.mirrored,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    if (mirrored) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    final fill = Paint()
      ..color = primary
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Grand carré
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(80, 0)
        ..lineTo(80, 80)
        ..lineTo(0, 80)
        ..close(),
      fill,
    );

    // Carré moyen (stroke)
    canvas.drawPath(
      Path()
        ..moveTo(18, 18)
        ..lineTo(62, 18)
        ..lineTo(62, 62)
        ..lineTo(18, 62)
        ..close(),
      stroke,
    );

    // Petit carré central
    canvas.drawPath(
      Path()
        ..moveTo(32, 32)
        ..lineTo(48, 32)
        ..lineTo(48, 48)
        ..lineTo(32, 48)
        ..close(),
      fill,
    );

    // Zigzag
    final zig = Path()..moveTo(0, 95);
    for (int i = 0; i < 5; i++) {
      zig.lineTo(i * 18.0 + 9, 105);
      zig.lineTo(i * 18.0 + 18, 95);
    }
    canvas.drawPath(zig, stroke);

    // Losanges
    for (int i = 0; i < 3; i++) {
      final x = 100.0 + i * 12;
      canvas.drawPath(
        Path()
          ..moveTo(x, 90)
          ..lineTo(x + 5, 100)
          ..lineTo(x, 110)
          ..lineTo(x - 5, 100)
          ..close(),
        fill,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════
// PAINTER — Bande latérale
// ═══════════════════════════════════════════════════════════
class _SideStripePainter extends CustomPainter {
  final Color color;

  _SideStripePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      final y = i * 30.0;
      canvas.drawPath(
        Path()
          ..moveTo(15, y + 4)
          ..lineTo(22, y + 12)
          ..lineTo(15, y + 20)
          ..lineTo(8, y + 12)
          ..close(),
        paint,
      );
      canvas.drawRect(Rect.fromLTWH(0, y + 22, 30, 1.5), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
