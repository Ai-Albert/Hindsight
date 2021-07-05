import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/date_list_tile.dart';
import 'package:hindsight/app/helpers/list_items_builder.dart';
import 'package:hindsight/app/time_machine/select_task.dart';
import 'package:hindsight/models/date.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
    Key key,
    @required this.tasks,
    @required this.taskNum,
    @required this.database,
  }) : super(key: key);

  final List<Task> tasks;
  final int taskNum;
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Date'),
      ),
      body: _buildDates(context),
    );
  }

  Widget _buildDates(BuildContext context) {
    return StreamBuilder<List<Date>>(
      stream: database.datesStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Date>(
          snapshot: snapshot,
          itemBuilder: (context, date) => DateListTile(
            date: date,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectTask(date: date, tasks: tasks, taskNum: taskNum, database: database),
            )),
          ),
        );
      },
    );
  }
}
