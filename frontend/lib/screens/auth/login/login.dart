import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:watch2learn/screens/auth/regestration/registration.dart';
import 'package:watch2learn/screens/dashboard/dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2B),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isSmall = constraints.maxWidth < 950;

            return Row(
              children: [
                // LEFT ILLUSTRATION (hidden on small screens)
                if (!isSmall)
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      child: Container(
                        color: Colors.white, // background behind image
                        child: Center(
                          child: Image.asset(
                            "lib/screens/auth/login/assets/login_img.png",
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                // RIGHT PANEL (Sign in form)
                Expanded(
                  flex: 2,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                    color: const Color(0xFF0A0F2B),
                    child: Center(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TITLE
                              const Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),

                              // REGISTER TEXT
                              RichText(
                                text: TextSpan(
                                  text: "If you don't have an account register ",
                                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: "Register here !",
                                      style: const TextStyle(
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35),

                              // EMAIL FIELD
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  hintText: "Enter your email address",
                                  hintStyle:
                                      const TextStyle(color: Colors.white38),
                                  filled: true,
                                  fillColor: const Color(0xFF101430),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // PASSWORD FIELD
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  hintText: "Enter your Password",
                                  hintStyle:
                                      const TextStyle(color: Colors.white38),
                                  filled: true,
                                  fillColor: const Color(0xFF101430),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // REMEMBER + FORGOT
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: false, onChanged: (_) {}),
                                      const Text("Remember me",
                                          style: TextStyle(
                                              color: Colors.white70)),
                                    ],
                                  ),
                                  const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.pinkAccent),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              // LOGIN BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const DashboardScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pinkAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 35),

                              // OR CONTINUE
                              const Center(
                                child: Text(
                                  "or continue with",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // SOCIAL BUTTONS
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.facebook,
                                      color: Colors.white, size: 28),
                                  SizedBox(width: 30),
                                  Icon(Icons.g_mobiledata,
                                      color: Colors.white, size: 34),
                                  SizedBox(width: 30),
                                  Icon(Icons.apple,
                                      color: Colors.white, size: 28),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
