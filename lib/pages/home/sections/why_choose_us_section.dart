// lib/pages/home/sections/why_choose_us_section.dart
import 'package:flutter/material.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const features = [
      (
        '🏆',
        'Award-Winning Service',
        'Recognized with industry-leading customer satisfaction.',
      ),
      (
        '🌍',
        'Global Network',
        '500+ suppliers for the best rates and authentic access.',
      ),
      (
        '👨‍💼',
        'Expert Consultants',
        'Certified specialists averaging 10+ years of experience.',
      ),
      (
        '🔒',
        'Financial Protection',
        'ATOL/ABTA-style peace of mind for bookings.',
      ),
      (
        '📱',
        '24/7 Support',
        'Round-the-clock assistance and real-time updates.',
      ),
      (
        '💚',
        'Sustainable Tourism',
        'Responsible practices supporting communities & nature.',
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 16),
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const _LightSectionTitle(
                title: 'Why Choose Mirabella Travel?',
                subtitle: '15 years of excellence in unforgettable experiences',
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final maxW = c.maxWidth;
                  // Responsive column count
                  final columns = maxW >= 1100
                      ? 3
                      : maxW >= 740
                      ? 2
                      : 1;

                  const gap = 20.0;
                  final available = maxW - gap * (columns - 1);
                  final rawCardW = available / columns;

                  // Keep cards readable and prevent edge-case overflow
                  final cardW = columns == 1
                      ? maxW
                      : rawCardW.clamp(260.0, 420.0);

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: features
                        .map(
                          (f) => SizedBox(
                            width: cardW,
                            child: _FeatureCard(
                              icon: f.$1,
                              title: f.$2,
                              text: f.$3,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------
// Local helpers (scoped to this section)
// -----------------------------
class _LightSectionTitle extends StatelessWidget {
  const _LightSectionTitle({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF4A5568),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.text,
  });
  final String icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title: $text',
      container: true,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min, // wrap to content height
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(icon, style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF2D3748),
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF4A5568),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
