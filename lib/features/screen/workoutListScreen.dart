import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/workoutController.dart';

class WorkoutListPage extends StatelessWidget {
  final WorkoutController workoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Workouts')),
      body: Obx(() {
        // Filter for completed workouts
        var completedWorkouts = workoutController.workouts.where((workout) => workout.isDone).toList();
        return ListView.builder(
          itemCount: completedWorkouts.length,
          itemBuilder: (context, index) {
            final workout = completedWorkouts[index];
            return ListTile(
              title: Text(workout.name),
              subtitle: Text('Rating: ${workout.value}, Completed on: ${workout.date.toLocal().toString().split(' ')[0]}'),
            );
          },
        );
      }),
    );
  }
}
