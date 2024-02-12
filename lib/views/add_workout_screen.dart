import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/workout_controller.dart';
import '../models/workout.dart';

class AddWorkoutScreen extends StatefulWidget {
  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late String _type;
  late DateTime _date;
  late int _duration;

  @override
  void initState() {
    super.initState();
    _type = '';
    _date = DateTime.now();
    _duration = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text('Add Workout'),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
              items: <String>[
                '',
                'Cardio',
                'Strength',
                'Yoga'
              ] // Add an empty string as the first item
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.isNotEmpty
                      ? value
                      : 'Select Type'), // Provide a placeholder for the empty string
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Type'),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text('Date: ${_date.toString().substring(0, 10)}'),
                SizedBox(width: 15.w),
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        setState(() {
                          _date = pickedDate;
                        });
                      }
                    });
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _duration = int.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(labelText: 'Duration (minutes)'),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                final newWorkout = Workout(
                  title: '',
                  description: 'This is a workout',
                  type: _type,
                  date: _date,
                  duration: _duration,
                );
                Provider.of<WorkoutController>(context, listen: false)
                    .addWorkout(newWorkout);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
