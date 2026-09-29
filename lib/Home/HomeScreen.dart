import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:climahealth/icons/eva_icons.dart';
import 'HomeScreenPage/Doctor/NearDoctorScreen.dart';
import 'HomeScreenPage/Services/AppointmentScreen.dart';
import 'HomeScreenPage/Services/FaqScreen.dart';
import 'HomeScreenPage/Services/SupportChatScreen.dart';
import 'HomeScreenPage/Services/VaccinationScreen.dart';
import 'HomeScreenPage/Doctor/DoctorDetailScreen.dart';
import 'HomeScreenPage/Specialisation/DoctorListScreen.dart';
import 'HomeScreenPage/Specialisation/SpecializeDoctorScreen.dart'; // for Doctor model

import 'package:climahealth/services/api_service.dart';

// UI REFACTOR ONLY: API AND BACKEND LOGIC PRESERVED

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String username = "";

  // Animation Controller for borders only
  late AnimationController _borderProgressController;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _loadUserName();

    // Endless Chasing Progress Border Animation
    _borderProgressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24), // Speed control
    )..repeat(); // Endless one-directional loop

    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _borderProgressController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _borderProgressController.dispose();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final fullName = await ApiService.getSavedFullName();

    if (!mounted) return;

    setState(() {
      username = fullName?.split(" ").first ?? "";
    });
  }

  Widget _buildDoctorSpecialisationCard(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFF147B72),
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorListScreen(specialization: title),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF147B72).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF147B72),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF147B72),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(
      BuildContext context,
      String image,
      String name,
      String education,
      ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xFF147B72),
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 180,
                    height: 160,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  education,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF147B72),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailScreen(
                        doctor: Doctor(
                          name: name,
                          specialization: education,
                          rating: 4.8,
                          distance: "800m away",
                          imagePath: image,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(4),
                  backgroundColor: Colors.teal,
                  elevation: 10,
                ),
                child: const Icon(
                  EvaIcons.arrowhead_up,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _serviceTile(String title, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF147B72),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Icon(
              Icons.north_east,
              size: 24,
              color: Color(0xFF3A6B6B),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.8),
      body: Stack(
        children: [
          // --- TOP LEFT BACKGROUND SHAPES ---
          Positioned(
            top: -190,
            left: 100,
            child: Transform.rotate(
              angle: 0.785,
              child: Container(
                width: 420,
                height: 400,
                color: const Color(0xFFF0F4F4).withOpacity(0.8),
              ),
            ),
          ),
          // Animated Progress Border 1
          Positioned(
            top: -160,
            left: 20,
            child: Transform.rotate(
              angle: 0.785,
              child: AnimatedShapeBorder(
                animation: _borderAnimation,
                width: 400,
                height: 400,
                strokeWidth: 15,
                trackColor: const Color(0xFF3AA79B).withOpacity(0.2),
              ),
            ),
          ),
          // Animated Progress Border 2
          Positioned(
            top: -120,
            left: -120,
            child: Transform.rotate(
              angle: 0.785,
              child: AnimatedShapeBorder(
                animation: _borderAnimation,
                width: 400,
                height: 400,
                strokeWidth: 8,
                trackColor: const Color(0xFF06544D).withOpacity(0.3),
              ),
            ),
          ),
          // Animated Progress Border 3
          Positioned(
            top: -50,
            left: -40,
            child: Transform.rotate(
              angle: 0.785,
              child: AnimatedShapeBorder(
                animation: _borderAnimation,
                width: 250,
                height: 250,
                strokeWidth: 2,
                trackColor: const Color(0xFF06544D).withOpacity(0.4),
              ),
            ),
          ),

          // --- STATIC LOGO (GLOW REMOVED) ---
          Center(
            child: Image.asset(
              'assets/images/climaai.png',
              width: 180,
              height: 180,
              color: const Color(0xFF0C524C).withOpacity(0.4),
            ),
          ),

          // --- BOTTOM RIGHT BACKGROUND SHAPES ---
          Positioned(
            bottom: -190,
            right: 100,
            child: Transform.rotate(
              angle: 0.785,
              child: Container(
                width: 420,
                height: 400,
                color: const Color(0xFFF0F4F4),
              ),
            ),
          ),
          Positioned(
            bottom: -160,
            right: 20,
            child: Transform.rotate(
              angle: 0.785,
              child: AnimatedShapeBorder(
                animation: _borderAnimation,
                width: 400,
                height: 400,
                strokeWidth: 15,
                trackColor: const Color(0xFF3AA79B).withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -120,
            child: Transform.rotate(
              angle: 0.785,
              child: AnimatedShapeBorder(
                animation: _borderAnimation,
                width: 400,
                height: 400,
                strokeWidth: 8,
                trackColor: const Color(0xFF06544D).withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -40,
            child: Transform.rotate(
              angle: 0.785,
              child: AnimatedShapeBorder(
                animation: _borderAnimation,
                width: 250,
                height: 250,
                strokeWidth: 2,
                trackColor: const Color(0xFF06544D).withOpacity(0.3),
              ),
            ),
          ),

          // --- FOREGROUND SCROLLABLE CONTENT ---
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: 60,
                              width: 280,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF147B72),
                                    Color(0xFF0C524C),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Hello $username 👋",
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Tinos",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            icon: const Icon(
                              EvaIcons.bell_outline,
                              size: 24,
                              color: Color(0xFF147B72),
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                              elevation: 6,
                              shadowColor: Colors.black26,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No Notification Available Right Now......"),
                                  backgroundColor: Color(0xFF147B72),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  EvaIcons.search_outline,
                                  color: Color(0xFF147B72),
                                  size: 22,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Start Typing...",
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Popular Specialisation",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Tinos"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SpecializedoctorScreen()),
                                  );
                                },
                                child: const Text(
                                  "See all",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF147B72),
                                    fontFamily: "Tinos",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Column(
                            children: [
                              _buildDoctorSpecialisationCard(
                                context,
                                Icons.heart_broken,
                                "Cardiologist",
                                "25 Doctors",
                              ),
                              const SizedBox(height: 10),
                              _buildDoctorSpecialisationCard(
                                context,
                                Icons.psychology,
                                "Neurologist",
                                "18 Doctors",
                              ),
                              const SizedBox(height: 10),
                              _buildDoctorSpecialisationCard(
                                context,
                                Icons.healing_rounded,
                                "Dermatologist",
                                "32 Doctors",
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Doctors Near You",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Tinos"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NearDoctorScreen()),
                                  );
                                },
                                child: const Text(
                                  "See all",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Tinos",
                                    color: Color(0xFF147B72),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.69,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildDoctorCard(
                                context,
                                "assets/images/doctor1.jpg",
                                "Dr. John",
                                "MBBS, MD",
                              ),
                              _buildDoctorCard(
                                context,
                                "assets/images/doctor1.jpg",
                                "Dr. Emma",
                                "MBBS, Cardio",
                              ),
                              _buildDoctorCard(
                                context,
                                "assets/images/doctor1.jpg",
                                "Dr. Smith",
                                "MBBS, Neuro",
                              ),
                              _buildDoctorCard(
                                context,
                                "assets/images/doctor1.jpg",
                                "Dr. Alex",
                                "MBBS, Dentist",
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Services",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Tinos"),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _serviceTile("Appointments", AppointmentScreen()),
                              const SizedBox(height: 10),
                              _serviceTile("Vaccination calendar", VaccinationScreen()),
                              const SizedBox(height: 10),
                              _serviceTile("FAQ", FaqScreen()),
                              const SizedBox(height: 10),
                              _serviceTile("Support chat", SupportChatScreen()),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ],
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

// -------------------------------------------------------------
// NEW CLASSES: For drawing the Endless Chasing Border
// -------------------------------------------------------------

class AnimatedShapeBorder extends AnimatedWidget {
  final double width;
  final double height;
  final double strokeWidth;
  final Color trackColor;

  const AnimatedShapeBorder({
    Key? key,
    required Animation<double> animation,
    required this.width,
    required this.height,
    required this.strokeWidth,
    required this.trackColor,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return CustomPaint(
      size: Size(width, height),
      painter: _BorderProgressPainter(
        progress: animation.value,
        trackColor: trackColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _BorderProgressPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final double strokeWidth;

  _BorderProgressPainter({
    required this.progress,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()..addRect(rect);

    // 1. Draw the static, faded track (base border)
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawPath(path, trackPaint);

    // 2. Continuous Color Pulse
    final colorProgress = (math.sin((progress * 2 * math.pi) - (math.pi / 2)) + 1) / 2;
    final activeColor = Color.lerp(
      const Color(0xFF44B08C), // Light Teal
      const Color(0xFF0C524C), // Dark Green
      colorProgress,
    )!;

    // 3. Setup the glowing chasing line
    final progressPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..strokeWidth = strokeWidth;

    // 4. Calculate exactly where the tail and head of the line should be
    for (final metric in path.computeMetrics()) {
      final double pathLength = metric.length;
      final double tailLength = pathLength * 0.35;

      final double headPosition = pathLength * progress;
      final double tailPosition = headPosition - tailLength;

      if (tailPosition < 0) {
        final wrapExtract = metric.extractPath(pathLength + tailPosition, pathLength);
        canvas.drawPath(wrapExtract, progressPaint);

        final headExtract = metric.extractPath(0.0, headPosition);
        canvas.drawPath(headExtract, progressPaint);
      } else {
        final extractPath = metric.extractPath(tailPosition, headPosition);
        canvas.drawPath(extractPath, progressPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BorderProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}