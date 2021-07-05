import 'package:flutter/material.dart';

class Comparison {
  Comparison({
    @required this.id,
    @required this.taskName1,
    @required this.start1,
    @required this.estimated1,
    @required this.actual1,
    @required this.taskName2,
    @required this.start2,
    @required this.estimated2,
    @required this.actual2,
  });

  final String id;
  final String taskName1;
  final DateTime start1;
  final DateTime estimated1;
  final DateTime actual1;
  final String taskName2;
  final DateTime start2;
  final DateTime estimated2;
  final DateTime actual2;

  double get estimatedDurationInHours1 => estimated1.difference(start1).inMinutes.toDouble() / 60.0;
  double get actualDurationInHours1 => actual1.difference(start1).inMinutes.toDouble() / 60.0;
  double get efficiency1 => estimatedDurationInHours1 / actualDurationInHours1;

  double get estimatedDurationInHours2 => estimated2.difference(start2).inMinutes.toDouble() / 60.0;
  double get actualDurationInHours2 => actual2.difference(start2).inMinutes.toDouble() / 60.0;
  double get efficiency2 => estimatedDurationInHours2 / actualDurationInHours2;

  factory Comparison.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) return null;
    return Comparison(
      id: id,
      taskName1: data['task_name1'],
      start1: DateTime.fromMillisecondsSinceEpoch(data['start1']),
      estimated1: DateTime.fromMillisecondsSinceEpoch(data['estimated1']),
      actual1: DateTime.fromMillisecondsSinceEpoch(data['actual1']),
      taskName2: data['task_name2'],
      start2: DateTime.fromMillisecondsSinceEpoch(data['start2']),
      estimated2: DateTime.fromMillisecondsSinceEpoch(data['estimated2']),
      actual2: DateTime.fromMillisecondsSinceEpoch(data['actual2']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_name1': taskName1,
      'start1': start1.millisecondsSinceEpoch,
      'estimated1': estimated1.millisecondsSinceEpoch,
      'actual1': actual1.millisecondsSinceEpoch,
      'task_name2': taskName2,
      'start2': start2.millisecondsSinceEpoch,
      'estimated2': estimated2.millisecondsSinceEpoch,
      'actual2': actual2.millisecondsSinceEpoch,
    };
  }
}
