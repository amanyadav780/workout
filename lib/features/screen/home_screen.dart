import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/workoutController.dart';

class HomePage extends StatelessWidget {
  final WorkoutController workoutController = Get.put(WorkoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workouts')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: workoutController.predefinedWorkouts.length,
              itemBuilder: (context, index) {
                String workoutName =
                    workoutController.predefinedWorkouts[index];

                bool isCompleted =
                    workoutController.isWorkoutCompleted(workoutName);
                int rating = isCompleted
                    ? workoutController.getWorkoutRating(workoutName)
                    : 0;

                return ListTile(
                  title: Text(workoutName),
                  subtitle: isCompleted
                      ? Text('Completed with rating: $rating')
                      : Text('Not completed'),
                  trailing: ElevatedButton(
                    onPressed: isCompleted
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  RatingDialog(workoutName: workoutName),
                            );
                          },
                    child: Text(isCompleted ? 'Completed' : 'Start'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final String workoutName;

  RatingDialog({required this.workoutName});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final TextEditingController _ratingController = TextEditingController();
  final WorkoutController workoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate ${widget.workoutName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _ratingController,
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(hintText: 'Enter value between 0 and 100'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            int value = int.parse(_ratingController.text);
            workoutController.addCompletedWorkout(widget.workoutName, value);
            Navigator.pop(context);
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
