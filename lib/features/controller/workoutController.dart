import 'package:get/get.dart';

import '../model/workoutModel.dart';
import '../service/databaseService.dart';

class WorkoutController extends GetxController {
  var workouts = <Workout>[].obs;

  var predefinedWorkouts = [
    'Push Ups',
    'Squats',
    'Lunges',
    'Planks',
    'Burpees'
  ];

  final DatabaseService _dbService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    loadWorkouts();
  }

  Future<void> loadWorkouts() async {
    final allWorkouts = await _dbService.getAllWorkouts();
    workouts.assignAll(allWorkouts);
  }

  Future<void> addCompletedWorkout(String workoutName, int value) async {
    final newWorkout = Workout(
      name: workoutName,
      value: value,
      isDone: true,
      date: DateTime.now(),
    );
    await _dbService.insertWorkout(newWorkout);
    loadWorkouts();
  }

  bool isWorkoutCompleted(String workoutName) {
    return workouts
        .any((workout) => workout.name == workoutName && workout.isDone);
  }

  int getWorkoutRating(String workoutName) {
    return workouts.firstWhere((workout) => workout.name == workoutName).value;
  }
}
