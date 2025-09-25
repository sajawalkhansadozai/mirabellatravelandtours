// lib/pages/home/sections/services_preview_section.dart
import 'package:flutter/material.dart';

class ServicesPreviewSection extends StatelessWidget {
  const ServicesPreviewSection({super.key});

  // Brand colors (aqua → emerald) to match the hero/about sections
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    const services = [
      (
        '✈️',
        'International Flights',
        'Access to 500+ airlines worldwide with competitive rates and multi-city expertise.',
      ),
      (
        '🏨',
        'Luxury Accommodations',
        'Boutique to 5-star stays with premium partners across the globe.',
      ),
      (
        '🚌',
        'Premium Transportation',
        'Private transfers, luxury coaches, and first-class train bookings.',
      ),
      (
        '🗺️',
        'Bespoke Itineraries',
        'Exclusive access to hidden gems and authentic local experiences.',
      ),
      (
        '📋',
        'Comprehensive Insurance',
        'Coverage for medical, cancellations, luggage and 24/7 assistance.',
      ),
      (
        '🌍',
        'Visa & Documentation',
        'Complete visa processing, passport renewals, and verification.',
      ),
    ];

    return Container(
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const _SectionTitle(
                title: 'Our Premium Services',
                subtitle:
                    'Comprehensive travel solutions to make your journey seamless',
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  // Responsive column count with safe breakpoints
                  final maxW = c.maxWidth;
                  final columns = maxW >= 1100
                      ? 3
                      : maxW >= 740
                      ? 2
                      : 1;

                  const gap = 20.0;
                  // Calculate ideal tile width and clamp it to stay readable on huge/small screens.
                  final available = maxW - gap * (columns - 1);
                  final rawTileW = available / columns;
                  final tileW = columns == 1
                      ? maxW // single column: use full width
                      : rawTileW.clamp(260.0, 420.0);

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: services
                        .map(
                          (s) => SizedBox(
                            width: tileW,
                            child: _ServiceCard(
                              icon: s.$1,
                              title: s.$2,
                              text: s.$3,
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
// Local helpers for this section
// -----------------------------
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});
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
            color: const Color(0xFF333333),
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
              color: const Color(0xFF666666),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  final String icon;
  final String title;
  final String text;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()
          ..translate(0.0, _hovered ? -4.0 : 0.0, 0.0),
        child: Card(
          elevation: 6,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.black.withOpacity(0.04)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // let height wrap content
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_brandCyan, _brandEmerald],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.icon,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4B5563),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
