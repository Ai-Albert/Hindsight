import 'package:flutter/material.dart';
import 'package:hindsight/models/task.dart';

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
    final TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    );
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Name: ${task.taskName}', style: style),
          Opacity(
            opacity: 0.0,
            child: Icon(Icons.add),
          ),
          Text('Efficiency: ${(task.efficiency).toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}
