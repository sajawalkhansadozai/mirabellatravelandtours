// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';

// 👉 Import your real pages
import 'pages/home/home_page.dart';
import 'pages/about.dart';
import 'pages/services.dart';
import 'pages/destinations.dart';
import 'pages/gallery.dart';
import 'pages/testimonials.dart';
import 'pages/contact.dart';

// 👉 Admin (new)
import 'pages/admin.dart';

// ✅ NEW: E-Cab Division 1 page
import 'pages/e_cab_division1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MirabellaTravelApp());
}

class MirabellaTravelApp extends StatelessWidget {
  const MirabellaTravelApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirabella Travel & Tours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF667EEA),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF2D3748),
        ),
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: const AppShell(child: HomePage()),
      routes: {
        '/home': (_) => const AppShell(child: HomePage()),
        '/about': (_) => const AppShell(child: AboutPage()),
        '/services': (_) => const AppShell(child: ServicesPage()),
        '/destinations': (_) => const AppShell(child: DestinationsPage()),
        '/gallery': (_) => const AppShell(child: GalleryPage()),
        '/testimonials': (_) => const AppShell(child: TestimonialsPage()),
        '/contact': (_) => const AppShell(child: ContactPage()),
        // NEW: admin routes
        '/admin-login': (_) => const AdminLoginPage(),
        '/admin': (_) => const AdminPanelPage(),

        // ✅ NEW: E-Cab Division 1 route
        '/ecab': (_) => const AppShell(child: ECabDivision1Page()),
      },
    );
  }
}

/// Common shell with responsive AppBar (NO drawer / NO hamburger).
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _dropdownAnimationController;
  String _hoveredItem = '';
  bool _isDropdownOpen = false;

  // 🔐 Secret logo tap logic
  int _logoTapCount = 0;
  DateTime? _firstTapAt;

  static const _items = <_NavItem>[
    _NavItem(label: 'Home', route: '/home', icon: Icons.home_outlined),
    _NavItem(label: 'About', route: '/about', icon: Icons.info_outline),
    _NavItem(label: 'Services', route: '/services', icon: Icons.travel_explore),

    // ✅ NEW: E-Cab Division 1 item (appears in navbar + mobile menu)
    _NavItem(label: 'E-Cab', route: '/ecab', icon: Icons.electric_car),

    _NavItem(
      label: 'Destinations',
      route: '/destinations',
      icon: Icons.place_outlined,
    ),
    _NavItem(
      label: 'Gallery',
      route: '/gallery',
      icon: Icons.photo_library_outlined,
    ),
    _NavItem(
      label: 'Reviews',
      route: '/testimonials',
      icon: Icons.star_outline,
    ),
    _NavItem(
      label: 'Contact',
      route: '/contact',
      icon: Icons.contact_mail_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _dropdownAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _dropdownAnimationController.dispose();
    super.dispose();
  }

  void _logNavigationEvent(String pageName) {
    FirebaseAnalytics.instance.logEvent(
      name: 'page_view',
      parameters: {
        'page_name': pageName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Count 5 taps within 2 seconds to open admin login
  void _handleLogoTap() {
    final now = DateTime.now();
    if (_firstTapAt == null ||
        now.difference(_firstTapAt!) > const Duration(seconds: 2)) {
      _firstTapAt = now;
      _logoTapCount = 1;
    } else {
      _logoTapCount += 1;
    }

    if (_logoTapCount >= 5) {
      _logoTapCount = 0;
      _firstTapAt = null;
      Navigator.of(context).pushNamed('/admin-login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 1024;

    return Scaffold(
      appBar: _buildEnhancedAppBar(context, isWide),
      body: widget.child,
      floatingActionButton: _buildEnhancedContactFAB(context),
    );
  }

  PreferredSizeWidget _buildEnhancedAppBar(BuildContext context, bool isWide) {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      title: _buildEnhancedAppBarTitle(),
      centerTitle: false,
      actions: isWide
          ? _buildDesktopNavigation(context)
          : _buildMobileActionsDropdown(context),
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedAppBarTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Enhanced logo with glow effect
        GestureDetector(
          onTap: _handleLogoTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 56,
            width: 56,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF667EEA),
                        Color(0xFF764BA2),
                        Color(0xFF667EEA),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.travel_explore,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ).createShader(bounds),
                child: const Text(
                  'Mirabella Travel',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    letterSpacing: 0.5,
                    height: 1.1,
                  ),
                ),
              ),
              const Text(
                '& Tours',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF718096),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  letterSpacing: 0.3,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDesktopNavigation(BuildContext context) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: _items
              .map((item) => _buildEnhancedNavButton(context, item))
              .toList(),
        ),
      ),
      const SizedBox(width: 20),
    ];
  }

  // Mobile/Tablet popup menu (no header item)
  List<Widget> _buildMobileActionsDropdown(BuildContext context) {
    return [
      Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA).withOpacity(0.1),
              const Color(0xFF764BA2).withOpacity(0.1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: PopupMenuButton<_NavItem>(
          tooltip: 'Navigation Menu',
          position: PopupMenuPosition.under,
          constraints: const BoxConstraints(minWidth: 280, maxWidth: 320),
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          onOpened: () {
            setState(() => _isDropdownOpen = true);
            _dropdownAnimationController.forward();
          },
          onCanceled: () {
            setState(() => _isDropdownOpen = false);
            _dropdownAnimationController.reverse();
          },
          itemBuilder: (ctx) => _items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final currentRoute = ModalRoute.of(context)?.settings.name;
            final isActive = currentRoute == item.route;

            return PopupMenuItem<_NavItem>(
              value: item,
              height: 56,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200 + (index * 50)),
                curve: Curves.easeOutBack,
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: isActive
                      ? const Color(0xFF667EEA).withOpacity(0.15)
                      : Colors.transparent,
                  border: isActive
                      ? Border.all(
                          color: const Color(0xFF667EEA).withOpacity(0.3),
                          width: 1.5,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF667EEA)
                            : const Color(0xFF667EEA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item.icon,
                        size: 18,
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item.label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isActive
                              ? const Color(0xFF667EEA)
                              : const Color(0xFF2D3748),
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (isActive)
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF667EEA),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
          onSelected: (item) {
            setState(() => _isDropdownOpen = false);
            _dropdownAnimationController.reverse();
            final currentRoute = ModalRoute.of(context)?.settings.name;
            if (currentRoute != item.route) {
              _logNavigationEvent(item.label);
              Navigator.of(context).pushReplacementNamed(item.route);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            child: AnimatedRotation(
              turns: _isDropdownOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.menu_rounded,
                color: Color(0xFF667EEA),
                size: 28,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildEnhancedNavButton(BuildContext context, _NavItem item) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == item.route;
    final isHovered = _hoveredItem == item.label;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredItem = item.label),
        onExit: (_) => setState(() => _hoveredItem = ''),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          transform: Matrix4.identity()
            ..scale(isHovered && !isActive ? 1.08 : 1.0),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              splashColor: const Color(0xFF667EEA).withOpacity(0.2),
              highlightColor: const Color(0xFF667EEA).withOpacity(0.1),
              onTap: () {
                if (!isActive) {
                  _logNavigationEvent(item.label);
                  Navigator.of(context).pushReplacementNamed(item.route);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: isActive
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF667EEA).withOpacity(0.15),
                            const Color(0xFF764BA2).withOpacity(0.15),
                          ],
                        )
                      : isHovered
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF667EEA).withOpacity(0.08),
                            const Color(0xFF764BA2).withOpacity(0.08),
                          ],
                        )
                      : null,
                  border: isActive
                      ? Border.all(
                          color: const Color(0xFF667EEA).withOpacity(0.4),
                          width: 1.5,
                        )
                      : null,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : isHovered
                      ? [
                          BoxShadow(
                            color: const Color(0xFF667EEA).withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      transform: Matrix4.identity()
                        ..scale(isActive ? 1.1 : 1.0),
                      child: Icon(
                        item.icon,
                        size: 19,
                        color: isActive
                            ? const Color(0xFF667EEA)
                            : isHovered
                            ? const Color(0xFF4A5568)
                            : const Color(0xFF718096),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: isActive
                            ? const Color(0xFF667EEA)
                            : isHovered
                            ? const Color(0xFF4A5568)
                            : const Color(0xFF718096),
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                      child: Text(item.label),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedContactFAB(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton.extended(
        onPressed: () {
          _logNavigationEvent('Contact_FAB');
          Navigator.of(context).pushReplacementNamed('/contact');
        },
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
        elevation: 3,
        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
        label: const Text(
          'Chat with us',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.route,
    required this.icon,
  });
  final String label;
  final String route;
  final IconData icon;
}
