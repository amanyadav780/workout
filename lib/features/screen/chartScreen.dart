import 'package:flutter/material.dart';

import '../model/workoutModel.dart';

class ChartPage extends StatelessWidget {
  final List<Workout> workouts;

  ChartPage({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Chart')),
      body: CustomPaint(
        size: Size(double.infinity, 400),
        painter: WorkoutChartPainter(workouts),
      ),
    );
  }
}

class WorkoutChartPainter extends CustomPainter {
  final List<Workout> workouts;

  WorkoutChartPainter(this.workouts);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    final double barWidth = size.width / (workouts.length * 2);

    for (int i = 0; i < workouts.length; i++) {
      double barHeight = (workouts[i].value / 100) * size.height;
      canvas.drawRect(
        Rect.fromLTWH(i * barWidth * 2, size.height - barHeight, barWidth, barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
