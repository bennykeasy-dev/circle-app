// frontend/lib/main.dart
import 'package:flutter/material.dart';
import 'screens/auth/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // We will create this screen next
      home: SignupScreen(),
    );
  }
}

// We will create this screen in another file.
// For now, let's just create a placeholder here so there are no errors.
class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Circle'),
      ),
      body: Center(
        child: Text('Signup Screen Coming Soon!'),
      ),
    );
  }
}