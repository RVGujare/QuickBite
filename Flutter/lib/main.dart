import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_bite/auth/screens/tab_controller_screen.dart';
import 'package:quick_bite/auth/screens/welcome_screen.dart';
import 'package:quick_bite/initial_screen.dart';
import 'package:quick_bite/outlets/menu.dart';
import 'package:quick_bite/outlets/outlets_list.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final ThemeData appTheme = ThemeData(
    fontFamily: 'Lato',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 20),
      bodySmall: TextStyle(fontSize: 15),
      displayLarge: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickBite',
      theme: appTheme,
      // routes: appRoutes,
      home: InitialScreen(),
    );
  }
}
