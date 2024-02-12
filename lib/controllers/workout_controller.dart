import 'package:flutter/foundation.dart';

import '../models/workout.dart'; // Make sure this path matches your project structure

class WorkoutController with ChangeNotifier {
  List<Workout> _workouts = [];
  int _goal = 0; // Example goal: number of workouts per week

  List<Workout> get workouts => _workouts;
  int get goal => _goal;

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void setGoal(int newGoal) {
    _goal = newGoal;
    notifyListeners();
  }

// Add more methods as needed for your functionality
}
