import 'package:flutter/material.dart';
import 'package:hindsight/pages/logging.dart';
import 'package:hindsight/pages/time_machine.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [Logging(), TimeMachine()];
  final List<String> _appBarTitles = ['Logging', 'Time Machine'];
  final List<Widget> _icons = [Icon(Icons.add), Icon(Icons.calendar_today_outlined)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex]),
      ),

      body: _children[_currentIndex],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: _icons[_currentIndex],
        onPressed: () {
          if (_appBarTitles[_currentIndex] == 'Logging') {
            //
          }
          else if (_appBarTitles[_currentIndex] == 'Time Machine') {
            //
          }
        },
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: '',
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
