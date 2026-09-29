import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pedometer/pedometer.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class HealthDataManager extends ChangeNotifier {
  // Goals
  int stepGoal = 10000;
  int heartPointGoal = 150; // Weekly goal as per prompt WHO standard

  // Real-time Data
  int baseSystemSteps = -1;
  int sessionSteps = 0;
  int heartPoints = 0;
  double calories = 0.0;
  double distanceMiles = 0.0;
  int moveMinutes = 0;
  
  // History for charts
  List<int> weeklySteps = List.filled(7, 0);

  // Cadence Tracking
  int _lastMinuteSteps = 0;
  Timer? _cadenceTimer;
  StreamSubscription<StepCount>? _stepSubscription;
  late SharedPreferences _prefs;
  bool isInitialized = false;

  HealthDataManager() {
    _initStorage();
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    
    stepGoal = _prefs.getInt('stepGoal') ?? 10000;
    heartPointGoal = _prefs.getInt('heartPointGoal') ?? 150;
    
    // Load today's persisted state
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    final lastSavedDate = _prefs.getString('lastSavedDate') ?? '';
    
    if (lastSavedDate == todayStr) {
      sessionSteps = _prefs.getInt('todaySteps') ?? 0;
      heartPoints = _prefs.getInt('todayHeartPoints') ?? 0;
      moveMinutes = _prefs.getInt('todayMoveMinutes') ?? 0;
      baseSystemSteps = _prefs.getInt('baseSystemSteps') ?? -1;
    } else {
      // Midnight Rollover happened
      _rolloverMidnight();
    }
    
    _loadWeeklyHistory();
    _recalculateDerivedMetrics();
    isInitialized = true;
    notifyListeners();
  }

  void _rolloverMidnight() {
    // Save prior day's steps to weekly history
    final lastSavedDate = _prefs.getString('lastSavedDate');
    if (lastSavedDate != null) {
      final prevSteps = _prefs.getInt('todaySteps') ?? 0;
      // Shift array
      for (int i = 0; i < 6; i++) {
        weeklySteps[i] = weeklySteps[i+1];
      }
      weeklySteps[6] = prevSteps;
      _saveWeeklyHistory();
    }
    
    // Reset today
    sessionSteps = 0;
    heartPoints = 0; // Assuming this tracks daily for the circle, but weekly for the target. We'll simplify to daily reset and accumulate weekly.
    // Wait, prompt says: "Weekly Target: Progress bar tracking total Heart Points against the WHO 150-point target."
    // Let's store weekly heart points separately.
    int weeklyHeartPoints = _prefs.getInt('weeklyHeartPoints') ?? 0;
    // Check if it's a new week (Monday)
    if (DateTime.now().weekday == DateTime.monday) {
      weeklyHeartPoints = 0;
    } else {
      weeklyHeartPoints += heartPoints; 
    }
    _prefs.setInt('weeklyHeartPoints', weeklyHeartPoints);
    
    heartPoints = 0;
    moveMinutes = 0;
    baseSystemSteps = -1; // Wait for next pedometer event to set base
    
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    _prefs.setString('lastSavedDate', todayStr);
    _saveState();
  }

  void _loadWeeklyHistory() {
    for (int i = 0; i < 7; i++) {
      weeklySteps[i] = _prefs.getInt('weeklySteps_$i') ?? 0;
    }
  }

  void _saveWeeklyHistory() {
    for (int i = 0; i < 7; i++) {
      _prefs.setInt('weeklySteps_$i', weeklySteps[i]);
    }
  }

  void _saveState() {
    if (!isInitialized) return;
    _prefs.setInt('todaySteps', sessionSteps);
    _prefs.setInt('todayHeartPoints', heartPoints);
    _prefs.setInt('todayMoveMinutes', moveMinutes);
    _prefs.setInt('baseSystemSteps', baseSystemSteps);
    _prefs.setInt('stepGoal', stepGoal);
    _prefs.setInt('heartPointGoal', heartPointGoal);
  }
  
  int get weeklyHeartPointsTotal {
    return (_prefs.getInt('weeklyHeartPoints') ?? 0) + heartPoints;
  }

  void startTracking() {
    if (!isInitialized) return;
    
    _stepSubscription?.cancel();
    _stepSubscription = Pedometer.stepCountStream.listen((StepCount event) {
      if (baseSystemSteps == -1) {
        // If we loaded sessionSteps from memory, subtract it to normalize base
        baseSystemSteps = event.steps - sessionSteps; 
      }
      
      final int newSessionSteps = event.steps - baseSystemSteps;
      if (newSessionSteps > sessionSteps) {
        sessionSteps = newSessionSteps;
        _recalculateDerivedMetrics();
        _saveState();
        notifyListeners();
      }
    }, onError: (e) {
      debugPrint("Pedometer Error: $e");
    });

    _cadenceTimer?.cancel();
    _cadenceTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _evaluateCadence();
      
      // Midnight rollover check
      final todayStr = DateTime.now().toIso8601String().substring(0, 10);
      if (_prefs.getString('lastSavedDate') != todayStr) {
        _rolloverMidnight();
        notifyListeners();
      }
    });
  }

  void _evaluateCadence() {
    final int stepsThisMinute = sessionSteps - _lastMinuteSteps;
    _lastMinuteSteps = sessionSteps;

    if (stepsThisMinute >= 30) {
      moveMinutes += 1;
      
      if (stepsThisMinute >= 130) {
        heartPoints += 2; // Vigorous
      } else if (stepsThisMinute >= 100) {
        heartPoints += 1; // Moderate
      }
      
      _saveState();
      notifyListeners();
    }
  }

  void _recalculateDerivedMetrics() {
    // Active step burn only (excluding BMR)
    calories = sessionSteps * 0.04; 
    distanceMiles = sessionSteps * 0.000473;
  }
  
  void updateGoals({int? steps, int? heartPts}) {
    if (steps != null) stepGoal = steps;
    if (heartPts != null) heartPointGoal = heartPts;
    _saveState();
    notifyListeners();
  }

  // Manual Workout Logging
  void logWorkout(String type, int minutes) {
    moveMinutes += minutes;
    if (type == 'Running') {
      heartPoints += minutes * 2;
      sessionSteps += minutes * 160;
    } else if (type == 'Cycling') {
      heartPoints += minutes * 2;
      calories += minutes * 8.0;
    } else { // Walking
      heartPoints += minutes;
      sessionSteps += minutes * 100;
    }
    _recalculateDerivedMetrics();
    _saveState();
    notifyListeners();
  }

  @override
  void dispose() {
    _stepSubscription?.cancel();
    _cadenceTimer?.cancel();
    super.dispose();
  }
}
