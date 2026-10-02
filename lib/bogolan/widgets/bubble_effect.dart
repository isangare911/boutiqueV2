import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';

// ═══════════════════════════════════════════════════════════
// BUBBLE EFFECT — Effet bulle liquide au tap
// Version sombre et discrète
// ═══════════════════════════════════════════════════════════
class BubbleEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color bubbleColor;
  final double maxRadius;
  final Duration duration;

  const BubbleEffect({
    super.key,
    required this.child,
    this.onTap,
    this.bubbleColor = BogolanColors.greenBogolan,
    this.maxRadius = 60,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  State<BubbleEffect> createState() => _BubbleEffectState();
}

class _BubbleEffectState extends State<BubbleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ValueNotifier<Offset?> _originNotifier = ValueNotifier<Offset?>(null);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _originNotifier.value = null;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _originNotifier.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _originNotifier.value = details.localPosition;
  }

  void _handleTap() {
    if (_originNotifier.value == null) return;
    _controller.forward(from: 0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: ValueListenableBuilder<Offset?>(
                valueListenable: _originNotifier,
                builder: (context, origin, _) {
                  if (origin == null) return const SizedBox.shrink();
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      if (_controller.value == 0) {
                        return const SizedBox.shrink();
                      }
                      return CustomPaint(
                        painter: _BubblePainter(
                          progress: _controller.value,
                          origin: origin,
                          color: widget.bubbleColor,
                          maxRadius: widget.maxRadius,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// PAINTER — Bulle sombre et discrète
// ═══════════════════════════════════════════════════════════
class _BubblePainter extends CustomPainter {
  final double progress;
  final Offset origin;
  final Color color;
  final double maxRadius;

  _BubblePainter({
    required this.progress,
    required this.origin,
    required this.color,
    required this.maxRadius,
  });

  /// ⚡ Assombrit une couleur (multiplie la luminosité par 0.6)
  Color _darken(Color c, [double factor = 0.6]) {
    return Color.fromARGB(
      c.alpha,
      (c.red * factor).round(),
      (c.green * factor).round(),
      (c.blue * factor).round(),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final easedProgress = Curves.easeOutCubic.transform(progress);
    final radius = maxRadius * easedProgress;

    // Opacité : monte vite puis descend, max 0.30 (discret)
    final opacity = progress < 0.4
        ? (progress / 0.4) * 0.30
        : (1.0 - ((progress - 0.4) / 0.6)) * 0.30;

    // ⚡ Couleur assombrie
    final darkColor = _darken(color, 0.7);

    // 1. Halo extérieur très subtil
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          darkColor.withOpacity(0.0),
          darkColor.withOpacity(0.06 * (opacity / 0.3)),
          darkColor.withOpacity(0.12 * (opacity / 0.3)),
          darkColor.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromCircle(center: origin, radius: radius * 1.3));

    canvas.drawCircle(origin, radius * 1.3, haloPaint);

    // 2. Cercle principal très discret
    final mainPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          darkColor.withOpacity(0.22 * (opacity / 0.3)),
          darkColor.withOpacity(0.12 * (opacity / 0.3)),
          darkColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: origin, radius: radius));

    canvas.drawCircle(origin, radius, mainPaint);

    // 3. Bord fin et discret (plus sombre)
    final borderPaint = Paint()
      ..color = darkColor.withOpacity(0.28 * (opacity / 0.3))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawCircle(origin, radius * 0.92, borderPaint);

    // 4. Reflet blanc très discret (0.15 max)
    if (radius > 6) {
      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(0.15 * (opacity / 0.3))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(
          origin.dx - radius * 0.25,
          origin.dy - radius * 0.25,
        ),
        radius * 0.12,
        highlightPaint,
      );
    }

    // 5. Bulles satellites (2, très discrètes)
    final random = math.Random(42);
    for (int i = 0; i < 2; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = radius * (0.7 + random.nextDouble() * 0.4);
      final smallBubble = Offset(
        origin.dx + math.cos(angle) * distance,
        origin.dy + math.sin(angle) * distance,
      );
      final smallRadius = radius * (0.08 + random.nextDouble() * 0.08);

      final smallPaint = Paint()
        ..color = darkColor.withOpacity(0.18 * (opacity / 0.3))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(smallBubble, smallRadius, smallPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BubblePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
