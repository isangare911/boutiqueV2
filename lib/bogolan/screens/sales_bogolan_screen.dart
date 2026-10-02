import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';
import '../widgets/bogolan_background.dart';
import '../widgets/bogolan_empty_state.dart';
import '../widgets/bogolan_icon.dart';
import '../widgets/glass_card.dart';

class SalesBogolanScreen extends StatelessWidget {
  const SalesBogolanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BogolanBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BogolanEmptyState(
                iconAsset: BogolanIcons.cart,
                title: 'Aucune vente',
                subtitle:
                    'Appuyez sur le bouton + pour enregistrer votre première vente.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          // Icône bogolan
          Container(
            width: 44,
            height: 44,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: BogolanColors.ivory,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: BogolanColors.ochre.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: BogolanColors.greenBogolan.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BogolanIcon(
              asset: BogolanIcons.cart,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Ventes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: BogolanColors.greenBogolan,
                letterSpacing: -0.5,
              ),
            ),
          ),
          // Bouton filtre
          GlassCard(
            padding: EdgeInsets.zero,
            radius: 20,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Aujourd\'hui',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: BogolanColors.black,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: BogolanColors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
