import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuel_ledger/core/colors.dart';
import 'package:fuel_ledger/pages/bank_page.dart';
import 'package:fuel_ledger/pages/home_page.dart';
import 'package:fuel_ledger/pages/report_page.dart';
import 'package:fuel_ledger/pages/sales_page.dart';
import 'package:fuel_ledger/pages/stock_page.dart';
import 'package:fuel_ledger/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
    const BankPage(),
  ];

  /// ================= SETTINGS =================
  void openSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFFF3F4F6),
          padding: const EdgeInsets.all(12),
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildSection(
                title: "Account",
                children: [
                  _buildTile(Icons.person, "Profile", () => showProfile()),
                  _buildTile(Icons.lock, "Change Password", changePassword),
                  _buildTile(Icons.group, "Manage Users", () => manageUsers(context)),
                ],
              ),
              _buildSection(
                title: "Fuel Configuration",
                children: [
                  _buildTile(Icons.local_gas_station, "Product Types",
                      () => showProductTypes(context)),
                  _buildTile(Icons.currency_rupee,
                      "Product Prices & Capacity",
                      () => showProdConfig(context)),
                ],
              ),
              _buildSection(
                title: "Company Info",
                children: [
                  _buildTile(Icons.business, "Company Details",
                      () => showCompanyDetails(context)),
                  _buildTile(Icons.image, "Upload Logo",
                      () => showUploadLogo(context)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// ================= PROFILE =================
  void showProfile() {
    final nameController = TextEditingController();
    final mobileController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: mobileController, decoration: const InputDecoration(labelText: "Mobile")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Save")),
        ],
      ),
    );
  }

  void changePassword() {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Change Password"),
        content: Text("Implement password change"),
      ),
    );
  }

  /// ================= USERS =================
  void manageUsers(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Manage Users",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () => showAddUserDialog(context),
                child: const Text("Add User"),
              ),
              _userTile("Jeevan Kumar", "Admin"),
            ],
          ),
        ),
      ),
    );
  }

  void showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Add User"),
        content: Text("Implement user form"),
      ),
    );
  }

  /// ================= PRODUCT =================
  void showProductTypes(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Product Types"),
        content: Text("Implement product CRUD"),
      ),
    );
  }

  void showProdConfig(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Fuel Config"),
        content: Text("Implement config form"),
      ),
    );
  }

  /// ================= COMPANY =================
  void showCompanyDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Company Details"),
        content: Text("Implement company form"),
      ),
    );
  }

  /// ================= LOGO =================
  void showUploadLogo(BuildContext context) {
    File? imageFile;
    bool loading = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickImage() async {
            final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (picked != null) {
              imageFile = File(picked.path);
              setState(() {});
            }
          }

          Future<void> uploadLogo() async {
            if (imageFile == null) return;

            setState(() => loading = true);

            final ref = FirebaseStorage.instance.ref().child("company/logo.png");
            await ref.putFile(imageFile!);

            final url = await ref.getDownloadURL();

            await FirebaseFirestore.instance
                .collection('settings')
                .doc('company')
                .set({"logo": url}, SetOptions(merge: true));

            setState(() => loading = false);

            // ignore: use_build_context_synchronously
            Navigator.pop(context);

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Logo Uploaded")));
          }

          return Dialog(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Upload Logo",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,
                      child: imageFile == null
                          ? const Icon(Icons.camera_alt)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: loading ? null : uploadLogo,
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Upload"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bpclPrimary,
        titleSpacing: 20,
        title: Row(
          children: const [
            Icon(Icons.local_gas_station),
            SizedBox(width: 10),
            Text("Fuel Ledger"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),

          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == "settings") openSettings();
              if (value == "logout") {
                await context.read<AuthProvider>().logout();
                if (!context.mounted) return;
                context.go("/");
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "settings", child: Text("Settings")),
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),

      body: Row(
        children: [
          NavigationRail(
            extended: false,
            selectedIndex: selectedIndex,
            onDestinationSelected: (i) => setState(() => selectedIndex = i),
indicatorColor: bpclSecondary,
            backgroundColor: bpclPrimary,

            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedIconTheme: const IconThemeData(color: Colors.white70),

            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard')),
              NavigationRailDestination(
                  icon: Icon(Icons.local_gas_station_outlined),
                  selectedIcon: Icon(Icons.local_gas_station),
                  label: Text('Sales')),
              NavigationRailDestination(
                  icon: Icon(Icons.storage_outlined),
                  selectedIcon: Icon(Icons.storage),
                  label: Text('Stock')),
              NavigationRailDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: Text('Reports')),
              NavigationRailDestination(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  selectedIcon: Icon(Icons.account_balance_wallet),
                  label: Text('Bank')),
            ],
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= HELPERS =================
Widget _buildSection(
    {required String title, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
      Card(child: Column(children: children)),
      const SizedBox(height: 10),
    ],
  );
}

Widget _buildTile(IconData icon, String title, void Function()? onTap) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: onTap,
  );
}

Widget _userTile(String name, String role) {
  return ListTile(
    leading: const CircleAvatar(child: Icon(Icons.person)),
    title: Text(name),
    subtitle: Text(role),
  );
}