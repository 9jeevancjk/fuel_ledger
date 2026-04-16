// SEO + HIGH CONVERSION LANDING PAGE (Premium SaaS Ready)
// Includes: CTA optimization, SEO structure, trust sections, conversion focus

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final router = GoRouter(
//       routes: [
//         GoRoute(path: '/', builder: (context, state) => const HomePage()),
//       ],
//     );

//     return Consumer<ThemeProvider>(
//       builder: (context, theme, child) {
//         return MaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           title: 'FuelLedger - Petrol Pump Management Software',
//           theme: theme.lightTheme,
//           routerConfig: router,
//         );
//       },
//     );
//   }
// }

// class ThemeProvider extends ChangeNotifier {
//   ThemeData get lightTheme => ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFF8FAFC),
//         fontFamily: 'Poppins',
//         useMaterial3: true,
//       );
// }

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;

          return SingleChildScrollView(
            child: Column(
              children: [
                Navbar(isMobile: isMobile),
                HeroSection(isMobile: isMobile),
                TrustSection(),
                DashboardPreview(isMobile: isMobile),
                PricingSection(isMobile: isMobile),
                CTASection(),
                FAQSection(),
                const Footer(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// NAVBAR
class Navbar extends StatelessWidget {
  final bool isMobile;
  const Navbar({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("FuelLedger", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          if (!isMobile)
            Row(children: const [Text("Features"), SizedBox(width: 20), Text("Pricing")])
          else
            const Icon(Icons.menu)
        ],
      ),
    );
  }
}

// HERO (SEO optimized headline)
class HeroSection extends StatelessWidget {
  final bool isMobile;
  const HeroSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF0EA5E9), Color(0xFF6366F1)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Petrol Pump Management Software",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 20),
          Text("Manage fuel sales, inventory, and accounting in one powerful platform.",
              style: TextStyle(color: Colors.white70)),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

// TRUST SECTION (conversion booster)
class TrustSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: const [
          Text("Trusted by Fuel Station Owners", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Used across multiple fuel stations for reliable daily operations")
        ],
      ),
    );
  }
}

// DASHBOARD
class DashboardPreview extends StatelessWidget {
  final bool isMobile;
  const DashboardPreview({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(4, (index) => card()),
      ),
    );
  }

  Widget card() {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
      ),
      child: const Text("Live Metric"),
    );
  }
}

// PRICING
class PricingSection extends StatelessWidget {
  final bool isMobile;
  const PricingSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text("Pricing", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            children: const [
              PricingCard("Basic", "₹999"),
              PricingCard("Pro", "₹1999"),
              PricingCard("Enterprise", "₹2999"),
            ],
          )
        ],
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  const PricingCard(this.title, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: const Text("Get Started"))
        ],
      ),
    );
  }
}

// CTA (high conversion)
class CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.black,
      child: Column(
        children: [
          const Text("Start Managing Your Fuel Station Today",
              style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Book Free Demo"))
        ],
      ),
    );
  }
}

// FAQ (SEO important)
class FAQSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: const [
          Text("FAQs", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text("Q: Is it cloud based? A: Yes"),
          Text("Q: Does it support HPCL/BPCL? A: Yes"),
        ],
      ),
    );
  }
}

// FOOTER
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.black,
      child: const Center(
        child: Text("© 2026 FuelLedger", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
