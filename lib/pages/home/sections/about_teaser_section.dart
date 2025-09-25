// lib/pages/home/sections/about_teaser_section.dart
import 'package:flutter/material.dart';

class AboutTeaserSection extends StatefulWidget {
  const AboutTeaserSection({super.key});

  @override
  State<AboutTeaserSection> createState() => _AboutTeaserSectionState();
}

class _AboutTeaserSectionState extends State<AboutTeaserSection>
    with SingleTickerProviderStateMixin {
  // Brand colors (aqua → emerald)
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFAFBFC), Colors.white, Color(0xFFF8FAFC)],
        ),
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen
                ? 40
                : isMediumScreen
                ? 56
                : 80,
            horizontal: isSmallScreen ? 16 : 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      _buildSectionHeader(context, isSmallScreen),
                      SizedBox(height: isSmallScreen ? 32 : 48),
                      _buildMainContent(context, screenWidth),
                      SizedBox(height: isSmallScreen ? 32 : 48),
                      _buildStatsRow(context, isSmallScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          'Mirabella Travel & Tours',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSmallScreen ? 28 : 36,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1A202C),
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            'Your trusted partner in creating extraordinary travel experiences for over 15 years',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              color: const Color(0xFF4A5568),
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  /// Wide screens: Row + Expanded (bounded -> safe).
  /// Narrow screens: Column (NO Expanded) to avoid unbounded-height flex.
  Widget _buildMainContent(BuildContext context, double screenWidth) {
    final isWide = screenWidth >= 900;
    final isSmallScreen = screenWidth < 600;

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(right: 32),
              child: _buildContentSection(context, isSmallScreen),
            ),
          ),
          Expanded(
            flex: 4,
            child: _buildImageCard(
              height: 400, // bounded inside Row
              isSmallScreen: isSmallScreen,
            ),
          ),
        ],
      );
    }

    // Column layout: no Expanded
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContentSection(context, isSmallScreen),
        const SizedBox(height: 24),
        // Keep a sensible height or aspect ratio when stacked vertically
        _buildImageCard(
          height: isSmallScreen ? 250 : 300,
          isSmallScreen: isSmallScreen,
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_brandCyan, _brandEmerald],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Crafting Memories Since 2010',
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2D3748),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Text(
          'Mirabella Travel & Tours was founded with a simple vision: to make extraordinary travel accessible to everyone. We believe travel is not just about reaching a destination; it\'s about the journey, the experiences, and the memories you create.',
          style: TextStyle(
            fontSize: isSmallScreen ? 15 : 16,
            color: const Color(0xFF4A5568),
            height: 1.7,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Our team of passionate travel experts has curated thousands of unforgettable journeys — from romantic getaways to family adventures, and cultural explorations to thrilling expeditions.',
          style: TextStyle(
            fontSize: isSmallScreen ? 15 : 16,
            color: const Color(0xFF4A5568),
            height: 1.7,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24),

        _buildFeaturesList(isSmallScreen),
        const SizedBox(height: 24),

        _buildCTAButton(context),
      ],
    );
  }

  Widget _buildFeaturesList(bool isSmallScreen) {
    final features = [
      {
        'icon': Icons.person_outline,
        'text': 'Personalized itinerary planning based on your interests',
      },
      {
        'icon': Icons.support_agent,
        'text': '24/7 customer support throughout your journey',
      },
      {
        'icon': Icons.hotel,
        'text': 'Partnerships with premium hotels and airlines worldwide',
      },
      {'icon': Icons.tour, 'text': 'Local expert guides in every destination'},
      {
        'icon': Icons.security,
        'text': 'Comprehensive travel insurance and safety protocols',
      },
      {
        'icon': Icons.eco,
        'text': 'Sustainable and responsible tourism practices',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why Choose Mirabella?',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 16),
        ...features
            .map(
              (feature) => _buildFeatureItem(
                feature['icon'] as IconData,
                feature['text'] as String,
                isSmallScreen,
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text, bool isSmallScreen) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _brandCyan.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 14, color: _brandCyan),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 15,
                color: const Color(0xFF4A5568),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_brandCyan, _brandEmerald]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _brandCyan.withOpacity(0.28),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.of(context).pushNamed('/about'),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Learn More About Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Image card with fixed height (when stacked) or bounded height (in Row).
  Widget _buildImageCard({
    required double height,
    required bool isSmallScreen,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/gallery/chitral.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_brandCyan, _brandEmerald],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.landscape_rounded,
                          size: 48,
                          color: Colors.white70,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Beautiful Chitral Valley',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Gradient overlay for readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                ),
              ),
            ),
            // Location badge
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.place_rounded, size: 14, color: _brandCyan),
                    SizedBox(width: 4),
                    Text(
                      'Chitral Valley',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Photo credit
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Featured Destination',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Stats: 2×2 on phones, single row on larger screens.
  Widget _buildStatsRow(BuildContext context, bool isSmallScreen) {
    final stats = [
      {'number': '5+', 'label': 'Years Experience'},
      {'number': '750+', 'label': 'Happy Travelers'},
      {'number': '50+', 'label': 'Destinations'},
      {'number': '24/7', 'label': 'Customer Support'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: isSmallScreen ? 24 : 32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isSmallScreen
          ? Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildStatItem(stats[0], true)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatItem(stats[1], false)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildStatItem(stats[2], true)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatItem(stats[3], false)),
                  ],
                ),
              ],
            )
          : Row(
              children: List.generate(stats.length, (i) {
                final showDivider = i < stats.length - 1;
                return Expanded(child: _buildStatItem(stats[i], showDivider));
              }),
            ),
    );
  }

  Widget _buildStatItem(Map<String, String> stat, bool showDivider) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                stat['number']!,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: _brandCyan,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat['label']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5568),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        if (showDivider) ...[
          const SizedBox(width: 16),
          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
          const SizedBox(width: 16),
        ],
      ],
    );
  }
}
