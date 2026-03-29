import 'package:flutter/material.dart';
import 'package:fuel_ledger/pages/home_page.dart';
import 'package:fuel_ledger/pages/report_page.dart';
import 'package:fuel_ledger/pages/sales_page.dart';
import 'package:fuel_ledger/pages/stock_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  final pages = [
    const HomePage(),
    const SalesPage(),
    const StockPage(),
    const ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 28,
            ),

            unselectedIconTheme: const IconThemeData(
              color: Colors.grey,
              size: 24,
            ),

            selectedLabelTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

            unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
            backgroundColor: const Color(0xFF111827),
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            labelType: NavigationRailLabelType.all,

            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Icon(Icons.local_gas_station, size: 40, color: Color(0xFF3B82F6)),
                  SizedBox(height: 10),
                  Text("Fuel Ledger"),
                ],
              ),
            ),

            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.local_gas_station),
                label: Text('Sales'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.storage),
                label: Text('Stock'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text('Reports'),
              ),
            ],
          ),

          const VerticalDivider(width: 1),

          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
