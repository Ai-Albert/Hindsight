import 'package:flutter/material.dart';

class Comparison {
  Comparison({
    @required this.id,
    this.taskName1,
    this.start1,
    this.estimated1,
    this.actual1,
    this.taskName2,
    this.start2,
    this.estimated2,
    this.actual2,
  });

  final String id;

  String taskName1;
  DateTime start1;
  DateTime estimated1;
  DateTime actual1;
  String taskName2;
  DateTime start2;
  DateTime estimated2;
  DateTime actual2;

  double get estimatedDurationInHours1 => estimated1.difference(start1).inMinutes.toDouble() / 60.0;
  double get actualDurationInHours1 => actual1.difference(start1).inMinutes.toDouble() / 60.0;
  double get efficiency1 => estimatedDurationInHours1 / actualDurationInHours1;

  double get estimatedDurationInHours2 => estimated2.difference(start2).inMinutes.toDouble() / 60.0;
  double get actualDurationInHours2 => actual2.difference(start2).inMinutes.toDouble() / 60.0;
  double get efficiency2 => estimatedDurationInHours2 / actualDurationInHours2;

  factory Comparison.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) return null;
    Comparison comparison = Comparison(
      id: id,
      taskName1: data['taskName1'],
      start1: DateTime.fromMillisecondsSinceEpoch(data['start1']),
      estimated1: DateTime.fromMillisecondsSinceEpoch(data['estimated1']),
      actual1: DateTime.fromMillisecondsSinceEpoch(data['actual1']),
      taskName2: data['taskName2'],
      start2: DateTime.fromMillisecondsSinceEpoch(data['start2']),
      estimated2: DateTime.fromMillisecondsSinceEpoch(data['estimated2']),
      actual2: DateTime.fromMillisecondsSinceEpoch(data['actual2']),
    );
    return comparison;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName1': taskName1,
      'start1': start1.millisecondsSinceEpoch,
      'estimated1': estimated1.millisecondsSinceEpoch,
      'actual1': actual1.millisecondsSinceEpoch,
      'taskName2': taskName2,
      'start2': start2.millisecondsSinceEpoch,
      'estimated2': estimated2.millisecondsSinceEpoch,
      'actual2': actual2.millisecondsSinceEpoch,
    };
  }
}