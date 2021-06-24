import 'package:flutter/material.dart';

class TimeMachine extends StatefulWidget {
  @override
  _TimeMachineState createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'Coming Soon',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
          ),
        ),
      ),
    );
  }
}
