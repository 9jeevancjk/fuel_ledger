import 'package:fuel_ledger/pages/dashboard/dashboard_page.dart';
import 'package:fuel_ledger/pages/onboarding/onboarding_page.dart';
import 'package:fuel_ledger/pages/website/landing_page.dart';
import 'package:fuel_ledger/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",

  routes: [
    GoRoute(path: '/', builder: (context, state) => const LandingPage()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnBoardingPage()),
    GoRoute(path: "/login", builder: (context, state) => LoginPage()),
    GoRoute(
      path: "/dashboard",
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
