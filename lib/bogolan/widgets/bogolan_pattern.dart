import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';

// ═══════════════════════════════════════════════════════════
// PETIT MOTIF BOGOLAN DANS UN COIN DE CARTE
// ═══════════════════════════════════════════════════════════
class BogolanCornerMotif extends StatelessWidget {
  final double size;
  final Color color;
  final bool mirrored;

  const BogolanCornerMotif({
    super.key,
    this.size = 40,
    this.color = BogolanColors.terracotta,
    this.mirrored = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CornerMotifPainter(
        color: color.withOpacity(0.35),
        mirrored: mirrored,
      ),
    );
  }
}

class _CornerMotifPainter extends CustomPainter {
  final Color color;
  final bool mirrored;

  _CornerMotifPainter({required this.color, required this.mirrored});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    if (mirrored) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Petit carré plein
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * 0.5, size.height * 0.5),
      paint,
    );

    // Carré en stroke
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.15,
        size.height * 0.15,
        size.width * 0.5,
        size.height * 0.5,
      ),
      strokePaint,
    );

    // Losanges déco
    for (int i = 0; i < 3; i++) {
      final x = size.width * 0.6 + i * 8;
      final diamond = Path()
        ..moveTo(x, size.height * 0.2)
        ..lineTo(x + 4, size.height * 0.3)
        ..lineTo(x, size.height * 0.4)
        ..lineTo(x - 4, size.height * 0.3)
        ..close();
      canvas.drawPath(diamond, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════
// LOSANGE BOGOLAN (pour les icônes)
// ═══════════════════════════════════════════════════════════
class BogolanDiamond extends StatelessWidget {
  final Widget child;
  final double size;
  final Gradient gradient;

  const BogolanDiamond({
    super.key,
    required this.child,
    this.size = 46,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Diamant principal
          Transform.rotate(
            angle: 0.785398, // 45°
            child: Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
          // Icône par-dessus
          child,
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// LOGO BOGOLAN STYLISÉ (pour le header)
// ═══════════════════════════════════════════════════════════
class BogolanLogo extends StatelessWidget {
  final double size;

  const BogolanLogo({super.key, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: BogolanColors.ivory,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: BogolanColors.greenBogolan,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: BogolanColors.greenBogolan.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _LogoBogolanPainter(),
      ),
    );
  }
}

class _LogoBogolanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final green = Paint()
      ..color = BogolanColors.greenBogolan
      ..style = PaintingStyle.fill;

    final terracotta = Paint()
      ..color = BogolanColors.terracotta
      ..style = PaintingStyle.fill;

    final ochre = Paint()
      ..color = BogolanColors.ochre
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Formes géométriques bogolan stylisées
    // Carré vert gauche
    canvas.drawRect(
        Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.35, h * 0.7), green);
    // Barre terracotta
    canvas.drawRect(
        Rect.fromLTWH(w * 0.5, h * 0.15, w * 0.15, h * 0.7), terracotta);
    // Carré ochre
    canvas.drawRect(Rect.fromLTWH(w * 0.65, h * 0.35, w * 0.2, h * 0.3), ochre);
    // Petits carrés déco
    canvas.drawRect(
        Rect.fromLTWH(w * 0.2, h * 0.25, w * 0.08, h * 0.08), ochre);
    canvas.drawRect(
        Rect.fromLTWH(w * 0.35, h * 0.65, w * 0.08, h * 0.08), terracotta);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════
// MOTIF ARRIÈRE-PLAN POUR LES KPI CARDS
// ═══════════════════════════════════════════════════════════
class BogolanCardBackground extends StatelessWidget {
  final double size;

  const BogolanCardBackground({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CardBackgroundPainter(),
    );
  }
}

class _CardBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ochre = Paint()
      ..color = BogolanColors.ochre.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final terracotta = Paint()
      ..color = BogolanColors.terracotta.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    final green = Paint()
      ..color = BogolanColors.greenBogolan.withOpacity(0.10)
      ..style = PaintingStyle.fill;

    // Motif en bas à droite
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.75, size.height * 0.75, 8, 8),
      ochre,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.85, size.height * 0.65, 6, 6),
      terracotta,
    );

    // Losanges
    for (int i = 0; i < 3; i++) {
      final x = size.width * 0.55 + i * 7;
      final y = size.height * 0.85;
      canvas.drawPath(
        Path()
          ..moveTo(x, y - 4)
          ..lineTo(x + 3, y)
          ..lineTo(x, y + 4)
          ..lineTo(x - 3, y)
          ..close(),
        green,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
