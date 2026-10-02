import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';
import '../widgets/bogolan_icon.dart';
import '../widgets/bubble_effect.dart';
import 'dashboard_bogolan_screen.dart';

class MainNavigationBogolanScreen extends StatefulWidget {
  const MainNavigationBogolanScreen({super.key});

  @override
  State<MainNavigationBogolanScreen> createState() =>
      _MainNavigationBogolanScreenState();
}

class _MainNavigationBogolanScreenState
    extends State<MainNavigationBogolanScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;

  final List<Widget> _screens = const [
    DashboardBogolanScreen(),
    _PlaceholderScreen(label: 'Ventes'),
    _PlaceholderScreen(label: 'Stock'),
    _PlaceholderScreen(label: 'Crédits'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: BogolanColors.ivory,
      // ⚡ Container ivoire derrière le PageView (pas de flash noir)
      body: Container(
        color: BogolanColors.ivory,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _screens
              .map((screen) => _KeepAliveWrapper(child: screen))
              .toList(),
        ),
      ),
      bottomNavigationBar: _buildBogolanNavBar(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ═══════════════════════════════════════════════════════════
  // BOTTOM NAV avec effet bulle
  // ═══════════════════════════════════════════════════════════
  Widget _buildBogolanNavBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      height: 78,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(39),
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: BogolanColors.greenBogolan.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(39),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                label: 'Accueil',
                iconAsset: BogolanIcons.home,
              ),
              _buildNavItem(
                index: 1,
                label: 'Ventes',
                iconAsset: BogolanIcons.cart,
              ),
              const SizedBox(width: 66),
              _buildNavItem(
                index: 2,
                label: 'Stock',
                iconAsset: BogolanIcons.box,
              ),
              _buildNavItem(
                index: 3,
                label: 'Crédits',
                iconAsset: BogolanIcons.credit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String iconAsset,
  }) {
    final isSelected = _currentIndex == index;
    return SizedBox(
      width: 64,
      // ⚡ Effet bulle liquide
      child: BubbleEffect(
        bubbleColor:
            isSelected ? BogolanColors.greenBogolan : BogolanColors.ochre,
        maxRadius: 42,
        duration: const Duration(milliseconds: 800),
        onTap: () => _onNavTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.20 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: BogolanIcon(asset: iconAsset, size: 32),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? BogolanColors.greenBogolan
                    : BogolanColors.textSecondary,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isSelected ? 20 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: BogolanColors.greenBogolan,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // FAB CENTRAL avec effet bulle
  // ═══════════════════════════════════════════════════════════
  Widget _buildFAB() {
    return Transform.translate(
      offset: const Offset(0, -3),
      // ⚡ Effet bulle sur le FAB aussi
      child: BubbleEffect(
        bubbleColor: BogolanColors.ochre,
        maxRadius: 60,
        duration: const Duration(milliseconds: 800),
        onTap: _showQuickMenu,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: BogolanColors.greenBogolan.withOpacity(0.45),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: BogolanColors.ochre.withOpacity(0.35),
                blurRadius: 16,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Image.asset(
            BogolanIcons.addButton,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              decoration: BoxDecoration(
                gradient: BogolanGradients.green,
                shape: BoxShape.circle,
                border: Border.all(color: BogolanColors.ochre, width: 3),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // MENU ACTION RAPIDE
  // ═══════════════════════════════════════════════════════════
  void _showQuickMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: BogolanColors.ivory,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: BogolanColors.ochre.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: BogolanColors.greenBogolan.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: BogolanColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nouvelle action',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: BogolanColors.greenBogolan,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuAction(
                  icon: BogolanIcons.cart,
                  label: 'Vente',
                  onTap: () => Navigator.pop(context),
                ),
                _buildMenuAction(
                  icon: BogolanIcons.box,
                  label: 'Produit',
                  onTap: () => Navigator.pop(context),
                ),
                _buildMenuAction(
                  icon: BogolanIcons.user,
                  label: 'Client',
                  onTap: () => Navigator.pop(context),
                ),
                _buildMenuAction(
                  icon: BogolanIcons.credit,
                  label: 'Crédit',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuAction({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: BogolanColors.greenBogolan.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              icon,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: BogolanColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// KEEP ALIVE WRAPPER — Garde l'état des écrans
// ═══════════════════════════════════════════════════════════
class _KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const _KeepAliveWrapper({required this.child});

  @override
  State<_KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<_KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

// ═══════════════════════════════════════════════════════════
// ÉCRAN PLACEHOLDER
// ═══════════════════════════════════════════════════════════
class _PlaceholderScreen extends StatelessWidget {
  final String label;

  const _PlaceholderScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BogolanColors.ivory,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: BogolanColors.greenBogolan,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Écran à venir',
              style: TextStyle(color: BogolanColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
