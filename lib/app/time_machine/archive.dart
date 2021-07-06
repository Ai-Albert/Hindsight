import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/app/helpers/comparison_list_tile.dart';
import 'package:hindsight/app/helpers/list_items_builder.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/models/comparison.dart';
import 'package:hindsight/services/database.dart';

class Archive extends StatelessWidget {
  const Archive({Key key, @required this.database}) : super(key: key);

  final Database database;

  Future<void> _deleteComparison(BuildContext context, Comparison comparison) async {
    try {
      await database.deleteComparison(comparison);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Archive'),
      ),
      body: Center(
        child: _buildComparisons(context),
      ),
    );
  }

  Widget _buildComparisons(BuildContext context) {
    return StreamBuilder<List<Comparison>>(
      stream: database.comparisonsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Comparison>(
          snapshot: snapshot,
          itemBuilder: (context, comparison) => Dismissible(
            key: Key('comparison-${comparison.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteComparison(context, comparison),
            child: ComparisonListTile(comparison: comparison),
          ),
        );
      },
    );
  }
}
