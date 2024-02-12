import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/workout_controller.dart';
import '../models/workout.dart';
import 'add_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fitness Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: WorkoutPieChart(),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: WorkoutList(),
          ),
          SizedBox(height: 16.0),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddWorkoutScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class WorkoutPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutController = Provider.of<WorkoutController>(context);
    final List<Workout> workouts = workoutController.workouts;

    // Calculate total duration for each workout type
    Map<String, int> durationByType = {};
    workouts.forEach((workout) {
      if (durationByType.containsKey(workout.type)) {
        durationByType[workout.type] =
            durationByType[workout.type]! + workout.duration;
      } else {
        durationByType[workout.type] = workout.duration;
      }
    });

    // Prepare data for pie chart
    List<PieChartSectionData> pieChartSections =
        durationByType.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: entry.key,
        color:
            _getColor(entry.key), // Function to get color based on workout type
        radius: 100,
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: pieChartSections,
        sectionsSpace: 0,
        centerSpaceRadius: 40,
      ),
    );
  }

  // Function to get color based on workout type
  Color _getColor(String type) {
    switch (type) {
      case 'Cardio':
        return Colors.blue;
      case 'Strength':
        return Colors.green;
      case 'Yoga':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class WorkoutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutController = Provider.of<WorkoutController>(context);
    final List<Workout> workouts = workoutController.workouts;

    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return ListTile(
          title: Text(workout.type),
          //leading: Text(workout.type),
          subtitle: Text("${workout.duration} minutes on ${workout.date}"),
        );
      },
    );
  }
}
