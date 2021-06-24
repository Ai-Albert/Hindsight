import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hindsight/custom_widgets/helpers/format.dart';
import 'package:hindsight/custom_widgets/helpers/input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.onSelectDate,
    this.onSelectTime,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onSelectDate;
  final ValueChanged<TimeOfDay> onSelectTime;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectDate(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(
      color: Colors.white,
      fontSize: 18.0,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText,
            valueText: Format.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          flex: 4,
          child: InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectTime(context),
          ),
        ),
      ],
    );
  }
}
