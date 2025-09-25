// lib/pages/admin.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ------------------------------
/// ADMIN LOGIN
/// ------------------------------
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  bool _showPassword = false;
  String? _error;
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
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/admin');
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message ?? 'Authentication failed');
    } catch (_) {
      setState(() => _error = 'Authentication failed');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFF667EEA)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isSmallScreen ? double.infinity : 450,
                    ),
                    child: Card(
                      elevation: 24,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Color(0xFFFAFBFC)],
                          ),
                        ),
                        padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo/Icon with animation
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF667EEA),
                                      Color(0xFF764BA2),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF667EEA,
                                      ).withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.admin_panel_settings_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Title
                              Text(
                                'Admin Portal',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF2D3748),
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Secure access to your dashboard',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: const Color(0xFF718096)),
                              ),
                              const SizedBox(height: 32),

                              // Email Field
                              _buildTextField(
                                controller: _email,
                                label: 'Email Address',
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  final value = v?.trim() ?? '';
                                  if (value.isEmpty) return 'Email is required';
                                  final re = RegExp(
                                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                  );
                                  if (!re.hasMatch(value))
                                    return 'Enter a valid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // Password Field
                              _buildTextField(
                                controller: _password,
                                label: 'Password',
                                icon: Icons.lock_outline_rounded,
                                obscureText: !_showPassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: const Color(0xFF718096),
                                  ),
                                  onPressed: () => setState(
                                    () => _showPassword = !_showPassword,
                                  ),
                                ),
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Password is required'
                                    : null,
                              ),
                              const SizedBox(height: 24),

                              // Error Message
                              if (_error != null)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.red.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.red.shade600,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _error!,
                                          style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: _busy ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF667EEA),
                                    foregroundColor: Colors.white,
                                    elevation: 8,
                                    shadowColor: const Color(
                                      0xFF667EEA,
                                    ).withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: _busy
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Sign In to Dashboard',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Footer
                              Text(
                                'Mirabella Travel Admin',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: const Color(0xFF9CA3AF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF667EEA)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF7FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red.shade300, width: 2),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFF718096),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// ------------------------------
/// ADMIN PANEL
/// ------------------------------
class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;
  int _totalInquiries = 0;
  int _newInquiries = 0;
  int _inReviewInquiries = 0;
  int _contactedInquiries = 0;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () => setState(() {}));
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/admin-login');
  }

  void _updateStats(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    _totalInquiries = docs.length;
    _newInquiries = docs
        .where((d) => (d.data()['status'] ?? 'new') == 'new')
        .length;
    _inReviewInquiries = docs
        .where((d) => d.data()['status'] == 'in_review')
        .length;
    _contactedInquiries = docs
        .where((d) => d.data()['status'] == 'contacted')
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 900;

    // If someone opens /admin without auth, bounce to login.
    if (user == null) {
      Future.microtask(() {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/admin-login');
        }
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context, user, isSmallScreen),
      body: Column(
        children: [
          // Stats Cards
          _buildStatsSection(),

          // Search Bar
          _buildSearchSection(isSmallScreen),

          // Inquiries List
          Expanded(child: _buildInquiriesList(isSmallScreen)),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    User user,
    bool isSmallScreen,
  ) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3748),
                ),
              ),
              if (!isSmallScreen)
                Text(
                  'Mirabella Travel & Tours',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ],
      ),
      actions: [
        if (!isSmallScreen)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 16,
                  color: const Color(0xFF667EEA),
                ),
                const SizedBox(width: 6),
                Text(
                  user.email?.split('@').first ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF667EEA),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: IconButton(
            tooltip: 'Sign out',
            onPressed: _signOut,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.red.shade600,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;
          return isNarrow
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Total',
                            _totalInquiries,
                            Icons.inbox_rounded,
                            const Color(0xFF667EEA),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            'New',
                            _newInquiries,
                            Icons.fiber_new_rounded,
                            Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'In Review',
                            _inReviewInquiries,
                            Icons.rate_review_rounded,
                            Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            'Contacted',
                            _contactedInquiries,
                            Icons.check_circle_rounded,
                            Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Inquiries',
                        _totalInquiries,
                        Icons.inbox_rounded,
                        const Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'New',
                        _newInquiries,
                        Icons.fiber_new_rounded,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'In Review',
                        _inReviewInquiries,
                        Icons.rate_review_rounded,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Contacted',
                        _contactedInquiries,
                        Icons.check_circle_rounded,
                        Colors.blue,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchCtrl,
          decoration: InputDecoration(
            hintText: isSmallScreen
                ? 'Search inquiries...'
                : 'Search by name, email, phone, reference ID, or any field...',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF667EEA),
            ),
            suffixIcon: _searchCtrl.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchCtrl.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: Color(0xFF9CA3AF),
                    ),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInquiriesList(bool isSmallScreen) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('contact_inquiries')
          .orderBy('timestamp', descending: true)
          .limit(500)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget('Error loading inquiries');
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF667EEA)),
          );
        }

        final docs = snapshot.data!.docs;
        _updateStats(docs);

        final q = _searchCtrl.text.trim().toLowerCase();
        final filtered = q.isEmpty
            ? docs
            : docs.where((d) {
                final m = d.data();
                return [
                      m['referenceId'],
                      m['name'],
                      m['email'],
                      m['phone'],
                      m['company'],
                      m['destination'],
                      m['message'],
                      m['travelType'],
                      m['budgetRange'],
                      m['travelDate'],
                      m['status'],
                      (m['numberOfTravelers']?.toString() ?? ''),
                    ]
                    .whereType<String>()
                    .map((s) => s.toLowerCase())
                    .any((s) => s.contains(q));
              }).toList();

        if (filtered.isEmpty) {
          return _buildEmptyWidget(
            q.isEmpty ? 'No inquiries yet' : 'No results found',
          );
        }

        return isSmallScreen
            ? _buildMobileList(filtered)
            : _buildDesktopTable(filtered);
      },
    );
  }

  Widget _buildMobileList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: docs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => _InquiryCard(
        id: docs[i].id,
        data: docs[i].data(),
        onStatusChanged: (s) => _updateStatus(docs[i].id, s),
      ),
    );
  }

  Widget _buildDesktopTable(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          headingRowHeight: 60,
          dataRowHeight: 80,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            fontSize: 14,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          columns: const [
            DataColumn(label: Text('Reference')),
            DataColumn(label: Text('Contact')),
            DataColumn(label: Text('Travel Details')),
            DataColumn(label: Text('Budget & Date')),
            DataColumn(label: Text('Message')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Submitted')),
          ],
          rows: docs.map((d) {
            final m = d.data();
            final ts = (m['timestamp'] as Timestamp?)?.toDate();
            final timeStr = ts == null
                ? '—'
                : '${ts.day}/${ts.month}/${ts.year}\n${ts.hour}:${ts.minute.toString().padLeft(2, '0')}';

            return DataRow(
              cells: [
                DataCell(
                  _buildTableCell(
                    m['referenceId']?.toString() ?? '—',
                    subtitle: m['name']?.toString(),
                  ),
                ),
                DataCell(
                  _buildTableCell(
                    m['email']?.toString() ?? '—',
                    subtitle: m['phone']?.toString(),
                  ),
                ),
                DataCell(
                  _buildTableCell(
                    m['travelType']?.toString() ?? '—',
                    subtitle:
                        '${m['numberOfTravelers'] ?? '—'} travelers → ${m['destination'] ?? '—'}',
                  ),
                ),
                DataCell(
                  _buildTableCell(
                    m['budgetRange']?.toString() ?? '—',
                    subtitle: m['travelDate']?.toString(),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 200,
                    child: Text(
                      m['message']?.toString() ?? '—',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                DataCell(
                  _StatusDropdown(
                    value: (m['status']?.toString() ?? 'new'),
                    onChanged: (s) => _updateStatus(d.id, s),
                  ),
                ),
                DataCell(
                  Text(
                    timeStr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTableCell(String primary, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          primary,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red.shade600,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(String message) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF667EEA).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inbox_rounded,
                color: Color(0xFF667EEA),
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchCtrl.text.isNotEmpty
                  ? 'Try adjusting your search terms'
                  : 'New inquiries will appear here',
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStatus(String docId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('contact_inquiries')
          .doc(docId)
          .update({'status': newStatus});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Text('Status updated to "$newStatus"'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Failed to update status'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  static const _options = <Map<String, dynamic>>[
    {
      'value': 'new',
      'label': 'New',
      'color': Colors.green,
      'icon': Icons.fiber_new_rounded,
    },
    {
      'value': 'in_review',
      'label': 'In Review',
      'color': Colors.orange,
      'icon': Icons.rate_review_rounded,
    },
    {
      'value': 'contacted',
      'label': 'Contacted',
      'color': Colors.blue,
      'icon': Icons.contact_phone_rounded,
    },
    {
      'value': 'closed',
      'label': 'Closed',
      'color': Colors.grey,
      'icon': Icons.check_circle_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentOption = _options.firstWhere(
      (option) => option['value'] == value,
      orElse: () => _options[0],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (currentOption['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (currentOption['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox.shrink(),
        isDense: true,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: currentOption['color'],
          size: 18,
        ),
        items: _options.map((option) {
          return DropdownMenuItem<String>(
            value: option['value'],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(option['icon'], color: option['color'], size: 16),
                const SizedBox(width: 6),
                Text(
                  option['label'],
                  style: TextStyle(
                    color: option['color'],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
        style: TextStyle(
          color: currentOption['color'],
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// Compact card for narrow screens
class _InquiryCard extends StatelessWidget {
  const _InquiryCard({
    required this.id,
    required this.data,
    required this.onStatusChanged,
  });

  final String id;
  final Map<String, dynamic> data;
  final ValueChanged<String> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final ts = (data['timestamp'] as Timestamp?)?.toDate();
    final timeStr = ts == null
        ? '—'
        : '${ts.day}/${ts.month}/${ts.year} at ${ts.hour}:${ts.minute.toString().padLeft(2, '0')}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF667EEA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    data['referenceId']?.toString() ?? '—',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF667EEA),
                    ),
                  ),
                ),
                const Spacer(),
                _StatusDropdown(
                  value: (data['status']?.toString() ?? 'new'),
                  onChanged: onStatusChanged,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Name & Contact
            Text(
              data['name']?.toString() ?? '—',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            _buildInfoRow(Icons.email_rounded, data['email']?.toString()),
            _buildInfoRow(Icons.phone_rounded, data['phone']?.toString()),

            const Divider(height: 24, color: Color(0xFFE5E7EB)),

            // Travel Details
            _buildInfoRow(Icons.travel_explore, data['travelType']?.toString()),
            _buildInfoRow(Icons.place_rounded, data['destination']?.toString()),
            _buildInfoRow(
              Icons.calendar_today_rounded,
              data['travelDate']?.toString(),
            ),
            _buildInfoRow(
              Icons.group_rounded,
              '${data['numberOfTravelers'] ?? '—'} travelers',
            ),
            _buildInfoRow(
              Icons.attach_money_rounded,
              data['budgetRange']?.toString(),
            ),

            const SizedBox(height: 12),

            // Message
            if (data['message']?.toString().isNotEmpty == true) ...[
              const Text(
                'Message',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  data['message']?.toString() ?? '—',
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Footer
            Row(
              children: [
                Icon(Icons.schedule_rounded, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  timeStr,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6B7280)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
