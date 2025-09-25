// lib/pages/testimonials.dart
import 'package:flutter/material.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // (author, role, quote, rating, source)
    const testimonials = <(String, String, String, int, String)>[
      (
        'Fatima & Ahmed Khan',
        'Anniversary Travelers from Lahore',
        'Our Northern Pakistan anniversary trip was unforgettable! From Hunza\'s apricot orchards to sunset views at Eagles Nest and a private helicopter flight over the Karakoram—every detail was perfect.',
        5,
        'Google Reviews',
      ),
      (
        'Hassan Ali',
        'Adventure Enthusiast from Islamabad',
        'The K2 Base Camp approach via Skardu was life-changing. Expert local guides, safe planning, and Balti culture insights. Crossing the Baltoro and those glacier vistas… breathtaking!',
        5,
        'Google Reviews',
      ),
      (
        'Ayesha Malik',
        'Solo Traveler from Karachi',
        'I explored Naran–Kaghan and Fairy Meadows as a solo female traveler. Transparent planning, reliable drivers, and secure stays. The Saif-ul-Malook morning light and Nanga Parbat view felt magical.',
        5,
        'Google Reviews',
      ),
      (
        'Tariq & Saima Chaudhry',
        'Family of 6 from Faisalabad',
        'Perfect family loop through Swat, Kalam and Malam Jabba, then up to Hunza. Kids loved chairlifts, jeep safaris and easy meadow walks. Clean hotels, on-time transport—zero stress.',
        5,
        'Google Reviews',
      ),
      (
        'Zainab Riaz',
        'Group Traveler from Peshawar',
        'Our small group did Skardu–Shigar–Khaplu with Deosai day trips. Great pacing, culture stops, and picnic lunches at Shangrila & Kachura. A smooth, friendly experience end to end.',
        5,
        'Google Reviews',
      ),
      (
        'Omar & Hina Sheikh',
        'Honeymooners from Multan',
        'A dreamy honeymoon across Hunza, Attabad and Passu. Lake cruises, stargazing at Gulmit and candlelit dinners with mountain views. Seamless execution—felt truly special.',
        5,
        'Google Reviews',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Customer Reviews',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, _) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  children: [
                    const _EnhancedHeader(),
                    const SizedBox(height: 20),
                    _TestimonialsGrid(testimonials: testimonials),
                    const SizedBox(height: 18),
                    // Global note about source
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _GoogleBadge(small: true),
                        SizedBox(width: 8),
                        Text(
                          'All Reviews are sourced from Google.',
                          style: TextStyle(color: Color(0xFF475569)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _CallToAction(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------
// Enhanced Header
// -----------------------------
class _EnhancedHeader extends StatelessWidget {
  const _EnhancedHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          children: [
            // Star rating display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFB800),
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF0891B2)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                'Northern Pakistan Reviews',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                'Real experiences from travelers exploring Hunza, Skardu, Fairy Meadows, Naran–Kaghan, Swat and beyond.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF64748B),
                  height: 1.55,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 8,
              children: const [
                _Pill(text: '500+ Happy Pakistani Families'),
                _GoogleBadge(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF059669), Color(0xFF0891B2)],
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleBadge extends StatelessWidget {
  const _GoogleBadge({this.small = false});
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 12.0 : 14.0;
    final padV = small ? 5.0 : 7.0;
    final padH = small ? 8.0 : 10.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Simple colored "G" circle (no external assets)
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4285F4),
            ),
            alignment: Alignment.center,
            child: const Text(
              'G',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Google Reviews',
            style: TextStyle(
              fontSize: small ? 11 : 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Testimonials Grid (tight, no inner white space)
// -----------------------------
class _TestimonialsGrid extends StatelessWidget {
  const _TestimonialsGrid({required this.testimonials});

  final List<(String, String, String, int, String)> testimonials;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1200
            ? 3
            : constraints.maxWidth >= 800
            ? 2
            : 1;

        // Higher aspect => shorter card; tuned to remove inner blank space
        final aspect = columns == 1 ? 1.55 : (columns == 2 ? 1.32 : 1.38);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: aspect,
          ),
          itemCount: testimonials.length,
          itemBuilder: (context, index) {
            final t = testimonials[index];
            return AnimatedContainer(
              duration: Duration(milliseconds: 220 + (index * 70)),
              curve: Curves.easeOutBack,
              child: _ProfessionalTestimonialCard(
                quote: t.$3,
                author: t.$1,
                role: t.$2,
                rating: t.$4,
                source: t.$5,
                index: index,
              ),
            );
          },
        );
      },
    );
  }
}

// -----------------------------
// Professional Testimonial Card
// -----------------------------
class _ProfessionalTestimonialCard extends StatefulWidget {
  const _ProfessionalTestimonialCard({
    required this.quote,
    required this.author,
    required this.role,
    required this.rating,
    required this.source,
    required this.index,
  });

  final String quote;
  final String author;
  final String role;
  final int rating;
  final String source; // e.g., "Google Reviews"
  final int index;

  @override
  State<_ProfessionalTestimonialCard> createState() =>
      _ProfessionalTestimonialCardState();
}

class _ProfessionalTestimonialCardState
    extends State<_ProfessionalTestimonialCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 1.0, end: 1.02).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );

  bool _isHovered = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      [const Color(0xFF059669), const Color(0xFF10B981)],
      [const Color(0xFF0891B2), const Color(0xFF06B6D4)],
      [const Color(0xFF7C3AED), const Color(0xFF8B5CF6)],
      [const Color(0xFFDB2777), const Color(0xFFEC4899)],
      [const Color(0xFFDC2626), const Color(0xFFEF4444)],
      [const Color(0xFFEA580C), const Color(0xFFF97316)],
    ];
    final colorPair = colors[widget.index % colors.length];

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovered = true);
              _animationController.forward();
            },
            onExit: (_) {
              setState(() => _isHovered = false);
              _animationController.reverse();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colorPair[0].withOpacity(_isHovered ? 0.14 : 0.07),
                    blurRadius: _isHovered ? 22 : 14,
                    offset: Offset(0, _isHovered ? 9 : 6),
                  ),
                ],
                border: Border.all(
                  color: _isHovered
                      ? colorPair[0].withOpacity(0.18)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Quote icon with gradient
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colorPair),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Icon(
                        Icons.format_quote_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Rating stars
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star_rounded,
                          color: i < widget.rating
                              ? const Color(0xFFFFB800)
                              : const Color(0xFFE2E8F0),
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Quote text (limited lines for compact height)
                    Text(
                      widget.quote,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF374151),
                        height: 1.42,
                        fontSize: 13.2,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // Author section + source
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Avatar with gradient
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: colorPair,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.author
                                    .split(' ')
                                    .map((n) => n[0])
                                    .take(2)
                                    .join(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.author,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.role,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: const Color(0xFF6B7280),
                                        fontSize: 12,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const _GoogleBadge(small: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------
// Call to Action Section
// -----------------------------
class _CallToAction extends StatelessWidget {
  const _CallToAction();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF059669), Color(0xFF0891B2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.28),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.flight_takeoff_rounded,
            color: Colors.white,
            size: 42,
          ),
          const SizedBox(height: 10),
          Text(
            'Ready for Your Own Adventure?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Plan a safe, seamless trip across Northern Pakistan with our experts.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.92),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/contact'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF059669),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Start Planning Your Trip',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
