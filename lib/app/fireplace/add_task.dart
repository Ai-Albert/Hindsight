import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/custom_widgets/date_time_picker.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/database.dart';

class AddTask extends StatefulWidget {
  // The Task is passed into show() if editing an existing task, otherwise task is null
  const AddTask({Key key, @required this.database, this.task}) : super(key: key);

  final Database database;
  final Task task;

  /* We use this function to go to this page because we need to do MaterialPageRoute
   * for onPressed since onPressed requires a function and AddJobPage is a Widget
   */
  static Future<void> show(BuildContext context, {Database database, Task task}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => AddTask(database: database, task: task),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  // All the variables we need to make a task
  String _taskName;
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _estimatedEndDate;
  TimeOfDay _estimatedEndTime;
  DateTime _actualEndDate;
  TimeOfDay _actualEndTime;

  // Setting up initial values in the form
  @override
  void initState() {
    super.initState();

    _taskName = widget.task?.taskName ?? '';

    final start = widget.task?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final estimated = widget.task?.estimated ?? DateTime.now();
    _estimatedEndDate = DateTime(estimated.year, estimated.month, estimated.day);
    _estimatedEndTime = TimeOfDay.fromDateTime(estimated);

    final actual = widget.task?.actual ?? DateTime.now();
    _actualEndDate = DateTime(actual.year, actual.month, actual.day);
    _actualEndTime = TimeOfDay.fromDateTime(actual);
  }

  // Creating a Task object from the info input into the form so far
  Task _taskFromState() {
    final String taskName = _taskName;
    final DateTime start = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute,
    );
    final DateTime estimated = DateTime(
      _estimatedEndDate.year,
      _estimatedEndDate.month,
      _estimatedEndDate.day,
      _estimatedEndTime.hour,
      _estimatedEndTime.minute,
    );
    final DateTime actual = DateTime(
      _actualEndDate.year,
      _actualEndDate.month,
      _actualEndDate.day,
      _actualEndTime.hour,
      _actualEndTime.minute,
    );
    final String id = widget.task?.id ?? documentIdFromCurrentDate();
    return Task(
      id: id,
      taskName: taskName,
      start: start,
      estimated: estimated,
      actual: actual,
    );
  }

  // Setting the Task and popping out back to the Fireplace page
  Future<void> _setTaskAndDismiss(BuildContext context) async {
    try {
      final Task task = _taskFromState();
      if (task.taskName == '' || task.taskName == null)
        throw new FormatException('EMPTY_NAME');
      if (task.start == task.estimated || task.start == task.actual)
        throw new Exception('INVALID_TASK');
      await widget.database.setTask(task);
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    } on FormatException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Please enter a task name',
        exception: e,
      );
    } catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Not a valid task',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Task Logging'),
        actions: <Widget>[
          TextButton(
            child: Text(
              widget.task != null ? 'Update' : 'Log',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => _setTaskAndDismiss(context),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            color: Colors.grey[800],
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildName(),
                  _buildStartDate(),
                  SizedBox(height: 8.0),
                  _buildEstimatedDate(),
                  SizedBox(height: 8.0),
                  _buildActualDate(),
                  SizedBox(height: 8.0),
                  _buildEfficiency(),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return TextField(
      keyboardType: TextInputType.text,
      controller: TextEditingController(text: _taskName),
      decoration: InputDecoration(
        labelText: 'Task Name',
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      style: TextStyle(fontSize: 19.0, color: Colors.white),
      onChanged: (name) => _taskName = name,
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectDate: (date) => setState(() => _startDate = date),
      onSelectTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEstimatedDate() {
    return DateTimePicker(
      labelText: 'Estimated End',
      selectedDate: _estimatedEndDate,
      selectedTime: _estimatedEndTime,
      onSelectDate: (date) => setState(() => _estimatedEndDate = date),
      onSelectTime: (time) => setState(() => _estimatedEndTime = time),
    );
  }

  Widget _buildActualDate() {
    return DateTimePicker(
      labelText: 'Actual End',
      selectedDate: _actualEndDate,
      selectedTime: _actualEndTime,
      onSelectDate: (date) => setState(() => _actualEndDate = date),
      onSelectTime: (time) => setState(() => _actualEndTime = time),
    );
  }

  Widget _buildEfficiency() {
    final currentTask = _taskFromState();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Efficiency: ${(currentTask.efficiency).toStringAsFixed(2)}',
          style: TextStyle(fontSize: 17.0, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
