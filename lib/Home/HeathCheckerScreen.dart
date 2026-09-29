import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'HeathCheckerFile/providers/health_data_manager.dart';
import 'HeathCheckerFile/widgets/health_chart.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissionAndInit();
    });
  }

  Future<void> _requestPermissionAndInit() async {
    final activityStatus = await Permission.activityRecognition.request();
    final sensorStatus = await Permission.sensors.request();
    
    // Foreground Task Permissions (Android 13+ and iOS)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    
    if (activityStatus.isGranted || sensorStatus.isGranted) {
      if (mounted) {
        Provider.of<HealthDataManager>(context, listen: false).startTracking();
      }
    }
  }

  void _showEditGoalsSheet() {
    final manager = Provider.of<HealthDataManager>(context, listen: false);
    final stepController = TextEditingController(text: manager.stepGoal.toString());
    final heartController = TextEditingController(text: manager.heartPointGoal.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          side: BorderSide(color: const Color(0xFF0C524C).withValues(alpha: 1.0), width: 1.0),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.all(20.w).copyWith(bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit Goals", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h),
              TextField(
                controller: stepController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Daily Step Goal",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: heartController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weekly Heart Point Goal",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 25.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF44B08C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))
                  ),
                  onPressed: () {
                    manager.updateGoals(
                      steps: int.tryParse(stepController.text),
                      heartPts: int.tryParse(heartController.text),
                    );
                    Navigator.pop(context);
                  },
                  child: Text("Save Goals", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void _showLogWorkoutSheet() {
    final manager = Provider.of<HealthDataManager>(context, listen: false);
    final minController = TextEditingController();
    String selectedType = 'Running';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Padding(
              padding: EdgeInsets.all(20.w).copyWith(bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Log Manual Workout", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF0C524C), width: 1.0),
                      borderRadius: BorderRadius.circular(12.r)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedType,
                        isExpanded: true,
                        iconEnabledColor: const Color(0xFF0C524C),
                        items: ['Running', 'Cycling', 'Walking'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => setStateSheet(() => selectedType = v!),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Duration (minutes)",
                      // 1. Label color when idle (not focused)
                      labelStyle: const TextStyle(color: Color(0xFF0C524C)),
                      // 2. Label color when floating up (focused)
                      floatingLabelStyle: const TextStyle(color: Color(0xFF0C524C)),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Color(0xFF0C524C), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Color(0xFF0C524C), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C524C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))
                      ),
                      onPressed: () {
                        final mins = int.tryParse(minController.text);
                        if (mins != null && mins > 0) {
                          manager.logWorkout(selectedType, mins);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Save Activity", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned.fill(
            child: AnimatedNetworkBackground(),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  "ClimaFits️⚡️",
                  style: TextStyle(
                    fontFamily: "Tinos",
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0C524C),
                    fontSize: 22.sp,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Consumer<HealthDataManager>(
              builder: (context, manager, child) {
                if (!manager.isInitialized) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF0C524C)));
                }
                
                final double stepProgress = (manager.sessionSteps / manager.stepGoal).clamp(0.0, 1.0);
                final double heartProgress = (manager.heartPoints / 30).clamp(0.0, 1.0); // 30 is daily heart point visual target

                return Column(
                  children: [
                    SizedBox(height: 50.h),
                    GestureDetector(
                      onTap: _showEditGoalsSheet,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularPercentIndicator(
                                  radius: 110.r,
                                  lineWidth: 12.w,
                                  percent: heartProgress,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: const Color(0xFF147B72),
                                  backgroundColor: const Color(0xffDDEFEA),
                                ),
                                CircularPercentIndicator(
                                  radius: 88.r,
                                  lineWidth: 10.w,
                                  percent: stepProgress,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: const Color(0xFF3F72FF),
                                  backgroundColor: const Color(0xffDCE1EB),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${manager.heartPoints}",
                                      style: TextStyle(
                                        fontSize: 52.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff44B08C),
                                      ),
                                    ),
                                    Text(
                                      "${manager.sessionSteps}",
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff3F72FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite, color: const Color(0xFF0C524C), size: 20.sp),
                                SizedBox(width: 6.w),
                                Text(
                                  "Heart Pts",
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 13.sp),
                                ),
                                SizedBox(width: 30.w),
                                Icon(Icons.directions_walk, color: const Color(0xff3F72FF), size: 20.sp),
                                SizedBox(width: 6.w),
                                Text(
                                  "Steps",
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 13.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 18.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _StateWidget(manager.calories.toStringAsFixed(0), "Cal"),
                                _StateWidget(manager.distanceMiles.toStringAsFixed(2), "Miles"),
                                _StateWidget("${manager.moveMinutes}", "Move Min"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                        ),
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h).copyWith(bottom: 100.h),
                          children: [
                            _buildGoalCard(manager),
                            SizedBox(height: 18.h),
                            _buildTargetCard(manager),
                            SizedBox(height: 18.h),
                            ActivityHistoryChart(weeklyData: manager.weeklySteps),
                            SizedBox(height: 25.h),
                            SizedBox(
                              width: double.infinity,
                              height: 55.h,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0C524C),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                                  elevation: 0,
                                ),
                                onPressed: _showLogWorkoutSheet,
                                icon: const Icon(Icons.add, color: Colors.white),
                                label: Text("Log Manual Activity", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(HealthDataManager manager) {
    int achievedDays = manager.weeklySteps.where((s) => s >= manager.stepGoal).length;
    if (manager.sessionSteps >= manager.stepGoal) achievedDays++;
    
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Goals", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
          SizedBox(height: 4.h),
          Text("Last 7 days", style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$achievedDays/7", style: TextStyle(fontSize: 22.sp, color: const Color(0xff3F72FF), fontWeight: FontWeight.bold)),
                  Text("Achieved", style: TextStyle(color: const Color(0xff3F72FF), fontSize: 13.sp)),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  7,
                  (index) {
                    bool achieved = false;
                    if (index < 6) {
                       achieved = manager.weeklySteps[index] >= manager.stepGoal;
                    } else {
                       achieved = manager.sessionSteps >= manager.stepGoal;
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: CircleAvatar(
                        radius: 12.r,
                        backgroundColor: achieved ? const Color(0xffE6F4EE) : Colors.grey.shade200,
                        child: Icon(
                          achieved ? Icons.check : Icons.circle,
                          size: achieved ? 14.sp : 6.sp,
                          color: achieved ? const Color(0xff44B08C) : Colors.grey.shade400,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetCard(HealthDataManager manager) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Weekly Target", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
              Icon(Icons.chevron_right, size: 20.sp, color: Colors.black54),
            ],
          ),
          SizedBox(height: 4.h),
          Text("Current Week", style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
          SizedBox(height: 6.h),
          Text(
            "${manager.weeklyHeartPointsTotal} of ${manager.heartPointGoal}",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: const Color(0xff44B08C)),
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: (manager.weeklyHeartPointsTotal / manager.heartPointGoal).clamp(0.0, 1.0),
            minHeight: 7.h,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff44B08C)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          SizedBox(height: 14.h),
          Text(
            "Scoring ${manager.heartPointGoal} Heart Points a week can help you live longer, sleep better, and boost your overall mood.",
            style: TextStyle(fontSize: 13.sp, color: Colors.black54, height: 1.3),
          ),
        ],
      ),
    );
  }
}

class _StateWidget extends StatelessWidget {
  final String value;
  final String title;

  const _StateWidget(this.value, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 22.sp, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h),
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
        ),
      ],
    );
  }
}

// Background Visual Canvas
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
      // Top Area
      Offset(w * 0.15, h * 0.05), Offset(w * 0.45, h * 0.03), 
      Offset(w * 0.80, h * 0.06), Offset(w * 0.95, h * 0.15),
      Offset(w * 0.25, h * 0.12), Offset(w * 0.65, h * 0.10),
      
      // Upper Middle Area
      Offset(w * 0.10, h * 0.25), Offset(w * 0.35, h * 0.22),
      Offset(w * 0.55, h * 0.28), Offset(w * 0.85, h * 0.24),
      
      // Middle Area (Behind the rings and cards)
      Offset(w * 0.05, h * 0.40), Offset(w * 0.25, h * 0.45),
      Offset(w * 0.50, h * 0.42), Offset(w * 0.75, h * 0.48),
      Offset(w * 0.92, h * 0.42), Offset(w * 0.15, h * 0.55),
      Offset(w * 0.82, h * 0.58), Offset(w * 0.40, h * 0.60),
      Offset(w * 0.65, h * 0.55),

      // Lower Middle Area
      Offset(w * 0.08, h * 0.70), Offset(w * 0.30, h * 0.75),
      Offset(w * 0.55, h * 0.72), Offset(w * 0.88, h * 0.76),
      Offset(w * 0.75, h * 0.68),
      
      // Bottom Area
      Offset(w * 0.12, h * 0.85), Offset(w * 0.35, h * 0.88),
      Offset(w * 0.60, h * 0.85), Offset(w * 0.85, h * 0.90),
      Offset(w * 0.95, h * 0.98), Offset(w * 0.45, h * 0.96),
      Offset(w * 0.20, h * 0.98), Offset(w * 0.75, h * 0.95),
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