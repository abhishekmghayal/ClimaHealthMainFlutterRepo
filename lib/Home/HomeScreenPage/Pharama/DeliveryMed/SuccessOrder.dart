import 'package:climahealth/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessOrder extends StatefulWidget {
  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(




      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Lottie.asset(
                'assets/animations/Success.json',
                controller: _controller,
                width: 220,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(() {
                      Future.delayed(const Duration(microseconds: 1500 ), () {
                        _goToHome();
                      });
                    });
                },
              ),

              SizedBox(height: 20),

              /// Success Text
              Text(
                "Order Placed Successfully!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF147B72),
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Your medicines will arrive soon.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}