import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'TravelHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Login successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TravelHomePageApp()),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message
      String errorMsg;
      switch (e.code) {
        case 'user-not-found':
          errorMsg = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMsg = 'Wrong password provided.';
          break;
        default:
          errorMsg = 'Error: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showForgotPasswordDialog() {
    final TextEditingController forgotEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Password Recovery"),
        content: TextField(
          controller: forgotEmailController,
          decoration: const InputDecoration(
            labelText: "Enter your registered email",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () async {
              Navigator.pop(context);
              try {
                await _auth.sendPasswordResetEmail(email: forgotEmailController.text.trim());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Recovery email sent.")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${e.toString()}")),
                );
              }
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TravelLovers"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/picture5.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome to TravelLovers",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800],
                      ),
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: showForgotPasswordDialog,
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: isLoading ? null : loginUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Login"),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                          onPressed: null,
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                          onPressed: null,
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                          onPressed: null,
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
