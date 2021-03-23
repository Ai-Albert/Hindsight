import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';
import 'package:hindsight/pages/logging.dart';
import 'package:hindsight/pages/time_machine.dart';

class Home extends StatefulWidget {

  final VoidCallback onSignOut;
  final AuthBase auth;
  const Home({Key key, @required this.onSignOut, @required this.auth}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

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
        actions: [
          TextButton(
            child: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
            onPressed: _signOut,
          ),
        ],
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
