// lib/pages/about.dart
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A202C),
        elevation: 0,
        shadowColor: Colors.black12,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _HeroSection(),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 80,
                    horizontal: 16,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: const Column(
                        children: [
                          _MainContentSection(),
                          SizedBox(height: 80),
                          _StatsSection(),
                          SizedBox(height: 80),
                          _ServicesSection(),
                          SizedBox(height: 80),
                          _TeamSection(),
                          SizedBox(height: 80),
                          _ValuesSection(),
                          SizedBox(height: 80),
                          _ContactSection(),
                        ],
                      ),
                    ),
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

// -----------------------------
// Hero Section (responsive height)
// -----------------------------
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final heroH = (screenH * 0.45).clamp(320.0, 480.0);

    return Container(
      height: heroH,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF06B6D4), Color(0xFF10B981), Color(0xFF06B6D4)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.flight_takeoff,
                    color: Colors.white,
                    size: 60,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Mirabella Travel & Tours',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 42,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Creating extraordinary travel experiences and unforgettable memories for over 5 years',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w300,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Main Content Section (overflow-proof)
// -----------------------------
class _MainContentSection extends StatelessWidget {
  const _MainContentSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;

        final leftCol = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crafting Dreams Since 2020',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Founded in 2020 by a group of passionate travelers, Mirabella Travel & Tours was born from a simple yet powerful vision: to make extraordinary travel accessible to everyone. We believe that travel is not just about reaching a destination; it's about the journey, the experiences, the connections you make, and the memories that last a lifetime.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: 16,
                color: const Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Over the years, our dedicated team of travel experts has curated thousands of unforgettable journeys across six continents. From intimate romantic getaways in the Maldives to thrilling family adventures in Costa Rica, from cultural explorations through ancient European cities to expedition cruises in Antarctica, we've helped travelers discover the world in ways they never imagined possible.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: 16,
                color: const Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 24),
            const _FeaturesList(),
          ],
        );

        if (isWide) {
          // ✅ Wide: bounded Row allows Expanded safely
          return Column(
            children: [
              const _SectionTitle(
                title: 'Our Story',
                subtitle:
                    'Discover how we became your trusted travel companion',
              ),
              const SizedBox(height: 48),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: leftCol),
                  const SizedBox(width: 48),
                  const Expanded(child: _EnhancedGradientCard()),
                ],
              ),
            ],
          );
        }

        // ✅ Narrow: use Column (NO Expanded) to avoid unbounded-height + flex errors
        return Column(
          children: [
            const _SectionTitle(
              title: 'Our Story',
              subtitle: 'Discover how we became your trusted travel companion',
            ),
            const SizedBox(height: 48),
            leftCol,
            const SizedBox(height: 32),
            const _EnhancedGradientCard(),
          ],
        );
      },
    );
  }
}

// -----------------------------
// Stats Section
// -----------------------------
class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0FDFA), Color(0xFFE6FFFA)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Our Journey in Numbers',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A202C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 40,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: const [
                  _AnimatedStatTile(
                    icon: Icons.access_time,
                    value: '5+',
                    label: 'Years of Excellence',
                    color: Color(0xFF0EA5E9),
                  ),
                  _AnimatedStatTile(
                    icon: Icons.people,
                    value: '750+',
                    label: 'Happy Travelers',
                    color: Color(0xFF10B981),
                  ),
                  _AnimatedStatTile(
                    icon: Icons.public,
                    value: '200+',
                    label: 'Global Destinations',
                    color: Color(0xFFF59E0B),
                  ),
                  _AnimatedStatTile(
                    icon: Icons.star,
                    value: '98.5%',
                    label: 'Satisfaction Rate',
                    color: Color(0xFFEF4444),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Services Section
// -----------------------------
class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle(
          title: 'Our Premium Services',
          subtitle:
              'Comprehensive travel solutions tailored to your unique needs',
        ),
        const SizedBox(height: 48),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth < 600
                ? 1
                : constraints.maxWidth < 900
                ? 2
                : 3;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 1.1,
              children: const [
                _ServiceCard(
                  icon: Icons.map,
                  title: 'Custom Itineraries',
                  description:
                      'Personalized travel plans crafted by our expert destination specialists',
                  color: Color(0xFF0EA5E9),
                ),
                _ServiceCard(
                  icon: Icons.support_agent,
                  title: '24/7 Support',
                  description:
                      'Round-the-clock assistance throughout your entire journey',
                  color: Color(0xFF10B981),
                ),
                _ServiceCard(
                  icon: Icons.hotel,
                  title: 'Luxury Accommodations',
                  description:
                      'Partnerships with premium hotels and resorts worldwide',
                  color: Color(0xFFF59E0B),
                ),
                _ServiceCard(
                  icon: Icons.tour,
                  title: 'Expert Guides',
                  description:
                      'Local professionals who bring destinations to life',
                  color: Color(0xFF06B6D4),
                ),
                _ServiceCard(
                  icon: Icons.security,
                  title: 'Travel Protection',
                  description: 'Comprehensive insurance and safety protocols',
                  color: Color(0xFF14B8A6),
                ),
                _ServiceCard(
                  icon: Icons.eco,
                  title: 'Sustainable Tourism',
                  description:
                      'Responsible travel practices that benefit local communities',
                  color: Color(0xFF22C55E),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// -----------------------------
// Team Section
// -----------------------------
class _TeamSection extends StatelessWidget {
  const _TeamSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle(
          title: 'Meet Our Travel Experts',
          subtitle:
              'Passionate professionals dedicated to creating your perfect journey',
        ),
        const SizedBox(height: 48),
        LayoutBuilder(
          builder: (context, c) {
            final maxW = c.maxWidth;
            final columns = maxW < 600 ? 1 : (maxW < 900 ? 2 : 3);
            const gap = 24.0;
            final cardW = (maxW - gap * (columns - 1)) / columns;
            final width = cardW.clamp(260.0, 360.0);

            return Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: gap,
              runSpacing: gap,
              children: [
                SizedBox(
                  width: width,
                  child: const _TeamMemberCard(
                    name: 'Syed Mustafa',
                    role: 'Founder & CEO',
                    expertise: 'Luxury Travel & Adventure Tourism',
                    experience: '5+ years',
                    gradient: LinearGradient(
                      colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                    ),
                    photo: AssetImage('assets/team/mustafa.jpeg'),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: const _TeamMemberCard(
                    name: 'Aqib Khan',
                    role: 'Head of Operations',
                    expertise: 'Asia-Pacific & Cultural Tours',
                    experience: '8+ years',
                    gradient: LinearGradient(
                      colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                    ),
                    photo: AssetImage('assets/team/aqib.jpeg'),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: const _TeamMemberCard(
                    name: 'Rana Tanveer',
                    role: 'Tour Specialist',
                    expertise: 'European Heritage & Gastronomy',
                    experience: '12+ years',
                    gradient: LinearGradient(
                      colors: [Color(0xFFF59E0B), Color(0xFFFB923C)],
                    ),
                    photo: AssetImage('assets/team/rana.jpeg'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// -----------------------------
// Values Section
// -----------------------------
class _ValuesSection extends StatelessWidget {
  const _ValuesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF134E4A)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Our Core Values',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: const [
                  _ValueCard(
                    icon: Icons.favorite,
                    title: 'Passion',
                    description:
                        'We live and breathe travel, sharing our enthusiasm with every client',
                  ),
                  _ValueCard(
                    icon: Icons.verified,
                    title: 'Excellence',
                    description:
                        'Uncompromising quality in every aspect of your travel experience',
                  ),
                  _ValueCard(
                    icon: Icons.handshake,
                    title: 'Trust',
                    description:
                        'Building lasting relationships through transparency and reliability',
                  ),
                  _ValueCard(
                    icon: Icons.eco_outlined,
                    title: 'Responsibility',
                    description:
                        'Committed to sustainable tourism and cultural preservation',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Contact Section
// -----------------------------
class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Your Journey?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A202C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Let our travel experts create your perfect getaway. Contact us today for a personalized consultation.",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF4A5568)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone),
                label: const Text('Call Us: 051-6150748'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.email),
                label: const Text('info@mirabellatravelandtours.com'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF10B981),
                  side: const BorderSide(color: Color(0xFF10B981)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Helper Widgets
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
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF718096),
              fontSize: 18,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturesList extends StatelessWidget {
  const _FeaturesList();

  @override
  Widget build(BuildContext context) {
    const features = [
      'Personalized itinerary planning by destination experts',
      '24/7 multilingual customer support worldwide',
      'Exclusive partnerships with luxury hotels and airlines',
      'Certified local guides in every destination',
      'Comprehensive travel insurance and emergency assistance',
      'Sustainable and responsible tourism practices',
      'VIP airport services and priority boarding',
      'Flexible booking policies and travel protection',
    ];

    return Column(
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        height: 1.5,
                        color: const Color(0xFF4A5568),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _EnhancedGradientCard extends StatelessWidget {
  const _EnhancedGradientCard();

  @override
  Widget build(BuildContext context) {
    // Slightly smaller on very small phones to avoid clipping
    final screenW = MediaQuery.sizeOf(context).width;
    final h = screenW < 380 ? 340.0 : 400.0;

    return Container(
      height: h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF06B6D4), Color(0xFF10B981), Color(0xFF06B6D4)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.flight_takeoff,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Adventure\nAwaits',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
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

class _AnimatedStatTile extends StatefulWidget {
  const _AnimatedStatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  State<_AnimatedStatTile> createState() => _AnimatedStatTileState();
}

class _AnimatedStatTileState extends State<_AnimatedStatTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.color, size: 30),
              ),
              const SizedBox(height: 16),
              Text(
                widget.value,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: const Color(0xFF1A202C),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF718096),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 25 : 15,
                offset: Offset(0, _isHovered ? 15 : 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.color, widget.color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A202C),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF718096),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  const _TeamMemberCard({
    required this.name,
    required this.role,
    required this.expertise,
    required this.experience,
    required this.gradient,
    this.photo,
  });

  final String name;
  final String role;
  final String expertise;
  final String experience;
  final LinearGradient gradient;
  final ImageProvider? photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Extra vertical room so avatar never clips
          SizedBox(
            height: 170,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -40,
                  child: Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        color: Colors.white,
                        image: photo != null
                            ? DecorationImage(image: photo!, fit: BoxFit.cover)
                            : null,
                      ),
                      child: photo == null
                          ? const Icon(
                              Icons.person,
                              size: 42,
                              color: Color(0xFF94A3B8),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A202C),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  role,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF06B6D4),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  expertise,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF718096),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FAFC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    experience,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF4A5568),
                      fontWeight: FontWeight.w600,
                    ),
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

class _ValueCard extends StatelessWidget {
  const _ValueCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
