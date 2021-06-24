import 'package:flutter/material.dart';

class Task {
  Task({@required this.id,
    @required this.taskName,
    @required this.start,
    @required this.estimated,
    @required this.actual});

  final String id;
  final String taskName;
  final DateTime start;
  final DateTime estimated;
  final DateTime actual;

  double get estimatedDurationInHours => estimated.difference(start).inMinutes.toDouble() / 60.0;

  double get actualDurationInHours => actual.difference(start).inMinutes.toDouble() / 60.0;

  double get efficiency => estimatedDurationInHours / actualDurationInHours;

  factory Task.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) return null;

    final String taskName = data['task_name'];
    if (taskName == null) return null;

    return Task(
      id: id,
      taskName: taskName,
      start: DateTime.fromMillisecondsSinceEpoch(data['start_time']),
      estimated: DateTime.fromMillisecondsSinceEpoch(data['estimated_end_time']),
      actual: DateTime.fromMillisecondsSinceEpoch(data['actual_end_time']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_name': taskName,
      'start_time': start.millisecondsSinceEpoch,
      'estimated_end_time': estimated.millisecondsSinceEpoch,
      'actual_end_time': actual.millisecondsSinceEpoch,
    };
  }
}