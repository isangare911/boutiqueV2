import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/services/auth_service.dart';
import '../../../data/repositories/credit_repository.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/sale_repository.dart';
import '../theme/bogolan_theme.dart';
import '../widgets/bogolan_background.dart';
import '../widgets/bogolan_chart.dart';
import '../widgets/bogolan_icon.dart';
import '../widgets/bogolan_pattern.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_quick_action.dart';
import '../widgets/glass_stat_card.dart';
import '../widgets/neon_signature_text.dart';
import 'credits_bogolan_screen.dart';
import 'sales_bogolan_screen.dart';
import 'stock_bogolan_screen.dart';

class DashboardBogolanScreen extends StatefulWidget {
  const DashboardBogolanScreen({super.key});

  @override
  State<DashboardBogolanScreen> createState() => _DashboardBogolanScreenState();
}

class _DashboardBogolanScreenState extends State<DashboardBogolanScreen> {
  final _saleRepo = SaleRepository();
  final _productRepo = ProductRepository();
  final _creditRepo = CreditRepository();
  final _customerRepo = CustomerRepository();

  double _revenue = 0;
  double _profit = 0;
  int _salesCount = 0;
  int _productCount = 0;
  int _creditCount = 0;
  int _customerCount = 0;
  int _lowStockCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final revenue = await _saleRepo.getTodayRevenue();
      final profit = await _saleRepo.getTodayProfit();
      final salesCount = await _saleRepo.getTodaySalesCount();
      final productCount = await _productRepo.getTotalProducts();
      final lowStock = await _productRepo.getOutOfStockCount();
      final credits = await _creditRepo.getAllCredits();
      final customers = await _customerRepo.getAllCustomers();

      if (!mounted) return;
      setState(() {
        _revenue = revenue;
        _profit = profit;
        _salesCount = salesCount;
        _productCount = productCount;
        _lowStockCount = lowStock;
        _creditCount = credits.length;
        _customerCount = customers.length;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getOwnerName() {
    final user = AuthService.instance.user;
    final firstName = user?['first_name'] as String? ?? '';
    final lastName = user?['last_name'] as String? ?? '';
    final full = '$firstName $lastName'.trim();
    if (full.isNotEmpty) return full.split(' ').first;
    return user?['shop']?['name'] as String? ?? 'Boutique';
  }

  String _formatAmount(double amount) {
    if (amount == 0) return '0';
    final s = amount.toStringAsFixed(0);
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(' ');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BogolanBackground(
      child: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: BogolanColors.greenBogolan,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // ⚡ Padding réduit (80 → 70)
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 6),
                _buildGreeting(),
                const SizedBox(height: 8),
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(
                        color: BogolanColors.greenBogolan,
                      ),
                    ),
                  )
                else ...[
                  _buildRevenueCard(),
                  const SizedBox(height: 8),
                  _buildKpiGrid(),
                  const SizedBox(height: 8),
                  _buildAlertBanner(),
                  const SizedBox(height: 8),
                  _buildQuickActionsHeader(),
                  const SizedBox(height: 6),
                  _buildQuickActions(),
                  const SizedBox(height: 8),
                  _buildFooterBanner(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // HEADER
  // ═══════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Row(
      children: [
        const BogolanLogo(size: 38),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'MA BOUTIQUE',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: BogolanColors.greenBogolan,
              letterSpacing: 0.4,
            ),
          ),
        ),
        GlassIconButton(
          icon: Icons.notifications_outlined,
          onTap: () {},
          hasBadge: _lowStockCount > 0,
          size: 36,
        ),
        const SizedBox(width: 6),
        GlassIconButton(
          icon: Icons.person_outline_rounded,
          onTap: () {},
          size: 36,
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  // ═══════════════════════════════════════════════════════════
  // GREETING
  // ═══════════════════════════════════════════════════════════
  Widget _buildGreeting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bonjour, ${_getOwnerName()} 👋',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: BogolanColors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Voici le résumé de votre boutique',
                style: TextStyle(
                  fontSize: 11,
                  color: BogolanColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const NeonSignatureText(),
      ],
    )
        .animate(delay: 200.ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.1, end: 0);
  }

  // ═══════════════════════════════════════════════════════════
  // REVENUE CARD
  // ═══════════════════════════════════════════════════════════
  Widget _buildRevenueCard() {
    final chartData = <double>[
      _revenue * 0.45,
      _revenue * 0.60,
      _revenue * 0.55,
      _revenue * 0.72,
      _revenue > 0 ? _revenue : 100.0,
      _revenue * 0.85,
      _revenue * 0.78,
    ];
    const labels = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

    return Stack(
      children: [
        GlassCard(
          // ⚡ Padding réduit (14 → 12)
          padding: const EdgeInsets.all(12),
          radius: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      gradient: BogolanGradients.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.trending_up_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      "Chiffre d'affaires",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: BogolanColors.textSecondary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: BogolanColors.textSecondary.withOpacity(0.15),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          '7j',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: BogolanColors.black,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 11,
                          color: BogolanColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Montant
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _formatAmount(_revenue),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: BogolanColors.black,
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'FCFA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: BogolanColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),

              // Tendance + Bénéfice
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward_rounded,
                    size: 11,
                    color: BogolanColors.success,
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    '+12,8 %',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: BogolanColors.success,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'vs hier',
                    style: TextStyle(
                      fontSize: 10,
                      color: BogolanColors.textSecondary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: BogolanColors.greenBogolan.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Bénéfice : ${_formatAmount(_profit)} F',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: BogolanColors.greenBogolan,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ⚡ Graphique avec height augmentée (90 → 105)
              // pour que les labels du bas ne soient plus coupés
              BogolanChart(
                data: chartData,
                labels: labels,
                highlightedIndex: 4,
                height: 105,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          width: 26,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            child: Image.asset(
              'assets/images/bogolan_corner.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              opacity: const AlwaysStoppedAnimation(0.35),
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    )
        .animate(delay: 300.ms)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.1, end: 0);
  }

  // ═══════════════════════════════════════════════════════════
  // KPI GRID
  // ═══════════════════════════════════════════════════════════
  Widget _buildKpiGrid() {
    return Row(
      children: [
        Expanded(
          child: GlassStatCard(
            label: 'Ventes',
            value: '$_salesCount',
            iconAsset: BogolanIcons.cart,
            iconGradient: BogolanGradients.green,
            trend: '+18%',
            isPositive: true,
            compact: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesBogolanScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GlassStatCard(
            label: 'Stock',
            value: '$_productCount',
            iconAsset: BogolanIcons.box,
            iconGradient: BogolanGradients.terracotta,
            trend: '-5%',
            isPositive: false,
            compact: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StockBogolanScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GlassStatCard(
            label: 'Crédits',
            value: '$_creditCount',
            iconAsset: BogolanIcons.credit,
            iconGradient: BogolanGradients.ochre,
            trend: '+2%',
            isPositive: true,
            compact: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreditsBogolanScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GlassStatCard(
            label: 'Clients',
            value: '$_customerCount',
            iconAsset: BogolanIcons.user,
            iconGradient: BogolanGradients.green,
            trend: '+6%',
            isPositive: true,
            compact: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Écran Clients — Bientôt disponible'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ],
    ).animate(delay: 500.ms).fadeIn(duration: 500.ms);
  }

  // ═══════════════════════════════════════════════════════════
  // ALERT BANNER
  // ═══════════════════════════════════════════════════════════
  Widget _buildAlertBanner() {
    if (_lowStockCount == 0) return const SizedBox.shrink();

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      radius: 14,
      tint: BogolanColors.terracottaPale,
      borderColor: BogolanColors.terracotta.withOpacity(0.3),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: BogolanGradients.alert,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.priority_high_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stock faible',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: BogolanColors.black,
                  ),
                ),
                Text(
                  '$_lowStockCount produits en dessous du seuil',
                  style: TextStyle(
                    fontSize: 10,
                    color: BogolanColors.textSecondary.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              gradient: BogolanGradients.terracotta,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: const [
                Text(
                  'Voir',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: 600.ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.1, end: 0);
  }

  // ═══════════════════════════════════════════════════════════
  // QUICK ACTIONS HEADER
  // ═══════════════════════════════════════════════════════════
  Widget _buildQuickActionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Actions rapides',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: BogolanColors.black,
            letterSpacing: -0.3,
          ),
        ),
        Row(
          children: const [
            Text(
              'Voir tout',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: BogolanColors.terracotta,
              ),
            ),
            SizedBox(width: 3),
            Icon(
              Icons.arrow_forward_rounded,
              size: 13,
              color: BogolanColors.terracotta,
            ),
          ],
        ),
      ],
    ).animate(delay: 700.ms).fadeIn(duration: 400.ms);
  }

  // ═══════════════════════════════════════════════════════════
  // QUICK ACTIONS
  // ═══════════════════════════════════════════════════════════
  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: GlassQuickAction(
            label: 'Nouvelle\nvente',
            icon: HugeIcons.strokeRoundedShoppingCart01,
            iconGradient: BogolanGradients.green,
            onTap: () {},
            compact: true,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GlassQuickAction(
            label: 'Ajouter\nproduit',
            icon: HugeIcons.strokeRoundedPackage,
            iconGradient: BogolanGradients.terracotta,
            onTap: () {},
            compact: true,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GlassQuickAction(
            label: 'Crédit\nclient',
            icon: HugeIcons.strokeRoundedUserAdd01,
            iconGradient: BogolanGradients.green,
            onTap: () {},
            compact: true,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GlassQuickAction(
            label: 'Rapport',
            icon: HugeIcons.strokeRoundedAnalytics01,
            iconGradient: BogolanGradients.ochre,
            onTap: () {},
            compact: true,
          ),
        ),
      ],
    ).animate(delay: 800.ms).fadeIn(duration: 500.ms);
  }

  // ═══════════════════════════════════════════════════════════
  // FOOTER BANNER
  // ═══════════════════════════════════════════════════════════
  Widget _buildFooterBanner() {
    return GlassCard(
      padding: EdgeInsets.zero,
      radius: 14,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: BogolanGradients.terracotta,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Avancez plus loin',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: BogolanColors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Gérez votre boutique en toute sérénité',
                  style: TextStyle(
                    fontSize: 10,
                    color: BogolanColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: BogolanGradients.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: BogolanColors.greenBogolan.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    )
        .animate(delay: 900.ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
