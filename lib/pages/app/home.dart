import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';
import 'package:hindsight/custom_widgets/show_alert_dialog.dart';
import 'package:hindsight/pages/app/logging.dart';
import 'package:hindsight/pages/app/time_machine.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future _signOut() async {
    try {
      await Provider.of<AuthBase>(context, listen: false).signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future _confirmSignOut(BuildContext context) async {
    final request = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Log out',
    );
    if (request) {
      _signOut();
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
      backgroundColor: Colors.grey[900],

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _appBarTitles[_currentIndex],
        ),
        actions: [
          TextButton(
            child: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: _children[_currentIndex],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[900],
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
        backgroundColor: Colors.grey[850],
        selectedItemColor: Colors.grey[350],
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
