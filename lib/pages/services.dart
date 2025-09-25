// lib/pages/services.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  // Brand palette (match hero/about)
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    const services = [
      (
        '✈️',
        'International Flights',
        'Access to 500+ airlines worldwide with competitive rates and multi-city expertise. We negotiate exclusive deals and provide 24/7 flight monitoring.',
        [
          'Best Price Guarantee - We match any competitor\'s price',
          'Multi-city Planning - Complex itineraries made simple',
          '24/7 Support - Round the clock assistance',
          'Flexible Booking - Easy changes and cancellations',
          'Seat Selection - Choose your preferred seats',
          'Meal Preferences - Special dietary requirements handled',
          'Lounge Access - Premium airport lounge partnerships',
          'Travel Alerts - Real-time flight status updates',
        ],
      ),
      (
        '🏨',
        'Luxury Accommodations',
        'Boutique to 5-star stays with premium partners across the globe. From intimate hideaways to world-renowned luxury resorts.',
        [
          '5-Star Properties - Handpicked luxury hotels worldwide',
          'Boutique Hotels - Unique and charming accommodations',
          'Resort Packages - All-inclusive luxury experiences',
          'Room Upgrades - Complimentary upgrades when available',
          'Early Check-in - Flexible arrival times',
          'Late Check-out - Extended stays without extra cost',
          'Concierge Services - Personal assistance at hotels',
          'Special Amenities - Welcome gifts and premium services',
        ],
      ),
      (
        '🚌',
        'Premium Transportation',
        'Private transfers, luxury coaches, and first-class train bookings. Door-to-door service with professional drivers and premium vehicles.',
        [
          'Private Transfers - Luxury vehicles with professional drivers',
          'Luxury Coaches - Premium group transportation',
          'First-Class Rail - High-speed train reservations',
          'Airport VIP - Fast-track services and meet & greet',
          'Car Rentals - Premium vehicle selection',
          'Chauffeur Services - Professional drivers available',
          'Multi-city Transfers - Seamless inter-city travel',
          'Real-time Tracking - Live vehicle location updates',
        ],
      ),
      (
        '🗺️',
        'Bespoke Itineraries',
        'Exclusive access to hidden gems and authentic local experiences. Our local experts craft personalized journeys that go beyond typical tourist attractions.',
        [
          'Custom Planning - Tailored to your interests and budget',
          'Local Experts - Native guides with insider knowledge',
          'Hidden Gems - Off-the-beaten-path discoveries',
          'Cultural Immersion - Authentic local experiences',
          'Private Tours - Exclusive access to attractions',
          'Photography Tours - Perfect shots with expert guidance',
          'Culinary Experiences - Local cuisine and cooking classes',
          'Historical Tours - Expert historians as your guides',
        ],
      ),
      (
        '📋',
        'Comprehensive Insurance',
        'Complete protection with medical, cancellation, luggage coverage and 24/7 emergency assistance worldwide. Travel with complete peace of mind.',
        [
          'Medical Coverage - Up to \$1M emergency medical expenses',
          'Trip Cancellation - Full refund for covered reasons',
          'Lost Luggage - Compensation for delayed or lost baggage',
          'Emergency Support - 24/7 multilingual assistance',
          'Adventure Sports - Coverage for extreme activities',
          'Pre-existing Conditions - Medical coverage included',
          'Travel Delays - Compensation for delayed flights',
          'Personal Liability - Protection against third-party claims',
        ],
      ),
      (
        '🌍',
        'Visa & Documentation',
        'Complete visa processing, passport renewals, and document verification. Our specialists handle all paperwork so you can focus on planning.',
        [
          'Visa Processing - Expert handling of all visa types',
          'Passport Service - Renewal and expedited processing',
          'Document Review - Verification before travel',
          'Express Options - Rush processing available',
          'Embassy Coordination - Direct liaison with embassies',
          'Photo Services - Professional passport photos',
          'Form Assistance - Help with complex applications',
          'Status Updates - Real-time processing updates',
        ],
      ),
      (
        '👥',
        'Group Travel Specialists',
        'Corporate retreats, family reunions, and special-interest groups. Customized packages for groups of all sizes with dedicated coordinators.',
        [
          'Corporate Events - Team building and business retreats',
          'Family Groups - Multi-generational travel planning',
          'Educational Tours - Learning experiences for students',
          'Special Interest - Hobby-based group adventures',
          'Wedding Parties - Destination wedding coordination',
          'Sports Groups - Tournament and event travel',
          'Religious Pilgrimages - Sacred journey planning',
          'Group Discounts - Savings for larger parties',
        ],
      ),
      (
        '💼',
        'Corporate Travel Management',
        'Comprehensive business travel solutions with policy compliance, preferred vendors, expense reporting, and cost control measures.',
        [
          'Travel Policies - Custom corporate travel guidelines',
          'Expense Management - Automated reporting systems',
          'Preferred Rates - Negotiated corporate discounts',
          'Reporting Tools - Detailed analytics and insights',
          'Booking Platform - Easy online reservation system',
          'Approval Workflow - Streamlined authorization process',
          'Emergency Support - 24/7 business travel assistance',
          'Cost Optimization - Regular policy and rate reviews',
        ],
      ),
      (
        '🌟',
        'VIP Concierge Services',
        'Exclusive access to restaurants, events, personal shopping, and unique experiences. Your dedicated concierge makes the impossible possible.',
        [
          'Fine Dining - Reservations at exclusive restaurants',
          'Event Access - VIP tickets to sold-out shows',
          'Personal Shopping - Luxury shopping experiences',
          'Exclusive Tours - Private access to attractions',
          'Yacht Charters - Luxury boat experiences',
          'Private Jets - Charter flight arrangements',
          'Celebrity Meetings - Arrange meet and greets',
          'Custom Experiences - Unique once-in-a-lifetime moments',
        ],
      ),
    ];

    return Scaffold(
      body: Container(
        // Light, airy background (very light aqua -> white)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0FDFA), Color(0xFFFFFFFF)],
            stops: [0.0, 0.4],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // App Bar with brand gradient
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(
                  start: 16,
                  bottom: 12,
                ),
                title: const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Our Services',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_brandCyan, _brandEmerald],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverListDelegate([
                  const _Header(),
                  const SizedBox(height: 24),
                  const _StatsSection(),
                  const SizedBox(height: 32),
                  _ServicesGrid(services: services),
                  const SizedBox(height: 32),
                  const _CallToAction(),
                  const SizedBox(height: 16),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------
// Header Section
// -----------------------------
class _Header extends StatelessWidget {
  const _Header();

  static const Color _brandCyan = Color(0xFF06B6D4);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Card(
          elevation: 8,
          shadowColor: _brandCyan.withOpacity(0.20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFF8FAFC)],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _brandCyan.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '🌟 Premium Travel Services',
                    style: TextStyle(
                      color: _brandCyan,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Crafting Extraordinary Journeys',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E293B),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Text(
                    'We specialize in creating unforgettable travel experiences with personalized service, exclusive partnerships, and attention to every detail. Let us turn your travel dreams into reality.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF64748B),
                      height: 1.6,
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
// Stats Section (overflow-proof)
// -----------------------------
class _StatsSection extends StatelessWidget {
  const _StatsSection();

  static const Color _brandCyan = Color(0xFF06B6D4);

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('50K+', 'Happy Travelers', '🎉'),
      ('150+', 'Destinations', '🌍'),
      ('24/7', 'Support', '💬'),
      ('15+', 'Years Experience', '⭐'),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: LayoutBuilder(
          builder: (context, c) {
            // Use Wrap so tiles flow naturally on any width
            final double tileMinWidth = 220; // prevents squish on small phones
            final double spacing = 16;

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _brandCyan.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Wrap(
                spacing: spacing,
                runSpacing: spacing,
                alignment: WrapAlignment.spaceEvenly,
                children: stats
                    .map(
                      (s) => ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: tileMinWidth,
                          // dynamic max: half/third rows if wide
                          maxWidth: c.maxWidth >= 900
                              ? (c.maxWidth - spacing * 3) / 4
                              : c.maxWidth >= 600
                              ? (c.maxWidth - spacing) / 2
                              : c.maxWidth,
                        ),
                        child: _StatTile(value: s.$1, label: s.$2, emoji: s.$3),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.emoji,
  });
  final String value;
  final String label;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: const Color(0xFF06B6D4),
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// -----------------------------
// Services Grid (responsive, overflow-proof)
// -----------------------------
class _ServicesGrid extends StatelessWidget {
  final List<(String, String, String, List<String>)> services;

  const _ServicesGrid({required this.services});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double spacing = 16;
            // Breakpoints for columns
            final columns = constraints.maxWidth >= 1200
                ? 3
                : constraints.maxWidth >= 800
                ? 2
                : 1;

            final itemWidth =
                (constraints.maxWidth - (spacing * (columns - 1))) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: services
                  .map(
                    (service) => SizedBox(
                      width: itemWidth,
                      child: _ServiceCard(
                        icon: service.$1,
                        title: service.$2,
                        description: service.$3,
                        features: service.$4,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

// -----------------------------
// Enhanced Service Card
// -----------------------------
class _ServiceCard extends StatefulWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });

  final String icon;
  final String title;
  final String description;
  final List<String> features;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  bool _isHovered = false;
  bool _showDetails = false;

  void _toggleDetails() => setState(() => _showDetails = !_showDetails);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: _isHovered ? 12 : 6,
          shadowColor: _brandCyan.withOpacity(0.30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFF8FAFC)],
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and Title Row (wrap-safe)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_brandCyan, _brandEmerald],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: _brandCyan.withOpacity(0.28),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          widget.icon,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.title,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B),
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  widget.description,
                  softWrap: true,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),

                // Expandable Features Section
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState: _showDetails
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: const SizedBox.shrink(),
                  secondChild: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _brandCyan.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _brandCyan.withOpacity(0.12),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Service Features:',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0E7490), // darker cyan
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...widget.features.map(
                              (feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      margin: const EdgeInsets.only(top: 6),
                                      decoration: const BoxDecoration(
                                        color: _brandCyan,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        softWrap: true,
                                        style: const TextStyle(
                                          color: Color(0xFF475569),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
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
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),

                // Learn More Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _toggleDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showDetails
                          ? const Color(0xFF334155)
                          : _brandCyan,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            _showDetails ? 'Hide Details' : 'Learn More',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          _showDetails
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 18,
                        ),
                      ],
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
// Call to Action Section (responsive)
// -----------------------------
class _CallToAction extends StatelessWidget {
  const _CallToAction();

  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '051-6150748');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _navigateToContact(BuildContext context) {
    Navigator.pushNamed(context, '/contact');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_brandCyan, _brandEmerald],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _brandCyan.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            children: [
              const Text('🚀', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              Text(
                'Ready to Start Your Journey?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: const Text(
                  'Contact our travel experts today and let us create an unforgettable experience tailored just for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Buttons wrap instead of fixed row → never overflows
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () => _navigateToContact(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _brandCyan,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: _launchPhone,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70, width: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Call Us',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper class for SliverList
class SliverListDelegate extends SliverChildListDelegate {
  SliverListDelegate(List<Widget> children) : super(children);
}
