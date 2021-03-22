import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/pages/logging.dart';
import 'package:hindsight/pages/time_machine.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  final VoidCallback onSignOut;
  const Home({Key key, this.onSignOut}) : super(key: key);

  Future _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

class _HomeState extends State<Home> {

  // Controls variable elements of the basic structure of the app
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
          if (_currentIndex == 0) {
            // TODO: navigate to the page for adding an entry
          }
          else if (_currentIndex == 1) {
            // TODO: navigate to calendar graph page
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
}
