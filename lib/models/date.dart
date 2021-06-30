import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date {
  Date({@required this.id, @required this.date});

  final String id;
  final DateTime date;

  String get formattedDate => DateFormat('MM-dd-yyyy').format(date);

  factory Date.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) return null;
    return Date(id: id, date: DateTime.fromMillisecondsSinceEpoch(data['date']));
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
    };
  }
}