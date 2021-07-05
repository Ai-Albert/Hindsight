import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Archive'),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Coming Soon',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
