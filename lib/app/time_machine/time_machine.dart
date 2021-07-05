import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/task_display.dart';
import 'package:hindsight/app/time_machine/select_date.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';
import 'package:provider/provider.dart';

class TimeMachine extends StatefulWidget {
  @override
  _TimeMachineState createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {
  List<Task> tasks = [null, null];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.0),
        _selectTask(tasks, 0),
        _selectTask(tasks, 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _efficiencyCard(),
            _refreshButton(),
          ],
        ),
      ],
    );
  }

  Widget _selectTask(List<Task> tasks, int taskNum) {
    final database = Provider.of<Database>(context, listen: false);
    return TaskDisplay(
      task: tasks.length >= taskNum ? tasks[taskNum] : null,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SelectDate(database: database, tasks: tasks, taskNum: taskNum),
      )),
    );
  }

  Widget _efficiencyCard() {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        margin: EdgeInsets.fromLTRB(6, 0, 3, 6),
        color: Colors.grey[800],
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Efficiency Difference (e1 - e2):',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Text(
                '${tasks[0] != null && tasks[1] != null ? tasks[0].efficiency - tasks[1].efficiency : ''}',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _refreshButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 6, 6),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all(Colors.lightBlue[900]),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
        ),
        onPressed: () {
          setState(() {});
        },
        child: Row(
          children: [
            Text('Refresh'),
            Icon(Icons.refresh),
          ],
        ),
      ),
    );
  }
}
