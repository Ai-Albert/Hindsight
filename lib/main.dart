import 'package:flutter/material.dart';
import 'package:hindsight/pages/logging.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hindsight',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Logging(),
    );
  }
}