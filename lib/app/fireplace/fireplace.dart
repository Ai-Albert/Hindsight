import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/task_list_tile.dart';
import 'package:hindsight/app/helpers/list_items_builder.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';
import 'package:provider/provider.dart';
import 'add_task.dart';

class Fireplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildTasks(context),
    );
  }

  Future<void> _delete(BuildContext context, Task task) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteTask(task);
    } on FirebaseException catch(e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  Widget _buildTasks(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Task>>(
      stream: database.tasksStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Task>(
          snapshot: snapshot,
          itemBuilder: (context, task) => Dismissible(
            key: Key('task-${task.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, task),
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