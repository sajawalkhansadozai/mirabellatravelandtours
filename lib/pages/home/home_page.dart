import 'package:flutter/material.dart';
import 'package:mirabellatravelandtours/pages/home/hero_section.dart';

// Sections
import 'sections/stats_section.dart';
import 'sections/about_teaser_section.dart';
import 'sections/services_preview_section.dart';
import 'sections/why_choose_us_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeScrollView();
  }
}

class _HomeScrollView extends StatelessWidget {
  const _HomeScrollView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          HeroSection(),
          StatsSection(),
          AboutTeaserSection(),
          ServicesPreviewSection(),
          WhyChooseUsSection(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
