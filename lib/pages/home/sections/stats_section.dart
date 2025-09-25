// lib/pages/home/sections/stats_section.dart
import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, c) {
              final maxW = c.maxWidth;
              // Responsive column count
              final columns = maxW >= 1100
                  ? 4
                  : maxW >= 820
                  ? 3
                  : maxW >= 560
                  ? 2
                  : 1;

              const gap = 16.0;
              final available = maxW - gap * (columns - 1);
              final rawTileW = available / columns;

              // Keep tiles readable and prevent overflow at extremes
              final tileW = columns == 1 ? maxW : rawTileW.clamp(220.0, 320.0);

              const stats = [
                ('5+', 'Years of Experience'),
                ('750+', 'Happy Travelers'),
                ('50+', 'Destinations Covered'),
                ('98%', 'Customer Satisfaction'),
              ];

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: stats
                    .map(
                      (s) => SizedBox(
                        width: tileW,
                        child: _StatTile(value: s.$1, label: s.$2),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$value $label',
      container: true,
      child: Column(
        mainAxisSize: MainAxisSize.min, // wrap height to content
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: const Color(0xFF2D3748),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF4A5568),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
