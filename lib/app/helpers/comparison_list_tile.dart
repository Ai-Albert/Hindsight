import 'package:flutter/material.dart';
import 'package:hindsight/models/comparison.dart';
import 'package:intl/intl.dart';

class ComparisonListTile extends StatelessWidget {
  const ComparisonListTile({Key key, @required this.comparison, this.onTap}) : super(key: key);

  final Comparison comparison;
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${DateFormat('MM-dd-yyyy').format(comparison.start1)}', style: style),
              Text('${comparison.taskName1}', style: style),
              Text('Efficiency: ${(comparison.efficiency1).toStringAsFixed(2)}', style: style),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${DateFormat('MM-dd-yyyy').format(comparison.start2)}', style: style),
              Text('${comparison.taskName2}', style: style),
              Text('Efficiency: ${(comparison.efficiency2).toStringAsFixed(2)}', style: style),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Efficiency difference: ${(comparison.efficiency1 - comparison.efficiency2).toStringAsFixed(2)}', style: style),
            ],
          ),
        ],
      ),
    );
  }
}
