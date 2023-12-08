import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MTimeEdit extends StatefulWidget {
  const MTimeEdit({
    super.key,
    required this.time,
    this.format = 'hh:mm',
    this.textStyle,
    this.dateChanged,
  });

  final TimeOfDay? time;
  final String format;
  final TextStyle? textStyle;
  final void Function(TimeOfDay date)? dateChanged;

  @override
  _MTimeEditState createState() => _MTimeEditState();
}

class _MTimeEditState extends State<MTimeEdit> {
  late final DateFormat formatter;

  @override
  void initState() {
    formatter = DateFormat(widget.format);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.5),
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.time != null ? widget.time!.format(context) : '  -   ',
            style: widget.textStyle,
          ),
        ),
      ),
      onTap: () async {
        _showTimePicker();
      },
    );
  }

  Future<void> _showTimePicker() async {
    TimeOfDay? dt = await showTimePicker(
      context: context,
      initialTime: widget.time ?? const TimeOfDay(hour: 16, minute: 0),
    );

    print('Time : $dt');

    if (dt != null && widget.dateChanged != null) {
      final now = DateTime.now();
      widget.dateChanged!(dt);
    }
  }
}
