import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/task_display.dart';
import 'package:hindsight/app/time_machine/select_date.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/comparison.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';
import 'package:provider/provider.dart';

class TimeMachine extends StatefulWidget {
  const TimeMachine({Key key, @required this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  _TimeMachineState createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {

  List<Task> tasks;

  Future<void> _saveComparison(BuildContext context) async {
    final Database database = Provider.of<Database>(context, listen: false);
    try {
      if (tasks[0] == null || tasks[1] == null) throw Exception();
      Comparison comparison = Comparison(
        id: "${tasks[0].id}_${tasks[1].id}",
        taskName1: tasks[0].taskName,
        start1: tasks[0].start,
        estimated1: tasks[0].estimated,
        actual1: tasks[0].actual,
        taskName2: tasks[1].taskName,
        start2: tasks[1].start,
        estimated2: tasks[1].estimated,
        actual2: tasks[1].actual,
      );
      await database.setComparison(comparison);
    } catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tasks = widget.tasks;
    return Column(
      children: [
        SizedBox(height: 5.0),
        _selectTask(tasks, 0),
        _selectTask(tasks, 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _efficiencyCard(),
            _saveButton(),
          ],
        ),
      ],
    );
  }

  Widget _selectTask(List<Task> tasks, int taskNum) {
    final database = Provider.of<Database>(context, listen: false);
    return TaskDisplay(
      task: tasks.length >= taskNum ? tasks[taskNum] : null,
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SelectDate(database: database, tasks: tasks, taskNum: taskNum),
        ));
        setState(() {});
      }
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
                'Efficiency Difference:',
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

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 6, 6),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all(Colors.lightBlue[900]),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
        ),
        onPressed: () => _saveComparison(context),
        child: Row(
          children: [
            Text('Save Comparison '),
            Icon(Icons.save_outlined),
          ],
        ),
      ),
    );
  }
}
