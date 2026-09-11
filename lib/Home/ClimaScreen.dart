import 'package:flutter/material.dart';
import 'dart:math';

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({super.key});

  @override
  State<ClimaScreen> createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  // Disease chips list
  final List<String> diseases = [
    "Dengue",
    "Malaria",
    "Back Pain",
    "Fever",
  ];

  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _floatingAnimation;

  // ClimaHealth Theme Colors
  static const Color primaryTeal = Color(0xFF147B72);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _floatingAnimation = Tween<double>(begin: 0.0, end: -12.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Continuous loop floating up and down
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildChip(String text, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1.5,
            color: isSelected ? primaryTeal : Colors.grey.shade300,
          ),
          color: isSelected ? primaryTeal.withOpacity(0.15) : Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? primaryTeal : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryTeal.withOpacity(0.04),
      body: Stack(
        children: [
          const Positioned(
            child: AnimatedNetworkBackground(),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 200),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    AnimatedBuilder(
                                      animation: _floatingAnimation,
                                      builder: (context, child) {
                                        return Transform.translate(
                                          offset: Offset(
                                              0, _floatingAnimation.value),
                                          child: Container(
                                            height: 195,
                                            width: 195,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: primaryTeal
                                                      .withOpacity(0.3),
                                                  blurRadius: 40,
                                                  spreadRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: Image.asset(
                                              "assets/images/climaai.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      top: -20,
                                      right: -50,
                                      child: AnimatedBuilder(
                                        animation: _floatingAnimation,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: Offset(
                                                0,
                                                _floatingAnimation.value *
                                                    0.6),
                                            child: child,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18),
                                              bottomRight: Radius.circular(18),
                                              bottomLeft: Radius.circular(0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.08),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Hi! I'm Clima!",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text("👋",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "Here To Help You",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 40),

                                // Subtitle / Prompt Header
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      height: 1.3,
                                    ),
                                    children: [
                                      TextSpan(text: "Your "),
                                      TextSpan(
                                        text: "✦ Smart Assistant ",
                                        style: TextStyle(color: primaryTeal),
                                      ),
                                      TextSpan(
                                          text: "\nfor Daily Health Tasks"),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 35),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Column(
                                children: [
                                  // Quick Selection Chips
                                  SizedBox(
                                      height: 42,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: diseases.length,
                                          itemBuilder: (context, index) {
                                            return buildChip(
                                                diseases[index], index);
                                          },
                                        ),
                                      )),

                                  const SizedBox(height: 35),

                                  // Bottom Input Field Bar
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryTeal.withOpacity(0.12),
                                          blurRadius: 20,
                                          offset: const Offset(0, 4),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                              "Message AI assistant...",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF0C524C),
                                                  fontWeight: FontWeight.w400
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 42,
                                          width: 42,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryTeal,
                                          ),
                                          child: const Icon(
                                            Icons.mic,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 25),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class AnimatedNetworkBackground extends StatefulWidget {
  const AnimatedNetworkBackground({Key? key}) : super(key: key);

  @override
  _AnimatedNetworkBackgroundState createState() => _AnimatedNetworkBackgroundState();
}

class _AnimatedNetworkBackgroundState extends State<AnimatedNetworkBackground> with SingleTickerProviderStateMixin {
  late AnimationController _bgcontroller;

  @override
  void initState(){
    super.initState();
    _bgcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose(){
    _bgcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NetworkPainter(animation: _bgcontroller),
      size: Size.infinite,
    );
  }
}

// 2. ✨ CHANGED: `CustomPaint` to `CustomPainter`
class NetworkPainter extends CustomPainter {
  final Animation<double> animation;
  static const Color primaryTeal = Color(0xFF147B72);
  static const Color secondaryTeal = Color(0xFF0C524C);

  NetworkPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final glowDotPaint = Paint()
      ..color = primaryTeal.withOpacity(0.9)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    final solidDotPaint = Paint()
      ..color = secondaryTeal
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;

    final List<Offset> baseNodes = [
      // Top Right Area
      Offset(w * 0.75, h * 0.05), Offset(w * 0.95, h * 0.10),
      Offset(w * 0.65, h * 0.15), Offset(w * 0.85, h * 0.22),
      Offset(w * 1.05, h * 0.25),
      // Middle Right Area
      Offset(w * 0.90, h * 0.35), Offset(w * 0.70, h * 0.40),
      Offset(w * 0.98, h * 0.48), Offset(w * 0.82, h * 0.55),
      Offset(w * 0.65, h * 0.60), Offset(w * 0.95, h * 0.65),
      // Bottom Right Area
      Offset(w * 0.75, h * 0.72), Offset(w * 0.55, h * 0.78),
      Offset(w * 0.90, h * 0.82), Offset(w * 0.70, h * 0.88),
      Offset(w * 0.45, h * 0.92), Offset(w * 0.85, h * 0.96),
      Offset(w * 0.60, h * 1.02), Offset(w * 0.95, h * 1.05),
      // Left Side Area
      Offset(w * 0.15, h * 0.08), Offset(w * 0.05, h * 0.18),
      Offset(w * 0.25, h * 0.25), Offset(w * 0.10, h * 0.35),
      Offset(w * 0.20, h * 0.65), Offset(w * 0.05, h * 0.75),
      Offset(w * 0.25, h * 0.85), Offset(w * 0.12, h * 0.95),
      // Bridge nodes
      Offset(w * 0.45, h * 0.15), Offset(w * 0.40, h * 0.70),
    ];
    final double connectionDistance = w * 0.35;
    final double animValue = animation.value * 2 * pi;

    for (int i = 0; i < baseNodes.length; i++) {
      for (int j = i + 1; j < baseNodes.length; j++) {
        double distance = (baseNodes[i] - baseNodes[j]).distance;

        if (distance < connectionDistance) {
          double baseOpacity = 1.0 - (distance / connectionDistance);

          final staticLinePaint = Paint()
            ..color = primaryTeal.withOpacity(baseOpacity * 0.1)
            ..strokeWidth = 0.8
            ..style = PaintingStyle.stroke;
          canvas.drawLine(baseNodes[i], baseNodes[j], staticLinePaint);

          double phase = (i * 0.4) + (j * 0.7);
          double progress = (sin(animValue + phase) + 1) / 2;

          Offset animatedEndPoint = Offset.lerp(baseNodes[i], baseNodes[j], progress)!;

          final animatedLinePaint = Paint()
            ..color = primaryTeal.withOpacity(baseOpacity * 0.9)
            ..strokeWidth = 1.5
            ..style = PaintingStyle.stroke;

          canvas.drawLine(baseNodes[i], animatedEndPoint, animatedLinePaint);
        }
      }
    }

    for (var node in baseNodes) {
      canvas.drawCircle(node, 5.0, glowDotPaint);
      canvas.drawCircle(node, 1.9, solidDotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}