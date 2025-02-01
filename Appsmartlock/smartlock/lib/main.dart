import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lock/FirstScreen.dart';
import 'package:lock/deleteuser.dart';
import 'package:lock/login.dart'; // Import the LoginScreen
import 'package:lock/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Lock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Start the app at the LoginScreen
      routes: {
        '/login': (context) => deleteuser(),
      },
    );
  }
}
