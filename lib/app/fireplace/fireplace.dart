import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/app/fireplace/date_tasks.dart';
import 'package:hindsight/app/helpers/date_list_tile.dart';
import 'package:hindsight/app/helpers/list_items_builder.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/date.dart';
import 'package:hindsight/services/database.dart';
import 'package:provider/provider.dart';

class Fireplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildTasks(context),
    );
  }

  Future<void> _deleteDate(BuildContext context, Date date) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteDate(date);
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
    return StreamBuilder<List<Date>>(
      stream: database.datesStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Date>(
          snapshot: snapshot,
          itemBuilder: (context, date) => Dismissible(
            key: Key('date-${date.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteDate(context, date),
            child: DateListTile(
              date: date,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DateTasks(date: date, database: database),
              )),
            ),
          ),
        );
      },
    );
  }
}