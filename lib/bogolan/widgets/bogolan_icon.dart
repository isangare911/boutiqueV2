import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════
/// BOGOLAN ICON — Icônes personnalisées de l'application
/// ═══════════════════════════════════════════════════════════
class BogolanIcons {
  BogolanIcons._();

  // Chemins des assets
  static const String home = 'assets/icons/home.png';
  static const String cart = 'assets/icons/cart.png';
  static const String box = 'assets/icons/box.png';
  static const String user = 'assets/icons/user.png';
  static const String credit = 'assets/icons/credit.png';
  static const String addButton = 'assets/icons/add_button.png';
}

/// ═══════════════════════════════════════════════════════════
/// WIDGET : Affiche une icône bogolan
/// ═══════════════════════════════════════════════════════════
class BogolanIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? tint; // Si tu veux colorer l'icône (optionnel)
  final BoxFit fit;

  const BogolanIcon({
    super.key,
    required this.asset,
    this.size = 28,
    this.tint,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Fallback si l'image n'existe pas
        return Icon(
          Icons.image_not_supported_outlined,
          size: size,
          color: Colors.grey,
        );
      },
    );
  }
}

/// ═══════════════════════════════════════════════════════════
/// WIDGET : Icône bogolan dans un cercle (pour onglet actif)
/// ═══════════════════════════════════════════════════════════
class BogolanIconBadge extends StatelessWidget {
  final String asset;
  final double size;
  final bool isActive;
  final Color? activeBackground;

  const BogolanIconBadge({
    super.key,
    required this.asset,
    this.size = 28,
    this.isActive = false,
    this.activeBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: isActive
          ? BoxDecoration(
              color: (activeBackground ?? Colors.white).withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (activeBackground ?? Colors.white).withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            )
          : null,
      child: Center(
        child: BogolanIcon(
          asset: asset,
          size: size,
        ),
      ),
    );
  }
}
