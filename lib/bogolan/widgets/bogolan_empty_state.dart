import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';
import 'bogolan_icon.dart';

/// ═══════════════════════════════════════════════════════════
/// BOGOLAN EMPTY STATE — État vide stylisé bogolan
/// ═══════════════════════════════════════════════════════════
class BogolanEmptyState extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const BogolanEmptyState({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône bogolan dans un cercle
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BogolanColors.ivory,
                shape: BoxShape.circle,
                border: Border.all(
                  color: BogolanColors.ochre.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: BogolanColors.greenBogolan.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: BogolanIcon(
                asset: iconAsset,
                size: 80,
              ),
            ),
            const SizedBox(height: 24),

            // Titre
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: BogolanColors.greenBogolan,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),

            // Sous-titre
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: BogolanColors.textSecondary,
                height: 1.4,
              ),
            ),

            // Bouton d'action
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BogolanColors.greenBogolan,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                  shadowColor: BogolanColors.greenBogolan.withOpacity(0.3),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
