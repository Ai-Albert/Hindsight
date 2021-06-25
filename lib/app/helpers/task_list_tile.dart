import 'package:flutter/material.dart';
import 'package:hindsight/models/task.dart';
import 'package:intl/intl.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({Key key, @required this.task, this.onTap}) : super(key: key);

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      margin: EdgeInsets.all(6.0),
      color: Colors.grey[800],
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        onTap: onTap,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildTile(context),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    String formattedDate = DateFormat('MM-dd-yyyy').format(task.start);
    final TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.taskName, style: style),
            SizedBox(height: 2.0),
            Text(formattedDate, style: style),
          ],
        ),
        Text('Efficiency: ${(task.efficiency).toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
