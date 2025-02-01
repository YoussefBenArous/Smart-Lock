import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For social media icons.
import 'login.dart'; // Import the LoginScreen file.
import 'signup.dart'; // Import the SignUpScreen file.

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image
                Image.asset(
                  'assets/Image1.png', // Ensure the asset exists in your project.
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  'Welcome to Lockly, where you manage your home security.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the LoginScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),

                // Sign Up Button
                OutlinedButton(
                  onPressed: () {
                    // Navigate to the SignUpScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Social Media Sign-Up Text
                const Text(
                  'Sign up using',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),

                // Social Media Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      color: Colors.blue,
                      iconSize: 40,
                      onPressed: () {
                        // Add Facebook authentication logic
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      color: Colors.red,
                      iconSize: 40,
                      onPressed: () {
                        // Add Google authentication logic
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      color: Colors.blueAccent,
                      iconSize: 40,
                      onPressed: () {
                        // Add LinkedIn authentication logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
