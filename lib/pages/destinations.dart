// lib/pages/destinations.dart
import 'package:flutter/material.dart';

class DestinationsPage extends StatelessWidget {
  const DestinationsPage({super.key});

  // Brand palette (aligned with Services/Hero)
  static const Color _brandCyan = Color(0xFF06B6D4); // cyan
  static const Color _brandEmerald = Color(0xFF10B981); // emerald

  @override
  Widget build(BuildContext context) {
    // title, desc, price(PKR), rating, category, icon, imagePath
    const destinations = <(String, String, String, String, String, IconData, String)>[
      (
        'Hunza Valley',
        'Eagles Nest viewpoints, Baltit & Altit Forts, cherry blossoms, and vibrant local culture.',
        'From PKR 65,000',
        '⭐ 4.9 (1,240)',
        'Valley',
        Icons.terrain,
        'assets/destinations/hunza.jpg',
      ),
      (
        'Skardu & Shangrila',
        'Shangrila Lake, Upper Kachura, Cold Desert & gateway to the Karakoram.',
        'From PKR 85,000',
        '⭐ 4.8 (980)',
        'Lakes',
        Icons.landscape,
        'assets/destinations/skardu.jpg',
      ),
      (
        'Fairy Meadows',
        'UNESCO-listed meadows facing Nanga Parbat with alpine huts & magical sunsets.',
        'From PKR 75,000',
        '⭐ 4.9 (760)',
        'Meadows',
        Icons.grass,
        'assets/destinations/fairy_meadows.jpg',
      ),
      (
        'Naran & Kaghan',
        'Saif-ul-Malook Lake, Babusar Top, rafting in Kunhar and scenic drives.',
        'From PKR 55,000',
        '⭐ 4.7 (1,150)',
        'Lakes',
        Icons.water,
        'assets/destinations/naran_kaghan.jpg',
      ),
      (
        'Swat Valley',
        'Malam Jabba chairlifts, waterfalls and lush green valleys.',
        'From PKR 50,000',
        '⭐ 4.6 (890)',
        'Valley',
        Icons.eco,
        'assets/destinations/swat.jpg',
      ),
      (
        'Murree & Patriata',
        'Classic hills, cable car at Patriata and pine forest walks.',
        'From PKR 30,000',
        '⭐ 4.5 (1,420)',
        'Hills',
        Icons.forest,
        'assets/destinations/murree.jpg',
      ),
      (
        'Neelum Valley (AJK)',
        'Keran, Sharda & Arrang Kel—emerald rivers and cedar-lined villages.',
        'From PKR 60,000',
        '⭐ 4.8 (740)',
        'Valley',
        Icons.park,
        'assets/destinations/neelum.jpg',
      ),
      (
        'Attabad Lake (Gojal)',
        'Turquoise lake, boats & glass-bridge views near Passu Cones.',
        'From PKR 70,000',
        '⭐ 4.8 (670)',
        'Lakes',
        Icons.sailing,
        'assets/destinations/attabad.jpg',
      ),
      (
        'Shogran & Siri Paye',
        'Golden meadows above the clouds with views of Makra Peak.',
        'From PKR 45,000',
        '⭐ 4.7 (680)',
        'Meadows',
        Icons.filter_hdr,
        'assets/destinations/shogran.jpg',
      ),
      (
        'Deosai National Park',
        'The Land of Giants—brown bears, rolling plateaus and wildflowers.',
        'From PKR 95,000',
        '⭐ 4.9 (520)',
        'National Park',
        Icons.nature_people,
        'assets/destinations/deosai.jpg',
      ),
      (
        'Rama Meadows',
        'Serene meadows near Astore with Rama Lake & Nanga Parbat vistas.',
        'From PKR 70,000',
        '⭐ 4.8 (440)',
        'Meadows',
        Icons.grass,
        'assets/destinations/rama.jpg',
      ),
      (
        'Gilgit City Break',
        'Local bazaars, viewpoints and a perfect hub for day trips.',
        'From PKR 40,000',
        '⭐ 4.6 (510)',
        'City',
        Icons.location_city,
        'assets/destinations/gilgit.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        // Gradient appbar background (color-aligned)
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_brandCyan, _brandEmerald],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Destinations',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.black26,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        // Soft, responsive background (very light aqua -> white)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0FDFA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.45],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1300),
              child: Column(
                children: [
                  const _Header(),
                  const SizedBox(height: 16),
                  _DestinationsGrid(destinations: destinations),
                  const SizedBox(height: 24),
                  const _CallToAction(),
                ],
              ),
            ),
          ),
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
    return Card(
      elevation: 8,
      shadowColor: _brandCyan.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _brandCyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                '✈️ DISCOVER THE NORTH',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: _brandCyan,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Extraordinary Destinations\nAwaiting Your Discovery',
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0A1828),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                'Embark on unforgettable journeys across the breathtaking northern areas of Pakistan—pristine lakes, alpine meadows and majestic peaks.',
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF178582),
                  height: 1.55,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------
// Destinations Grid (responsive / overflow-proof)
// -----------------------------
class _DestinationsGrid extends StatelessWidget {
  const _DestinationsGrid({required this.destinations});

  final List<(String, String, String, String, String, IconData, String)>
  destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;

        // Breakpoints: 4 / 3 / 2 / 1 columns
        final columns = w >= 1280
            ? 4
            : w >= 1000
            ? 3
            : w >= 700
            ? 2
            : 1;

        // Taller cards on narrower screens to prevent overflow
        final aspect = columns >= 4
            ? 1.12
            : columns == 3
            ? 1.00
            : columns == 2
            ? 0.92
            : 0.78;

        // Fewer description lines when space is tight
        final descMaxLines = columns >= 4
            ? 3
            : columns == 3
            ? 3
            : columns == 2
            ? 3
            : 4;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: aspect,
          ),
          itemCount: destinations.length,
          itemBuilder: (context, i) {
            final d = destinations[i];
            return _DestinationCard(
              title: d.$1,
              description: d.$2,
              price: d.$3,
              rating: d.$4,
              category: d.$5,
              icon: d.$6,
              imagePath: d.$7,
              descriptionMaxLines: descMaxLines,
            );
          },
        );
      },
    );
  }
}

// -----------------------------
// Destination Card (overflow-proof)
// -----------------------------
class _DestinationCard extends StatefulWidget {
  const _DestinationCard({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.icon,
    required this.imagePath,
    this.descriptionMaxLines = 3,
  });

  final String title;
  final String description;
  final String price;
  final String rating;
  final String category;
  final IconData icon;
  final String imagePath;

  // adaptive lines from grid
  final int descriptionMaxLines;

  @override
  State<_DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<_DestinationCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 160),
  );
  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.97,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  bool _fav = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, __) => Transform.scale(
        scale: _scale.value,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapCancel: () => _controller.reverse(),
          onTapUp: (_) => _controller.reverse(),
          onTap: () => Navigator.of(context).pushReplacementNamed('/contact'),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 8,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFE2E8F0),
                            child: Icon(
                              widget.icon,
                              size: 52,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        // category badge
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Text(
                              widget.category,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0A1828),
                              ),
                            ),
                          ),
                        ),
                        // favorite
                        Positioned(
                          right: 10,
                          top: 10,
                          child: InkWell(
                            onTap: () => setState(() => _fav = !_fav),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.92),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _fav ? Icons.favorite : Icons.favorite_border,
                                color: _fav
                                    ? Colors.red
                                    : const Color(0xFF0A1828),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0A1828),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.rating,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF8500),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Flexible (loose) prevents height pressure/overflow
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            widget.description,
                            softWrap: true,
                            maxLines: widget.descriptionMaxLines,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.38,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // price + button row (never overflows)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.price,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF06B6D4), // brand cyan
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 36),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(
                                  context,
                                ).pushReplacementNamed('/contact'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF06B6D4),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Book Now',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
// Call to Action (responsive, color-aligned)
// -----------------------------
class _CallToAction extends StatelessWidget {
  const _CallToAction();

  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_brandCyan, _brandEmerald],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _brandCyan.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.flight_takeoff, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            'Ready for Your Next Adventure?',
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Get personalized recommendations and exclusive deals',
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.92),
            ),
          ),
          const SizedBox(height: 12),
          // Wrap so the button never overflows on narrow devices
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/contact'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _brandCyan,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black26,
                ),
                child: const Text(
                  'Plan My Trip',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
