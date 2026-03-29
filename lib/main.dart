import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/auth_provider.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB-XVJjjQRPgioMNFJCoKcVKuDfgey3Kes",
      authDomain: "fuelledger-e563f.firebaseapp.com",
      projectId: "fuelledger-e563f",
      storageBucket: "fuelledger-e563f.appspot.com",
      messagingSenderId: "251616235945",
      appId: "1:251616235945:web:5c1e5e519d635cce4b74b8",
      measurementId: "G-KWLWG1WQZ3",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
