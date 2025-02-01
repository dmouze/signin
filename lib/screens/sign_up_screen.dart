import 'package:flutter/material.dart';
import '../database/dbhelper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _registrationError;

  void _validateAndSignUp() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _registrationError = null;
    });

    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      setState(() {
        _emailError = 'Invalid email';
      });
    }

    if (password.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
    }

    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
    }

    if (_emailError == null && _passwordError == null && _confirmPasswordError == null) {
      try {
        await DatabaseHelper().registerUser(email, password);
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _registrationError = 'Registration failed. User may already exist.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.purple),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Back',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline, color: Colors.purple),
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.purple),
                hintText: 'Email',
                errorText: _emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.purple),
                hintText: 'Password',
                errorText: _passwordError,
                suffixIcon: const Icon(Icons.visibility, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.purple),
                hintText: 'Confirm Password',
                errorText: _confirmPasswordError,
                suffixIcon: const Icon(Icons.visibility, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
            if (_registrationError != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _registrationError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _validateAndSignUp,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: SignUpScreen()));
