import 'package:flutter/material.dart';
import 'package:hindsight/models/task.dart';
import 'package:intl/intl.dart';

class TaskDisplay extends StatelessWidget {
  TaskDisplay({Key key, @required this.task, this.onTap}) : super(key: key);

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
    String formattedStart = task != null ? DateFormat('MM-dd-yyyy hh:mm a').format(task.start) : '';
    String formattedEstimated = task != null ? DateFormat('MM-dd-yyyy hh:mm a').format(task.estimated) : '';
    String formattedActual = task != null ? DateFormat('MM-dd-yyyy hh:mm a').format(task.actual) : '';

    final TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    );

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Text(task != null ? task.taskName : 'task_name', style: style),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start:', style: style),
                  Text('Estimated:', style: style),
                  Text('Actual:', style: style),
                  Text('Efficiency', style: style),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$formattedStart', style: style),
                  Text('$formattedEstimated', style: style),
                  Text('$formattedActual', style: style),
                  Text(task != null ? '${task.efficiency}' : '', style: style),
                ],
              ),
            ],
          ),

          SizedBox(height: 10.0),
          _colorIndicator(),
        ],
      ),
    );
  }

  Widget _colorIndicator() {
    return Container(
      decoration: BoxDecoration(
        color: task != null ? (task.efficiency >= 1 ? Colors.green[600] : Colors.red[700]) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(color: Colors.white),
      ),
      child: SizedBox(height: 17.0, child: Container()),
    );
  }
}
