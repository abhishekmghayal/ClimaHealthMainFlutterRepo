import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'SignupScreen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _shape1Animation;
  late Animation<Offset> _shape2Animation;
  late Animation<Offset> _shape3Animation;
  late Animation<Offset> _shape4Animation;

  late Animation<double> _logoFade;
  late Animation<double> _titleFade;
  late Animation<double> _subtitleFade;
  late Animation<double> _descFade;
  late Animation<double> _loginFade;
  late Animation<double> _signupFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // Slide from Top-Right (x: 1.0, y: -1.0) to actual position (Offset.zero)
    const beginOffset = Offset(1.0, -1.0);
    const endOffset = Offset.zero;

    _shape1Animation = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2, curve: Curves.easeOut)),
    );
    _shape2Animation = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.35, curve: Curves.easeOut)),
    );
    _shape3Animation = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.5, curve: Curves.easeOut)),
    );
    _shape4Animation = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.45, 0.65, curve: Curves.easeOut)),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.65, 0.75, curve: Curves.easeIn)),
    );
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.7, 0.8, curve: Curves.easeIn)),
    );
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.75, 0.85, curve: Curves.easeIn)),
    );
    _descFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 0.9, curve: Curves.easeIn)),
    );
    _loginFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.85, 0.95, curve: Curves.easeIn)),
    );
    _signupFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.9, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1F4),
      body: Stack(
        children: [
          // Background shapes
          Positioned(
            top: 50,
            left: -250,
            child: SlideTransition(
              position: _shape1Animation,
              child: Transform.rotate(
                angle: -0.785, // -45 degrees
                child: Container(
                  width: 1000,
                  height: 250,
                  color: const Color(0xFF3AA79B),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: -300,
            child: SlideTransition(
              position: _shape2Animation,
              child: Transform.rotate(
                angle: -0.785,
                child: Container(
                  width: 800,
                  height: 350,
                  color: const Color(0xFFD6DFE3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -100,
            child: SlideTransition(
              position: _shape3Animation,
              child: Transform.rotate(
                angle: -0.785,
                child: Container(
                  width: 500,
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A8A80),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(-5, -5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: SlideTransition(
              position: _shape4Animation,
              child: Transform.rotate(
                angle: -0.785,
                child: Container(
                  width: 450,
                  height: 350,
                  color: const Color(0xFF0C524C),
                ),
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _logoFade,
                      child: Image.asset(
                        'assets/images/climaai.png',
                        width: 180,
                        height: 180,
                        color: const Color(0xFF0C524C).withOpacity(0.9), // apply tint color
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeTransition(
                      opacity: _titleFade,
                      child: const Text(
                        'ClimaHealth',
                        style: TextStyle(
                          color: Color(0xFF0C524C),
                          fontSize: 35,
                          fontFamily: "PlayFair",
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FadeTransition(
                      opacity: _subtitleFade,
                      child: const Text(
                        "Let's get started",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeTransition(
                      opacity: _descFade,
                      child: Center(
                        child: SizedBox(
                          width: 450,
                          child: const Text(
                            "Login to enjoy the features we've provided, and stay healthy!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: _loginFade,
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF147B72),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    FadeTransition(
                      opacity: _signupFade,
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF147B72),
                            side: const BorderSide(color: Color(0xFF147B72)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}