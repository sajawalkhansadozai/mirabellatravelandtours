// lib/pages/contact.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  // ---- Brand palette (aligned with other pages) ----
  static const Color _brandCyan = Color(0xFF06B6D4);
  static const Color _brandEmerald = Color(0xFF10B981);
  static const Color _ink900 = Color(0xFF0B1220);

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _destination = TextEditingController();
  final _message = TextEditingController();
  final _company = TextEditingController();

  String _selectedTravelType = 'Leisure Travel';
  String _selectedBudgetRange = 'PKR 100,000 – PKR 300,000';
  String _selectedTravelDate = 'Next 3 months';
  int _selectedTravelers = 2;

  bool _isSubmitting = false;

  // Firebase readiness flag: null = checking, true = ready, false = not ready
  bool? _firebaseReady;

  late AnimationController _successAnimationController;
  late AnimationController _errorAnimationController;
  late Animation<double> _successAnimation;
  late Animation<double> _errorAnimation;

  final List<String> _travelTypes = const [
    'Leisure Travel',
    'Business Travel',
    'Adventure Travel',
    'Luxury Travel',
    'Group Travel',
    'Honeymoon',
    'Family Vacation',
    'Solo Travel',
  ];

  // Budget ranges in PKR (moderate tiers)
  final List<String> _budgetRanges = const [
    'Under PKR 100,000',
    'PKR 100,000 – PKR 300,000',
    'PKR 300,000 – PKR 700,000',
    'PKR 700,000 – PKR 1,500,000',
    'PKR 1,500,000 – PKR 3,000,000',
    'Above PKR 3,000,000',
  ];

  final List<String> _travelDates = const [
    'Next 30 days',
    'Next 3 months',
    'Next 6 months',
    'Next year',
    'Flexible dates',
  ];

  @override
  void initState() {
    super.initState();

    _successAnimationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _errorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _successAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _successAnimationController,
        curve: Curves.bounceOut,
      ),
    );
    _errorAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _errorAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    _ensureFirebaseReady(); // proactively check firebase (no banner shown)
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _destination.dispose();
    _message.dispose();
    _company.dispose();
    _successAnimationController.dispose();
    _errorAnimationController.dispose();
    super.dispose();
  }

  /// Ensure Firebase is initialized; set [_firebaseReady] accordingly.
  Future<void> _ensureFirebaseReady() async {
    setState(() => _firebaseReady = null); // checking
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      // Touch Firestore and catch missing config early
      FirebaseFirestore.instance;
      setState(() => _firebaseReady = true);
    } catch (_) {
      setState(() => _firebaseReady = false);
    }
  }

  Future<void> _submitToFirebase() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) return;

    // Ensure Firebase is ready; retry init if needed
    if (_firebaseReady != true) {
      await _ensureFirebaseReady();
    }
    if (_firebaseReady != true) {
      _showSnackbar(
        'Firebase is not configured/connected. Please set up Firebase to enable form submissions.',
        isError: true,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final refId =
          'MT${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      await FirebaseFirestore.instance.collection('contact_inquiries').add({
        'referenceId': refId,
        'name': _name.text.trim(),
        'email': _email.text.trim(),
        'phone': _phone.text.trim(),
        'company': _company.text.trim(),
        'destination': _destination.text.trim(),
        'message': _message.text.trim(),
        'travelType': _selectedTravelType,
        'budgetRange': _selectedBudgetRange,
        'travelDate': _selectedTravelDate,
        'numberOfTravelers': _selectedTravelers,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'new',
      });

      // Success animation then dialog
      await _successAnimationController.forward();
      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) _showSuccessDialog(refId);
    } catch (_) {
      // Error animation then dialog
      await _errorAnimationController.forward();
      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) _showErrorDialog();
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _successAnimationController.reset();
        _errorAnimationController.reset();
      }
    }
  }

  void _showSuccessDialog(String refId) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 16),
              Text(
                'Success!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your inquiry has been submitted successfully.\n\nReference ID: $refId',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _clearForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 16),
              Text(
                'Failed!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Unable to submit your inquiry. Please check your connection and try again.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Retry'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _copyContactInfo();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Copy Info'),
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

  void _copyContactInfo() {
    Clipboard.setData(
      const ClipboardData(
        text:
            'Email: info@mirabellatravelandtours.com\nPhone: 051-6150748\nWebsite: www.mirabellatravelandtours.com',
      ),
    );
    _showSnackbar('Contact information copied!');
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _name.clear();
    _email.clear();
    _phone.clear();
    _destination.clear();
    _message.clear();
    _company.clear();
    setState(() {
      _selectedTravelType = 'Leisure Travel';
      _selectedBudgetRange = 'PKR 100,000 – PKR 300,000';
      _selectedTravelDate = 'Next 3 months';
      _selectedTravelers = 2;
    });
  }

  void _showSnackbar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : _brandEmerald,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().length < 2) return 'Enter your full name';
    return null;
  }

  String? _validateEmail(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validateMessage(String? v) {
    if (v == null || v.trim().length < 10) {
      return 'Please describe your travel plans (min 10 characters)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Responsive shell: safe, scrollable, and overflow-proof
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: _ink900,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                // Adaptive width: slightly wider on desktops
                final maxFormWidth = constraints.maxWidth >= 1280
                    ? 760.0
                    : constraints.maxWidth >= 900
                    ? 680.0
                    : constraints.maxWidth >= 600
                    ? 560.0
                    : 520.0;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    // keep room when keyboard shows on small screens
                    16 + (viewInsets > 0 ? viewInsets * 0.35 : safeBottom),
                  ),
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxFormWidth),
                      child: Column(
                        children: [
                          // Header
                          _CardContainer(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [_brandCyan, _brandEmerald],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.travel_explore,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Plan Your Dream Trip',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: _ink900,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Tell us about your travel plans and we\'ll create the perfect experience for you.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: const Color(0xFF64748B),
                                        height: 1.5,
                                      ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Form
                          _CardContainer(
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _ModernTextField(
                                    controller: _name,
                                    label: 'Full Name',
                                    icon: Icons.person_outline,
                                    validator: _validateName,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.name],
                                  ),
                                  const SizedBox(height: 14),

                                  // Email + Phone row, collapses gracefully on tiny widths
                                  LayoutBuilder(
                                    builder: (context, c) {
                                      final isNarrow = c.maxWidth < 420;
                                      if (isNarrow) {
                                        return Column(
                                          children: [
                                            _ModernTextField(
                                              controller: _email,
                                              label: 'Email',
                                              icon: Icons.email_outlined,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: _validateEmail,
                                              textInputAction:
                                                  TextInputAction.next,
                                              autofillHints: const [
                                                AutofillHints.email,
                                              ],
                                            ),
                                            const SizedBox(height: 14),
                                            _ModernTextField(
                                              controller: _phone,
                                              label: 'Phone (Optional)',
                                              icon: Icons.phone_outlined,
                                              keyboardType: TextInputType.phone,
                                              textInputAction:
                                                  TextInputAction.next,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9+\-\s]'),
                                                ),
                                              ],
                                              autofillHints: const [
                                                AutofillHints.telephoneNumber,
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: _ModernTextField(
                                              controller: _email,
                                              label: 'Email',
                                              icon: Icons.email_outlined,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: _validateEmail,
                                              textInputAction:
                                                  TextInputAction.next,
                                              autofillHints: const [
                                                AutofillHints.email,
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: _ModernTextField(
                                              controller: _phone,
                                              label: 'Phone (Optional)',
                                              icon: Icons.phone_outlined,
                                              keyboardType: TextInputType.phone,
                                              textInputAction:
                                                  TextInputAction.next,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9+\-\s]'),
                                                ),
                                              ],
                                              autofillHints: const [
                                                AutofillHints.telephoneNumber,
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 14),
                                  _ModernTextField(
                                    controller: _company,
                                    label: 'Company (Optional)',
                                    icon: Icons.business_outlined,
                                    textInputAction: TextInputAction.next,
                                  ),

                                  const SizedBox(height: 20),
                                  Text(
                                    'Travel Preferences',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: _ink900,
                                        ),
                                  ),
                                  const SizedBox(height: 12),

                                  // Travel Type + Budget  (FIXED: no Expanded under Column)
                                  LayoutBuilder(
                                    builder: (context, c) {
                                      final isNarrow = c.maxWidth < 420;

                                      if (!isNarrow) {
                                        // Wide: Row with Expanded
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: _ModernDropdown(
                                                label: 'Travel Type',
                                                value: _selectedTravelType,
                                                items: _travelTypes,
                                                onChanged: (v) => setState(
                                                  () => _selectedTravelType =
                                                      v ?? _selectedTravelType,
                                                ),
                                                icon: Icons.flight_takeoff,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: _ModernDropdown(
                                                label: 'Budget Range',
                                                value: _selectedBudgetRange,
                                                items: _budgetRanges,
                                                onChanged: (v) => setState(
                                                  () => _selectedBudgetRange =
                                                      v ?? _selectedBudgetRange,
                                                ),
                                                icon: Icons.attach_money,
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                      // Narrow: Column (NO Expanded)
                                      return Column(
                                        children: [
                                          _ModernDropdown(
                                            label: 'Travel Type',
                                            value: _selectedTravelType,
                                            items: _travelTypes,
                                            onChanged: (v) => setState(
                                              () => _selectedTravelType =
                                                  v ?? _selectedTravelType,
                                            ),
                                            icon: Icons.flight_takeoff,
                                          ),
                                          const SizedBox(height: 12),
                                          _ModernDropdown(
                                            label: 'Budget Range',
                                            value: _selectedBudgetRange,
                                            items: _budgetRanges,
                                            onChanged: (v) => setState(
                                              () => _selectedBudgetRange =
                                                  v ?? _selectedBudgetRange,
                                            ),
                                            icon: Icons.attach_money,
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  // When + Travelers  (FIXED: no Expanded under Column)
                                  LayoutBuilder(
                                    builder: (context, c) {
                                      final isNarrow = c.maxWidth < 420;

                                      if (!isNarrow) {
                                        // Wide: Row with Expanded
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: _ModernDropdown(
                                                label: 'When',
                                                value: _selectedTravelDate,
                                                items: _travelDates,
                                                onChanged: (v) => setState(
                                                  () => _selectedTravelDate =
                                                      v ?? _selectedTravelDate,
                                                ),
                                                icon: Icons.calendar_today,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: _buildTravelersSelector(),
                                            ),
                                          ],
                                        );
                                      }

                                      // Narrow: Column (NO Expanded)
                                      return Column(
                                        children: [
                                          _ModernDropdown(
                                            label: 'When',
                                            value: _selectedTravelDate,
                                            items: _travelDates,
                                            onChanged: (v) => setState(
                                              () => _selectedTravelDate =
                                                  v ?? _selectedTravelDate,
                                            ),
                                            icon: Icons.calendar_today,
                                          ),
                                          const SizedBox(height: 12),
                                          _buildTravelersSelector(),
                                        ],
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 12),
                                  _ModernTextField(
                                    controller: _destination,
                                    label: 'Preferred Destination',
                                    icon: Icons.location_on_outlined,
                                    hint: 'e.g., Hunza, Skardu, Fairy Meadows',
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [
                                      AutofillHints.addressCity,
                                    ],
                                  ),

                                  const SizedBox(height: 12),
                                  _ModernTextField(
                                    controller: _message,
                                    label: 'Tell us about your dream trip',
                                    icon: Icons.edit_outlined,
                                    maxLines: 4,
                                    validator: _validateMessage,
                                    textInputAction: TextInputAction.done,
                                  ),

                                  const SizedBox(height: 22),

                                  // Submit Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: _isSubmitting
                                          ? null
                                          : _submitToFirebase,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _brandCyan,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: _isSubmitting
                                          ? const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.white),
                                                  ),
                                                ),
                                                SizedBox(width: 12),
                                                Text('Submitting...'),
                                              ],
                                            )
                                          : const Text(
                                              'Send Inquiry',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'We\'ll get back to you within 24 hours',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: const Color(0xFF64748B),
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Contact Info
                          _CardContainer(
                            padding: const EdgeInsets.all(16),
                            child: const Column(
                              children: [
                                _ContactInfoHeader(),
                                SizedBox(height: 12),
                                _ContactInfoItem(
                                  icon: Icons.email_outlined,
                                  title: 'Email',
                                  subtitle: 'info@mirabellatravelandtours.com',
                                ),
                                SizedBox(height: 10),
                                _ContactInfoItem(
                                  icon: Icons.phone_outlined,
                                  title: 'Phone',
                                  subtitle: '051-6150748',
                                ),
                                SizedBox(height: 10),
                                _ContactInfoItem(
                                  icon: Icons.access_time,
                                  title: 'Hours',
                                  subtitle: 'Mon–Fri: 9AM–6PM',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Loading / Success / Error overlay
            if (_isSubmitting) _buildAnimationOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationOverlay() {
    return Container(
      color: Colors.black26,
      child: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_successAnimation, _errorAnimation]),
          builder: (context, child) {
            if (_successAnimation.value > 0) {
              return Transform.scale(
                scale: _successAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 40),
                ),
              );
            } else if (_errorAnimation.value > 0) {
              return Transform.scale(
                scale: _errorAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 40),
                ),
              );
            } else {
              return Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(strokeWidth: 3),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTravelersSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Travelers',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: _ink900,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(Icons.group, color: Colors.grey[600], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$_selectedTravelers',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              IconButton(
                onPressed: _selectedTravelers > 1
                    ? () => setState(() => _selectedTravelers--)
                    : null,
                icon: Icon(Icons.remove, size: 18, color: Colors.grey[700]),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              IconButton(
                onPressed: _selectedTravelers < 20
                    ? () => setState(() => _selectedTravelers++)
                    : null,
                icon: Icon(Icons.add, size: 18, color: Colors.grey[700]),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- Small helper widgets (responsive/overflow-safe) ----------

class _CardContainer extends StatelessWidget {
  const _CardContainer({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
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
      child: child,
    );
  }
}

class _ModernTextField extends StatelessWidget {
  const _ModernTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.hint,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final String? hint;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1220),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: _ContactPageState._brandCyan,
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }
}

class _ModernDropdown extends StatelessWidget {
  const _ModernDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.icon,
  });

  final String label;
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1220),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: _ContactPageState._brandCyan,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _ContactInfoHeader extends StatelessWidget {
  const _ContactInfoHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Other Ways to Reach Us',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: const Color(0xFF0B1220),
      ),
    );
  }
}

// Contact Info Item Widget (overflow-safe, uses provided icon)
class _ContactInfoItem extends StatelessWidget {
  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                _ContactPageState._brandCyan,
                _ContactPageState._brandEmerald,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1220),
                ),
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
