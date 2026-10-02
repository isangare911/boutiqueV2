import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════
// PALETTE BOGOLAN MODERNE
// ═══════════════════════════════════════════════════════════
class BogolanColors {
  BogolanColors._();

  // Fonds
  static const Color ivory = Color(0xFFF8F5ED); // Fond principal
  static const Color ivoryLight = Color(0xFFFCFAF5); // Fond clair
  static const Color glass = Color(0x8CFFFFFF); // 55% blanc

  // Verts
  static const Color greenBogolan = Color(0xFF123F32); // Vert profond
  static const Color greenDark = Color(0xFF0D2E24); // Plus foncé
  static const Color greenLight = Color(0xFFDDEFE4); // Vert clair

  // Terre
  static const Color terracotta = Color(0xFFB85C32); // Terracotta
  static const Color terracottaLight = Color(0xFFD57A52);
  static const Color terracottaPale = Color(0xFFF5DDD0);

  // Or
  static const Color ochre = Color(0xFFD59A32); // Ocre / Or
  static const Color ochreLight = Color(0xFFE5B54A);
  static const Color ochrePale = Color(0xFFF5E6C8);

  // Noir & Texte
  static const Color black = Color(0xFF18201D);
  static const Color textSecondary = Color(0xFF68716C);
  static const Color textLight = Color(0xFF9CA3A0);

  // Statuts
  static const Color alert = Color(0xFFD95F3F);
  static const Color alertPale = Color(0xFFFDEEE9);
  static const Color success = Color(0xFF2E7D32);
  static const Color successPale = Color(0xFFE8F5E9);
  static const Color white = Color(0xFFFFFFFF);
}

// ═══════════════════════════════════════════════════════════
// GRADIENTS
// ═══════════════════════════════════════════════════════════
class BogolanGradients {
  BogolanGradients._();

  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFCFAF5), Color(0xFFF8F5ED), Color(0xFFF2EBDC)],
  );

  static const LinearGradient glass = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xE6FFFFFF), Color(0xB8FFFFFF)],
  );

  static const LinearGradient green = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF123F32), Color(0xFF1A5A48)],
  );

  static const LinearGradient terracotta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB85C32), Color(0xFFD57A52)],
  );

  static const LinearGradient ochre = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD59A32), Color(0xFFE5B54A)],
  );

  static const LinearGradient alert = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD95F3F), Color(0xFFE77C5E)],
  );

  static const LinearGradient chartArea = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x99123F32), Color(0x00123F32)],
  );
}

// ═══════════════════════════════════════════════════════════
// STYLES
// ═══════════════════════════════════════════════════════════
class BogolanStyles {
  BogolanStyles._();

  static BoxDecoration glassCard({
    double radius = 20,
    Color? borderColor,
    double borderWidth = 1.2,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      gradient: BogolanGradients.glass,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor ?? Colors.white.withOpacity(0.75),
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: (shadowColor ?? BogolanColors.greenBogolan).withOpacity(0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.6),
          blurRadius: 4,
          offset: const Offset(0, -1),
        ),
      ],
    );
  }

  static const TextStyle appTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: BogolanColors.greenBogolan,
    letterSpacing: -0.5,
  );

  static const TextStyle appSubtitle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: BogolanColors.ochre,
    letterSpacing: 3,
  );

  static const TextStyle greeting = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: BogolanColors.black,
    letterSpacing: -0.5,
  );

  static const TextStyle greetingSub = TextStyle(
    fontSize: 14,
    color: BogolanColors.textSecondary,
  );

  static const TextStyle cursive = TextStyle(
    fontSize: 13,
    fontStyle: FontStyle.italic,
    color: BogolanColors.terracotta,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle cardLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: BogolanColors.textSecondary,
  );

  static const TextStyle bigAmount = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w900,
    color: BogolanColors.black,
    letterSpacing: -1.5,
  );

  static const TextStyle bigAmountCurrency = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: BogolanColors.black,
  );

  static const TextStyle greenTrend = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: BogolanColors.success,
  );

  static const TextStyle redTrend = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: BogolanColors.alert,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: BogolanColors.black,
    letterSpacing: -0.3,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: BogolanColors.terracotta,
  );
}
