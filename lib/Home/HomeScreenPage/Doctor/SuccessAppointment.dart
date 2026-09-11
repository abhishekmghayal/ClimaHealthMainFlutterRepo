import 'package:climahealth/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessAppointment extends StatefulWidget {
  final String doctorName;
  final String date;
  final String time;

  const SuccessAppointment({
    super.key,
    required this.doctorName,
    required this.date,
    required this.time,
  });

  @override
  State<SuccessAppointment> createState() => _SuccessAppointmentState();
}

class _SuccessAppointmentState extends State<SuccessAppointment>
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
        MaterialPageRoute(builder: (context)=>Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF147B72).withOpacity(0.12),
          automaticallyImplyLeading: false

      ),
      body: Container(
        child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFF147B72).withOpacity(0.12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //TODO:Success Animation
                  Lottie.asset(
                    'assets/animations/Success.json',
                    controller: _controller,
                    width: 220,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() {
                          Future.delayed(const Duration(seconds: 1), () {
                            _goToHome();
                          });
                        });
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Appointment Confirmed!w",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 📦 Appointment Details Card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC6F1EC).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 80,),
                            Expanded(
                              child: Text(
                                widget.doctorName,
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const SizedBox(width: 125),
                            Text(widget.date,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const SizedBox(width: 115),
                            const SizedBox(width: 10),
                            Text(widget.time),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      )
    );
  }
}
