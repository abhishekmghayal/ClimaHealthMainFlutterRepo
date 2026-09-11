import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Adjust based on your actual imports
import 'LoginScreen.dart';
import 'icons/eva_icons.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1F4),
      body: Stack(
        children: [
          // --- BACKGROUND ELEMENTS ---
          Positioned(
            top: -100,
            left: -250,
            child: Container(
              width: 450,
              height: 700,
              decoration: BoxDecoration(
                color: const Color(0xFF0C524C),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(225),
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: 120,
            child: Container(
              width: 320,
              height: 500,
              decoration: BoxDecoration(
                color: const Color(0xFF3AA79B).withOpacity(0.15),
                borderRadius: BorderRadius.circular(175),
              ),
            ),
          ),
          Positioned(
            top: -200,
            left: 0,
            child: Container(
              width: 280,
              height: 500,
              decoration: BoxDecoration(
                color: const Color(0xFF3AA79B).withOpacity(0.3),
                borderRadius: BorderRadius.circular(175),
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: -250,
            child: Container(
              width: 200,
              height: 600,
              decoration: const BoxDecoration(
                color: Color(0xFFD3E4E2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -200,
            right: -150,
            child: Container(
              width: 320,
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFF0C524C),
                borderRadius: BorderRadius.circular(275),
              ),
            ),
          ),
          Positioned(
            bottom: -550,
            left: 100,
            child: Container(
              width: 250,
              height: 800,
              decoration: BoxDecoration(
                color: const Color(0xFF3AA79B).withOpacity(0.4),
                borderRadius: BorderRadius.circular(300),
              ),
            ),
          ),

          // --- FOREGROUND ELEMENTS ---
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Join with Us',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: "Intera",
                                color: Color(0xFF0C524C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 370,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF147B72),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIcon: const Icon(FontAwesome.users_solid),
                                    prefixIconColor: Colors.black,
                                    hintText: "Enter your full name",
                                    hintStyle: const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color:Color(0xFF147B72),
                                          width: 3
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2
                                        )
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 370,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                    labelText: 'Mobile No',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF147B72),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIcon: const Icon(FontAwesome.mobile_solid),
                                    prefixIconColor: Colors.black,
                                    hintText: "Enter your Mobile Number",
                                    hintStyle: const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color:Color(0xFF147B72),
                                          width: 3
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2
                                        )
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 370,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF147B72),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIcon: const Icon(Icons.email),
                                    prefixIconColor: Colors.black,
                                    hintText: "Enter your email",
                                    hintStyle: const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color:Color(0xFF147B72),
                                          width: 3
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2
                                        )
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 370,
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF147B72),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIcon: const Icon(FontAwesome.lock_solid),
                                    prefixIconColor: Colors.black,
                                    hintText: "Enter your password",
                                    hintStyle: const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color:Color(0xFF147B72),
                                          width: 3
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2
                                        )
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 370,
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF147B72),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIcon: const Icon(Icons.confirmation_num),
                                    prefixIconColor: Colors.black,
                                    hintText: "Confirm your password",
                                    hintStyle: const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: const BorderSide(
                                          color:Color(0xFF147B72),
                                          width: 3
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2
                                        )
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFF147B72),
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFF147B72)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: "Already have the Account? ",
                                style: const TextStyle(color: Colors.black, fontSize: 18),
                                children: [
                                  TextSpan(
                                      text: 'Login With Account.',
                                      style: const TextStyle(
                                        color: Color(0xFF147B72),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const LoginScreen(),
                                              ));
                                        }),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "SignUp With",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF147B72),
                                  fontFamily: "Intera",
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    child: ElevatedButton.icon(
                                      onPressed: null,
                                      icon: const Icon(
                                        FontAwesome.google_brand,
                                        color: Color(0xFF147B72),
                                      ),
                                      label: const Text(
                                        "Google",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF147B72),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Color(0xFF147B72)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    child: ElevatedButton.icon(
                                      onPressed: null,
                                      icon: const Icon(
                                        FontAwesome.facebook_brand,
                                        color: Color(0xFF147B72),
                                      ),
                                      label: const Text(
                                        "Facebook",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF147B72),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Color(0xFF147B72)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    child: ElevatedButton.icon(
                                      onPressed: null,
                                      icon: const Icon(
                                        FontAwesome.twitter_brand,
                                        color: Color(0xFF147B72),
                                      ),
                                      label: const Text(
                                        "Twitter",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF147B72),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Color(0xFF147B72)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}