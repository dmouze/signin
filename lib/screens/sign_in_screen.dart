import 'package:flutter/material.dart';
import '../database/dbhelper.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  void _validateAndLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

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

    if (_emailError == null && _passwordError == null) {
      final user = await DatabaseHelper().loginUser(email, password);
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          _passwordError = 'Incorrect email or password';
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
            const SizedBox(height: 212),
            const Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 30,
                color: Colors.purple,
                fontWeight: FontWeight.w700,
                height: 1.21,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email or User Name',
                errorText: _emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
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
                hintText: 'Password',
                suffixIcon: const Icon(Icons.visibility),
                errorText: _passwordError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _validateAndLogin,
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Or sign in with',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.purple,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Image.network('https://img.icons8.com/color/48/000000/google-logo.png'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.network('https://img.icons8.com/color/48/000000/facebook-new.png'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.network('https://img.icons8.com/ios-filled/50/000000/twitter.png'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.network('https://img.icons8.com/ios-filled/50/000000/linkedin.png'),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign Up",
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}

void main() => runApp(const MaterialApp(home: LoginScreen()));
