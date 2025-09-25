// lib/pages/gallery.dart
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Brand colors (aligned with Hero/Services)
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    // Pakistan Northern Areas destinations with comprehensive information (15 items)
    const items = [
      GalleryItem(
        title: 'Hunza Valley',
        subtitle: 'The Crown Jewel of Northern Pakistan',
        description:
            'Hunza Valley is renowned for its breathtaking mountain scenery, including views of Rakaposhi, Ultar Sar, and Hunza Peak. The valley is famous for its apricot blossoms in spring, ancient Baltit and Altit forts, and the longevity of its people. Located at an altitude of 2,438 meters, it offers spectacular views of Karakoram Range.',
        imagePath: 'assets/gallery/hunza.jpeg',
        location: 'Gilgit-Baltistan',
        elevation: '2,438m',
        bestTime: 'April to October',
        highlights: [
          'Baltit Fort',
          'Altit Fort',
          'Apricot Blossoms',
          'Rakaposhi View',
        ],
      ),
      GalleryItem(
        title: 'Skardu Valley',
        subtitle: 'Gateway to the World\'s Highest Peaks',
        description:
            'Skardu serves as the base camp for expeditions to K2, Broad Peak, and Gasherbrum peaks. The valley features stunning lakes like Satpara and Shangrila, dramatic landscapes, and serves as the administrative center of Baltistan.',
        imagePath: 'assets/gallery/skardu.jpg',
        location: 'Gilgit-Baltistan',
        elevation: '2,230m',
        bestTime: 'May to September',
        highlights: [
          'Shangrila Lake',
          'Satpara Lake',
          'K2 Base Camp Route',
          'Skardu Fort',
        ],
      ),
      GalleryItem(
        title: 'Fairy Meadows',
        subtitle: 'Base Camp to Nanga Parbat',
        description:
            'Fairy Meadows offers one of the most spectacular views of Nanga Parbat (8,126m), the world\'s ninth-highest mountain. This alpine meadow is accessible only by foot and provides an otherworldly landscape of lush green meadows against the backdrop of snow-capped peaks.',
        imagePath: 'assets/gallery/fairy_meadows.jpeg',
        location: 'Gilgit-Baltistan',
        elevation: '3,300m',
        bestTime: 'June to September',
        highlights: [
          'Nanga Parbat View',
          'Alpine Meadows',
          'Base Camp Trekking',
          'Star Gazing',
        ],
      ),
      GalleryItem(
        title: 'Deosai Plains',
        subtitle: 'The Roof of the World',
        description:
            'Deosai National Park is the second-highest plateau in the world, known as the "Land of Giants". During summer, the plateau is covered with wildflowers and is home to the Himalayan brown bear.',
        imagePath: 'assets/gallery/deosai.jpeg',
        location: 'Gilgit-Baltistan',
        elevation: '4,114m',
        bestTime: 'July to September',
        highlights: [
          'Himalayan Brown Bears',
          'Wildflower Fields',
          'Sheosar Lake',
          'High Altitude Plains',
        ],
      ),
      GalleryItem(
        title: 'Swat Valley',
        subtitle: 'Switzerland of Pakistan',
        description:
            'Swat Valley is known for its lush green landscapes, crystal-clear rivers, and snow-capped mountains. The valley has a rich cultural heritage with Buddhist archaeological sites and is famous for its hospitality.',
        imagePath: 'assets/gallery/swat.jpg',
        location: 'Khyber Pakhtunkhwa',
        elevation: '980m',
        bestTime: 'March to October',
        highlights: [
          'Malam Jabba Ski Resort',
          'Kalam Valley',
          'Ushu Forest',
          'Buddhist Stupas',
        ],
      ),
      GalleryItem(
        title: 'Kaghan Valley',
        subtitle: 'Land of Lakes and Waterfalls',
        description:
            'Kaghan Valley is a stunning alpine valley known for its pristine lakes, including the famous Saif-ul-Malook Lake. The valley offers spectacular views of snow-capped peaks, lush meadows, and waterfalls.',
        imagePath: 'assets/gallery/kaghan.jpg',
        location: 'Khyber Pakhtunkhwa',
        elevation: '2,800m',
        bestTime: 'May to September',
        highlights: [
          'Saif-ul-Malook Lake',
          'Lalazar Meadows',
          'Waterfalls',
          'Malka Parbat',
        ],
      ),
      GalleryItem(
        title: 'Chitral Valley',
        subtitle: 'Land of Polo and Kalash Culture',
        description:
            'Chitral is home to the unique Kalash culture and the highest polo ground in the world at Shandur Pass. The valley offers diverse landscapes from lush valleys to high mountain passes.',
        imagePath: 'assets/gallery/chitral.jpg',
        location: 'Khyber Pakhtunkhwa',
        elevation: '1,500m',
        bestTime: 'April to October',
        highlights: [
          'Kalash Valleys',
          'Shandur Polo Festival',
          'Chitral Fort',
          'Tirich Mir Peak',
        ],
      ),
      GalleryItem(
        title: 'Naran Valley',
        subtitle: 'Gateway to Spectacular Lakes',
        description:
            'Naran is a popular hill station and serves as the base for visiting the magnificent Saif-ul-Malook Lake. It\'s known for pleasant weather, pine forests and trout fishing.',
        imagePath: 'assets/gallery/naran.jpg',
        location: 'Khyber Pakhtunkhwa',
        elevation: '2,500m',
        bestTime: 'May to September',
        highlights: [
          'Lake Saif-ul-Malook',
          'Trout Fishing',
          'Pine Forests',
          'Trekking Trails',
        ],
      ),
      GalleryItem(
        title: 'Gilgit City',
        subtitle: 'Capital of Mountain Adventures',
        description:
            'Gilgit serves as the administrative center of Gilgit-Baltistan and is the gateway to the Karakoram, Hindukush and Himalayas. It offers rich cultural diversity and historical significance.',
        imagePath: 'assets/gallery/gilgit.jpg',
        location: 'Gilgit-Baltistan',
        elevation: '1,500m',
        bestTime: 'April to October',
        highlights: [
          'Three Mountain Ranges Junction',
          'Cultural Diversity',
          'Ancient Rock Carvings',
          'Suspension Bridge',
        ],
      ),
      // New items
      GalleryItem(
        title: 'Attabad Lake',
        subtitle: 'Turquoise Wonder of Gojal',
        description:
            'A stunning turquoise lake formed in 2010 near Gojal, Hunza. Popular for boating, jet-ski, and scenic drives along the Karakoram Highway.',
        imagePath: 'assets/gallery/attabad.jpg',
        location: 'Gilgit-Baltistan',
        elevation: '2,559m',
        bestTime: 'April to October',
        highlights: [
          'Boating',
          'Jet Ski',
          'Cliff Tunnels',
          'Passu Cones Views',
        ],
      ),
      GalleryItem(
        title: 'Passu Cones',
        subtitle: 'Cathedral Peaks of Hunza',
        description:
            'Iconic pointed peaks rising dramatically above the village of Passu. One of the most photographed sights in the Hunza Valley.',
        imagePath: 'assets/gallery/pussu_cones.jpeg',
        location: 'Gilgit-Baltistan',
        elevation: '6,106m (peak)',
        bestTime: 'April to October',
        highlights: [
          'Suspension Bridge',
          'Glacier Views',
          'Golden Hour',
          'Photography',
        ],
      ),
      GalleryItem(
        title: 'Khunjerab Pass',
        subtitle: 'High Mountain Border',
        description:
            'The highest paved international border crossing in the world between Pakistan and China, sitting on the Karakoram Highway.',
        imagePath: 'assets/gallery/khunjerab.jpg',
        location: 'Gilgit-Baltistan',
        elevation: '4,693m',
        bestTime: 'June to September',
        highlights: [
          'Snowy Vistas',
          'Marco Polo Sheep',
          'Border Gate',
          'Karakoram Highway',
        ],
      ),
      GalleryItem(
        title: 'Rama Meadows',
        subtitle: 'Serenity Near Astore',
        description:
            'Lush meadows with views of Nanga Parbat near Astore. A calm, green escape with a crystal lake and forest trails.',
        imagePath: 'assets/gallery/rama.jpg',
        location: 'Gilgit-Baltistan',
        elevation: '3,300m',
        bestTime: 'June to September',
        highlights: [
          'Rama Lake',
          'Pine Forests',
          'Nanga Parbat Views',
          'Camping',
        ],
      ),
      GalleryItem(
        title: 'Phander Valley',
        subtitle: 'Little Kashmir of Ghizer',
        description:
            'Known for its emerald river bends and serene Phander Lake. A peaceful valley perfect for picnics, fishing and long stays.',
        imagePath: 'assets/gallery/phander.jpg',
        location: 'Gilgit-Baltistan',
        elevation: '2,800m',
        bestTime: 'May to September',
        highlights: ['Phander Lake', 'Fishing', 'Village Walks', 'River Bends'],
      ),
      GalleryItem(
        title: 'Shandur Pass',
        subtitle: 'Roof of the World Polo Festival',
        description:
            'The highest polo ground in the world, hosting the famous Shandur Polo Festival every summer between Chitral and Gilgit teams.',
        imagePath: 'assets/gallery/shandur.jpg',
        location: 'Khyber Pakhtunkhwa / GB',
        elevation: '3,700m',
        bestTime: 'July (Festival)',
        highlights: [
          'Polo Festival',
          'High Meadows',
          'Camping',
          'Starry Nights',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFD),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_brandCyan, _brandEmerald],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Northern Pakistan Gallery',
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
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _Header(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final columns = w >= 1200
                          ? 3
                          : w >= 768
                          ? 2
                          : 1;

                      // Make cards taller as columns decrease (prevents overflow)
                      final aspect = columns == 3
                          ? 1.00
                          : columns == 2
                          ? 0.92
                          : 0.78;

                      // Description lines adapt with columns
                      final descLines = columns == 3
                          ? 3
                          : columns == 2
                          ? 3
                          : 4;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 24,
                          childAspectRatio: aspect,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _GalleryCard(
                            item: items[index],
                            descriptionMaxLines: descLines,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class GalleryItem {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath; // local asset path
  final String location;
  final String elevation;
  final String bestTime;
  final List<String> highlights;

  const GalleryItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.location,
    required this.elevation,
    required this.bestTime,
    required this.highlights,
  });
}

// -----------------------------
// Header Section (brand aligned + responsive)
// -----------------------------
class _Header extends StatelessWidget {
  const _Header();

  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isPhone = width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isPhone ? 36 : 48,
        horizontal: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brandCyan, _brandEmerald],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Northern Pakistan',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: isPhone ? 30 : 42,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore the Magnificent Beauty',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: isPhone ? 15 : 18,
            ),
          ),
          const SizedBox(height: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'Discover the breathtaking landscapes, majestic peaks, and rich cultural heritage of Pakistan\'s northern regions. From the towering peaks of Karakoram to the serene valleys of Hunza, experience the natural wonders that make this region truly extraordinary.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
                fontSize: isPhone ? 14 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Gallery Card (overflow-proof)
// -----------------------------
class _GalleryCard extends StatefulWidget {
  const _GalleryCard({required this.item, required this.descriptionMaxLines});
  final GalleryItem item;
  final int descriptionMaxLines;

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openDetailView(context, widget.item),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                  blurRadius: _isHovered ? 20 : 10,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          widget.item.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.landscape,
                                size: 48,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                        // Elevation badge
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.terrain,
                                  size: 12,
                                  color: Color(0xFF0EA5A4),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.item.elevation,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Content Section
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.item.subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Flexible (loose) prevents text from forcing overflow
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            widget.item.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                            maxLines: widget.descriptionMaxLines,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.item.bestTime,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xFF0EA5A4),
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

  void _openDetailView(BuildContext context, GalleryItem item) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: _DetailView(item: item),
      ),
    );
  }
}

// -----------------------------
// Detail View Dialog (responsive)
// -----------------------------
class _DetailView extends StatelessWidget {
  const _DetailView({required this.item});
  final GalleryItem item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPhone = size.width < 600;
    final maxW = size.width.clamp(320.0, 900.0);
    final maxH = size.height.clamp(400.0, 820.0);
    final imgH = isPhone ? size.height * 0.28 : 300.0;

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
        child: Material(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Large Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        item.imagePath,
                        width: double.infinity,
                        height: imgH,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: imgH,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.landscape,
                              size: 48,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.subtitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF06B6D4).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Color(0xFF06B6D4),
                                ),
                                SizedBox(width: 4),
                                // location text added below to avoid overflow here
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // location text placed on its own line to avoid row overflow
                      Row(
                        children: [
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.place,
                            size: 16,
                            color: Color(0xFF06B6D4),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              item.location,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF06B6D4),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _InfoChip(
                            icon: Icons.terrain,
                            label: 'Elevation',
                            value: item.elevation,
                          ),
                          _InfoChip(
                            icon: Icons.wb_sunny,
                            label: 'Best Time',
                            value: item.bestTime,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Highlights',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: item.highlights
                            .map(
                              (highlight) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  highlight,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF059669),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Footer Section
// -----------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Explore More of Pakistan',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Plan your next adventure to these incredible destinations. Experience the hospitality, culture, and natural beauty that make Pakistan\'s northern areas truly unforgettable.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '© 2025 Northern Pakistan Gallery. All rights reserved.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
