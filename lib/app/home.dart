import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/auth.dart';
import 'package:hindsight/custom_widgets/show_alert_dialog.dart';
import 'package:hindsight/app/fireplace/fireplace.dart';
import 'package:hindsight/app/time_machine/time_machine.dart';
import 'package:hindsight/services/database.dart';
import 'package:hindsight/app/fireplace/add_task.dart';
import 'package:hindsight/app/time_machine/calendar_graph.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Signs out using Firebase
  Future _signOut() async {
    try {
      await Provider.of<AuthBase>(context, listen: false).signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Asks user to sign out
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
  final List<Widget> _children = [Fireplace(), TimeMachine()];
  final List<String> _appBarTitles = ['Fireplace', 'Time Machine'];
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
            final database = Provider.of<Database>(context, listen: false);
            AddTask.show(context, database: database);
          }
          else if (_currentIndex == 1) {
            Navigator.of(context).push(MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => CalendarGraph(),
            ));
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
