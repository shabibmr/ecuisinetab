import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MDateEdit extends StatefulWidget {
  const MDateEdit({
    super.key,
    this.date,
    this.format = 'dd-MM-yyyy',
    this.textStyle,
    this.dateChanged,
    required this.label,
  });

  final DateTime? date;
  final String format;
  final String label;
  final TextStyle? textStyle;
  final void Function(DateTime date)? dateChanged;

  @override
  _MDateEditState createState() => _MDateEditState();
}

class _MDateEditState extends State<MDateEdit> {
  late final DateFormat formatter;

  @override
  void initState() {
    formatter = DateFormat(widget.format);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        child: FittedBox(
          child: Container(
            decoration: BoxDecoration(
              // color: Color.fromRGBO(0, 0, 0, 0.5),
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${widget.label} : "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.date != null
                          ? formatter.format(widget.date!)
                          : '  /  /  ',
                      style: widget.textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () async {
          _showDatePicker();
        },
      ),
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: widget.date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (dt != null && widget.dateChanged != null) {
      widget.dateChanged!(dt);
    }
  }
}
