// frontend/lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase

// A shortcut to the Supabase client
final supabase = Supabase.instance.client;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  // The new signup handler using Supabase
  Future<void> _handleSignup() async {
    // Get the text from the fields
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    // Basic validation
    if (name.isEmpty || phone.isEmpty || password.isEmpty) {
        _showErrorSnackBar('Please fill all fields');
        return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Use the built-in Supabase.auth.signUp() function
      final AuthResponse res = await supabase.auth.signUp(
        // We will use the phone number as the email for authentication purposes
        // Supabase requires an email, but we can use the phone number in that field
        // if we enable phone signups. For now, this is the simplest way.
        email: '$phone@circleapp.com', // Create a dummy email from the phone number
        password: password,
        // 'data' is a special field for storing extra user information
        // that isn't part of the core auth schema, like a user's name.
        data: {'full_name': name},
      );
      
      // Check if signup was successful and we have a user
      if (res.user != null) {
        _showSuccessSnackBar('Success! Please check your email to verify.');
      } else {
        _showErrorSnackBar('An unexpected error occurred during signup.');
      }

    } on AuthException catch (e) {
      // Catch specific Supabase authentication errors
      _showErrorSnackBar(e.message);
    } catch (e) {
      // Catch any other general errors
      _showErrorSnackBar('An unexpected error occurred.');
    } finally {
      // This 'finally' block always runs, whether there was an error or not
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Helper functions to show snackbars
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _showSuccessSnackBar(String message) {
     if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ... The UI part (TextFields, etc.) is exactly the same
            const Text('Welcome to Circle!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            const SizedBox(height: 32),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(),),),
            const SizedBox(height: 16),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder(),), keyboardType: TextInputType.phone,),
            const SizedBox(height: 16),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(),), obscureText: true,),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16),),
                    child: const Text('Sign Up', style: TextStyle(fontSize: 18),),
                  ),
          ],
        ),
      ),
    );
  }
}