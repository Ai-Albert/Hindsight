import 'package:flutter/material.dart';

class Entry {
  Entry({@required this.taskName, @required this.start, @required this.estimated, this.actual = 0});
  final String taskName;
  final int start;
  final int estimated;
  final int actual;

  Map<String, dynamic> toMap() {
    return {
      'task_name': taskName,
      'start_time': start,
      'estimated_end_time': estimated,
      'actual_end_time': actual,
    };
  }
}