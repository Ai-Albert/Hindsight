import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/list_items_builder.dart';
import 'package:hindsight/app/helpers/task_list_tile.dart';
import 'package:hindsight/models/date.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';

class SelectTask extends StatelessWidget {
  const SelectTask({
    Key key,
    @required this.tasks,
    @required this.taskNum,
    @required this.date,
    @required this.database,
  }) : super(key: key);

  final List<Task> tasks;
  final int taskNum;
  final Date date;
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Task'),
      ),
      body: _buildTasks(context),
    );
  }

  Widget _buildTasks(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: this.database.tasksStream(this.date),
      builder: (context, snapshot) {
        return ListItemsBuilder<Task>(
          snapshot: snapshot,
          itemBuilder: (context, task) => TaskListTile(
            task: task,
            onTap: () {
              tasks[taskNum] = task;
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        );
      },
    );
  }
}
