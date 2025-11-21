import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                // ================================
                //   LEFT ILLUSTRATION (WHITE BOX)
                // ================================
                if (!isSmall)
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          "lib/screens/auth/login/assets/login_img.png",
                          width: 500,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                // ================================
                //   RIGHT FORM AREA
                // ================================
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
                              // ---------- TITLE ----------
                              Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: isSmall ? 28 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),

                              // --------- LOGIN LINK (CLICKABLE) ---------
                              RichText(
                                text: TextSpan(
                                  text: "If you already have an account register ",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: "Login here !",
                                      style: const TextStyle(
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 35),

                              // ---------- FULL NAME ----------
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
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

                              // ---------- ROLE DROPDOWN ----------
                              DropdownButtonFormField(
                                dropdownColor: const Color(0xFF101430),
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Role",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: const Color(0xFF101430),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: "Student",
                                      child: Text("Student")),
                                  DropdownMenuItem(
                                      value: "Parent", child: Text("Parent")),
                                ],
                                onChanged: (_) {},
                              ),

                              const SizedBox(height: 20),

                              // ---------- GRADE DROPDOWN ----------
                              DropdownButtonFormField(
                                dropdownColor: const Color(0xFF101430),
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Class / Grade",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: const Color(0xFF101430),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: List.generate(
                                  12,
                                  (i) => DropdownMenuItem(
                                    value: "Grade ${i + 1}",
                                    child: Text("Grade ${i + 1}"),
                                  ),
                                ),
                                onChanged: (_) {},
                              ),

                              const SizedBox(height: 30),

                              // ---------- NEXT BUTTON ----------
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pinkAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
