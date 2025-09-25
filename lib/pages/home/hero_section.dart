// lib/pages/home/sections/hero_section.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  // Brand colors to match the aqua → emerald palette
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  final _images = const [
    'assets/destinations/attabad.jpg',
    'assets/destinations/skardu.jpg',
    'assets/destinations/swat.jpg',
  ];

  final _titles = const [
    'Discover Pristine Lakes',
    'Explore Majestic Mountains',
    'Experience Cultural Heritage',
  ];

  final _subtitles = const [
    'Crystal clear waters reflecting towering peaks in perfect harmony',
    'Adventure awaits in the breathtaking landscapes of northern Pakistan',
    'Rich traditions and timeless beauty in every corner of our homeland',
  ];

  late final PageController _pageController;
  late final AnimationController _fadeController;
  late final AnimationController _parallaxController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _parallaxAnimation;

  Timer? _autoTimer;
  int _current = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _parallaxController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _parallaxAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _parallaxController, curve: Curves.linear),
    );

    _fadeController.forward();
    _parallaxController.repeat();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || _isAnimating) return;
      _nextSlide();
    });
  }

  void _nextSlide() async {
    if (_isAnimating) return;
    _isAnimating = true;

    final next = (_current + 1) % _images.length;
    await _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );

    _isAnimating = false;
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    _fadeController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height.clamp(580.0, 800.0);
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width < 900;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Animated background carousel
          AnimatedBuilder(
            animation: _parallaxAnimation,
            builder: (context, child) {
              return PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (_, i) => _HeroImage(
                  key: ValueKey(_images[i]),
                  path: _images[i],
                  parallaxValue: _parallaxAnimation.value,
                ),
              );
            },
          ),

          // Multi-layer gradient overlay for readability
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.3, 0.7, 1.0],
                colors: [
                  Color(0x80000000),
                  Color(0x40000000),
                  Color(0x60000000),
                  Color(0x90000000),
                ],
              ),
            ),
          ),

          // Floating particles
          ...List.generate(
            15,
            (index) => _FloatingParticle(key: ValueKey(index), index: index),
          ),

          // Main content
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isSmallScreen ? double.infinity : 1000,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 20 : 40,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated title
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          _titles[_current],
                          key: ValueKey(_titles[_current]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isSmallScreen
                                ? 28
                                : isMediumScreen
                                ? 36
                                : 48,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                            letterSpacing: -0.5,
                            shadows: const [
                              Shadow(
                                blurRadius: 20,
                                color: Colors.black54,
                                offset: Offset(0, 4),
                              ),
                              Shadow(
                                blurRadius: 40,
                                color: Colors.black26,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Animated subtitle
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          _subtitles[_current],
                          key: ValueKey(_subtitles[_current]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 20,
                            color: Colors.white.withOpacity(0.95),
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            shadows: const [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black45,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // CTA row
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _buildCTAButton(
                            'Start Your Journey',
                            _brandCyan,
                            _brandEmerald,
                            Icons.explore_rounded,
                            true,
                            () => Navigator.of(
                              context,
                            ).pushReplacementNamed('/contact'),
                          ),
                          _buildCTAButton(
                            'View Destinations',
                            Colors.transparent,
                            Colors.transparent,
                            Icons.place_rounded,
                            false,
                            () => Navigator.of(
                              context,
                            ).pushReplacementNamed('/destinations'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Navigation arrows
          if (!isSmallScreen) ...[
            Positioned(
              left: 24,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildNavButton(
                  Icons.chevron_left_rounded,
                  () => _previousSlide(),
                ),
              ),
            ),
            Positioned(
              right: 24,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildNavButton(
                  Icons.chevron_right_rounded,
                  () => _nextSlide(),
                ),
              ),
            ),
          ],

          // Dots indicator
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (i) {
                final active = i == _current;
                return GestureDetector(
                  onTap: () => _goToSlide(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: active ? 12 : 8,
                    width: active ? 40 : 8,
                    decoration: BoxDecoration(
                      color: active
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),

          // Scroll indicator (safe margin)
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: _buildScrollIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(
    String text,
    Color startColor,
    Color endColor,
    IconData icon,
    bool isPrimary,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: isPrimary
            ? LinearGradient(colors: [startColor, endColor])
            : null,
        border: !isPrimary
            ? Border.all(color: Colors.white.withOpacity(0.5), width: 2)
            : null,
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: startColor.withOpacity(0.30),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return AnimatedBuilder(
      animation: _parallaxAnimation,
      builder: (context, child) {
        // Map sine [-1..1] → [0..1] and then to safe margin (no negatives)
        final t = (math.sin(_parallaxAnimation.value * 2 * math.pi) + 1) / 2;
        final top = 4 + t * 18; // 4..22 px movement

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Scroll to explore',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 2,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                width: 2,
                height: 8,
                margin: EdgeInsets.only(top: top),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _previousSlide() async {
    if (_isAnimating) return;
    _isAnimating = true;

    final prev = (_current - 1 + _images.length) % _images.length;
    await _pageController.animateToPage(
      prev,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );

    _isAnimating = false;
  }

  void _goToSlide(int index) async {
    if (_isAnimating || index == _current) return;
    _isAnimating = true;

    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );

    _isAnimating = false;
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    super.key,
    required this.path,
    required this.parallaxValue,
  });

  final String path;
  final double parallaxValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Parallax background image
        Transform.scale(
          scale: 1.1,
          child: Transform.translate(
            offset: Offset(0, -20 * math.sin(parallaxValue * 2 * math.pi)),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF667EEA).withOpacity(0.8),
                      const Color(0xFF764BA2).withOpacity(0.8),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.landscape_rounded,
                    size: 80,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Subtle vignette
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingParticle extends StatefulWidget {
  const _FloatingParticle({super.key, required this.index});
  final int index;

  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _startX;
  late double _startY;
  late double _size;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 8 + widget.index % 4),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    final random = math.Random(widget.index);
    _startX = random.nextDouble();
    _startY = random.nextDouble();
    _size = 2.0 + random.nextDouble() * 4.0;

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final screenSize = MediaQuery.of(context).size;
        final x =
            _startX * screenSize.width +
            (30 * math.sin(_animation.value * 2 * math.pi + widget.index));
        final y =
            _startY * screenSize.height -
            (_animation.value * screenSize.height * 0.1);

        return Positioned(
          left: x,
          top: y % screenSize.height,
          child: Container(
            width: _size,
            height: _size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
