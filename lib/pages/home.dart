import 'package:flutter/material.dart';
import 'package:hindsight/pages/logging.dart';
import 'package:hindsight/pages/time_machine.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // final List<Widget> _children = [Logging(), TimeMachine()];
  final List<String> _appBarTitles = ['Logging', 'Time Machine'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex]),
      ),

      body: Container(
        color: Colors.white,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: 'Time',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
