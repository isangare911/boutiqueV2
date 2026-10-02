import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════
/// BOGOLAN CORNER IMAGE — Motif bogolan dans les coins
/// ═══════════════════════════════════════════════════════════
class BogolanCornerImage extends StatelessWidget {
  final double size;
  final double opacity;
  final bool flipHorizontal;
  final bool flipVertical;
  final double? rotate;

  const BogolanCornerImage({
    super.key,
    this.size = 60,
    this.opacity = 1.0,
    this.flipHorizontal = false,
    this.flipVertical = false,
    this.rotate,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/images/bogolan_corner.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      opacity: AlwaysStoppedAnimation(opacity),
      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
    );

    // Flip horizontal
    if (flipHorizontal) {
      image = Transform.flip(flipX: true, child: image);
    }

    // Flip vertical
    if (flipVertical) {
      image = Transform.flip(flipY: true, child: image);
    }

    // Rotation optionnelle
    if (rotate != null) {
      image = Transform.rotate(angle: rotate!, child: image);
    }

    return image;
  }
}

/// ═══════════════════════════════════════════════════════════
/// BOGOLAN SIDE STRIP — Bande latérale bogolan
/// ═══════════════════════════════════════════════════════════
class BogolanSideStrip extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;

  const BogolanSideStrip({
    super.key,
    this.width = 30,
    this.height = 200,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Image.asset(
          'assets/images/bogolan_corner.png',
          width: width,
          fit: BoxFit.fitWidth,
          opacity: AlwaysStoppedAnimation(opacity),
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
