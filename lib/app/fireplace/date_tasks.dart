import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/list_items_builder.dart';
import 'package:hindsight/app/helpers/task_list_tile.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/date.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';
import 'add_task.dart';

class DateTasks extends StatelessWidget {

  const DateTasks({Key key, @required this.date, @required this.database}) : super(key: key);

  final Date date;
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(date.formattedDate),
        centerTitle: true,
      ),
      body: _buildTasks(context),
    );
  }

  Future<void> _deleteTask(BuildContext context, Date date, Task task) async {
    try {
      await this.database.deleteTask(date, task);
    } on FirebaseException catch(e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  Widget _buildTasks(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: this.database.tasksStream(this.date),
      builder: (context, snapshot) {
        return ListItemsBuilder<Task>(
          snapshot: snapshot,
          itemBuilder: (context, task) => Dismissible(
            key: Key('task-${task.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteTask(context, this.date, task),
            child: TaskListTile(
              task: task,
              onTap: () => AddTask.show(context, database: database, task: task),
            ),
          ),
        );
      },
    );
  }
}