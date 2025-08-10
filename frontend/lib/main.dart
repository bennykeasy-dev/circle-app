// frontend/lib/main.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import the Supabase package

import 'screens/auth/signup_screen.dart'; // Import your signup screen

Future<void> main() async {
  // This ensures that all Flutter bindings are initialized before running async code.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with your project's specific credentials.
  // This connects your app to your backend.
  await Supabase.initialize(
    url: 'https://obswxupiuljlysivikye.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ic3d4dXBpdWxqbHlzaXdpa3llIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4MjMxMjAsImV4cCI6MjA3MDM5OTEyMH0.GZYEirphoW39zXwCQu41yOPnWSTi9bsByHGHYMzwYo8',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hides the debug banner in the top-right corner
      debugShowCheckedModeBanner: false, 
      title: 'Circle App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set the SignupScreen as the initial screen of the app
      home: const SignupScreen(),
    );
  }
}

// This is a global helper variable that gives you easy access
// to the Supabase client from anywhere in your app.
final supabase = Supabase.instance.client;