// lib/pages/e_cab_division1.dart
import 'package:flutter/material.dart';

class ECabDivision1Page extends StatefulWidget {
  const ECabDivision1Page({super.key});

  @override
  State<ECabDivision1Page> createState() => _ECabDivision1PageState();
}

class _ECabDivision1PageState extends State<ECabDivision1Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Enhanced Header with Gradient + Shimmer =====
                  _AnimatedHeader(colorScheme: cs),

                  const SizedBox(height: 20),

                  // ===== Diplomat Callout with Animation =====
                  _CalloutCard(
                    icon: Icons.verified_user_outlined,
                    title: 'Premier transport for ambassadors and diplomats',
                    subtitle:
                        'Operated by security-cleared chauffeurs for seamless, discreet, and professional movement in and around the enclave.',
                    color: cs.primary,
                  ),

                  const SizedBox(height: 28),

                  // ===== Stats Section (NEW!) =====
                  const _StatsSection(),

                  const SizedBox(height: 28),

                  // ===== Highlights =====
                  const _SectionTitle('Why choose our Deepal S07 service'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: const [
                      _BulletTile(
                        icon: Icons.event_available_outlined,
                        title: 'Luxurious & futuristic experience',
                        body:
                            'Join a service that is completely powered by renewable energy with no tailpipe emissions — a greener, better tomorrow.',
                      ),
                      _BulletTile(
                        icon: Icons.auto_awesome,
                        title: 'Advanced technology',
                        body:
                            'Seamless digital interface, intelligent driver aids, and refined cabin tech elevate every trip.',
                      ),
                      _BulletTile(
                        icon: Icons.chair_outlined,
                        title: 'Premium comfort',
                        body:
                            'Quiet, spacious SUV ride quality with meticulous attention to touchpoints and materials.',
                      ),
                      _BulletTile(
                        icon: Icons.energy_savings_leaf_outlined,
                        title: 'Environmental stewardship',
                        body:
                            'Your rides directly support the green movement through zero tailpipe emissions and clean energy.',
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ===== Interior Description with Enhanced Styling =====
                  const _SectionTitle('Inside the Deepal S07'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cs.primary.withOpacity(0.04),
                          cs.secondary.withOpacity(0.03),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.primary.withOpacity(0.15)),
                    ),
                    child: const Text(
                      'Step into the Deepal S07 and it feels like tomorrow arrived early. '
                      'A clean, floating cockpit anchors a seamless digital interface, while hidden vents and razor-thin ambient light blades '
                      'keep the look pure and architectural. Soft-touch materials meet satin metallic accents for a refined, almost weightless aesthetic.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ===== Showcase with Enhanced Images =====
                  const _SectionTitle('Showcase'),
                  const SizedBox(height: 16),

                  const _ImageContentRow(
                    asset: 'assets/ecab1.jpg',
                    title: 'Premium, Low-Noise Drive',
                    body:
                        'Electric refinement meets comfort. Enjoy smooth acceleration, quiet cabins, and a ride quality designed for city and highway.',
                    imageOnLeft: true,
                  ),
                  const SizedBox(height: 22),

                  const _ImageContentRow(
                    asset: 'assets/ecab2.jpg',
                    title: 'Security-Cleared Chauffeurs',
                    body:
                        'A discreet, professional team trained for embassy movements, airport transfers, and VIP itineraries.',
                    imageOnLeft: false,
                  ),
                  const SizedBox(height: 22),

                  const _ImageContentRow(
                    asset: 'assets/ecab3.jpg',
                    title: 'Futuristic Interior',
                    body:
                        'Floating cockpit, seamless digital interface, hidden vents, and ambient light blades—modern, architectural, and calming.',
                    imageOnLeft: false,
                  ),

                  const SizedBox(height: 36),

                  // ===== Enhanced CTA Section =====
                  _EnhancedCTASection(colorScheme: cs),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===== NEW: Animated Header =====
class _AnimatedHeader extends StatelessWidget {
  const _AnimatedHeader({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withOpacity(0.12),
            colorScheme.secondary.withOpacity(0.10),
            colorScheme.primary.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.20),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.electric_car_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'E-Cab Division 1',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'By selecting the Deepal all-electric SUV, clients enjoy a premium, low-noise driving experience while demonstrably supporting the green movement and our shared goal of environmental preservation.',
            style: TextStyle(
              fontSize: 16.5,
              color: Color(0xFF4A5568),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _Tag('Premium Comfort'),
              _Tag('Low-Noise Drive'),
              _Tag('Zero Tailpipe Emissions'),
              _Tag('Renewable-Powered Fleet'),
            ],
          ),
        ],
      ),
    );
  }
}

// ===== NEW: Stats Section =====
class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cs.primary.withOpacity(0.08), cs.primary.withOpacity(0.04)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.primary.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            value: '100%',
            label: 'Electric Fleet',
            icon: Icons.electric_bolt_outlined,
            color: cs.primary,
          ),
          Container(width: 1.5, height: 50, color: cs.primary.withOpacity(0.2)),
          _StatItem(
            value: '0g',
            label: 'CO₂ Emissions',
            icon: Icons.eco_outlined,
            color: Colors.green,
          ),
          Container(width: 1.5, height: 50, color: cs.primary.withOpacity(0.2)),
          _StatItem(
            value: '24/7',
            label: 'Service Available',
            icon: Icons.schedule_outlined,
            color: cs.secondary,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF4A5568),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ===== Enhanced CTA Section =====
class _EnhancedCTASection extends StatelessWidget {
  const _EnhancedCTASection({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withOpacity(0.10),
            colorScheme.secondary.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.20),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Ready to experience the future of luxury transport?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Book your E-Cab today and join the green revolution',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Color(0xFF4A5568)),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              _HoverButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/contact'),
                icon: Icons.send_outlined,
                label: 'Book E-Cab',
                isPrimary: true,
                colorScheme: colorScheme,
              ),
              _HoverButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/services'),
                icon: Icons.list_alt_outlined,
                label: 'View Services',
                isPrimary: false,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===== Hover Button with Animation =====
class _HoverButton extends StatefulWidget {
  const _HoverButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.colorScheme,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isPrimary;
  final ColorScheme colorScheme;

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isPrimary) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          child: FilledButton.icon(
            onPressed: widget.onPressed,
            icon: Icon(widget.icon),
            label: Text(widget.label),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: _isHovered ? 8 : 2,
            ),
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon),
          label: Text(widget.label),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: widget.colorScheme.primary.withOpacity(
                _isHovered ? 0.7 : 0.45,
              ),
              width: _isHovered ? 2 : 1.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}

// ===== UI Components (Enhanced) =====

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 6,
          height: 26,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [cs.primary, cs.secondary],
            ),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _BulletTile extends StatefulWidget {
  const _BulletTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  State<_BulletTile> createState() => _BulletTileState();
}

class _BulletTileState extends State<_BulletTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 520,
        padding: const EdgeInsets.all(18),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? cs.primary.withOpacity(0.25)
                : cs.primary.withOpacity(0.12),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: cs.primary.withOpacity(_isHovered ? 0.15 : 0.07),
              blurRadius: _isHovered ? 16 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(_isHovered ? 0.15 : 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, size: 22, color: cs.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16.5,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    widget.body,
                    style: const TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF4A5568),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalloutCard extends StatelessWidget {
  const _CalloutCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.25), width: 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.08), color.withOpacity(0.04)],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.20),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.5,
                    color: color,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF4A5568),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary.withOpacity(0.12), cs.primary.withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.primary.withOpacity(0.30), width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.primary,
          fontWeight: FontWeight.w700,
          fontSize: 13,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _ImageContentRow extends StatefulWidget {
  const _ImageContentRow({
    required this.asset,
    required this.title,
    required this.body,
    required this.imageOnLeft,
  });

  final String asset;
  final String title;
  final String body;
  final bool imageOnLeft;

  @override
  State<_ImageContentRow> createState() => _ImageContentRowState();
}

class _ImageContentRowState extends State<_ImageContentRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 900;

        final image = MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..scale(_isHovered && isWide ? 1.02 : 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.asset(
                      widget.asset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [cs.primary, cs.secondary],
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        final content = Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: cs.primary.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.star_rounded,
                      color: cs.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.body,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4A5568),
                  height: 1.65,
                ),
              ),
            ],
          ),
        );

        if (!isWide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [image, const SizedBox(height: 14), content],
          );
        }

        final left = widget.imageOnLeft ? image : content;
        final right = widget.imageOnLeft ? content : image;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 24),
            Expanded(child: right),
          ],
        );
      },
    );
  }
}
