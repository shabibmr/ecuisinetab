import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MDateRangeEdit extends StatefulWidget {
  const MDateRangeEdit({
    super.key,
    required this.dateFrom,
    required this.dateTo,
    this.format = 'dd-MM-yyyy',
    this.textStyle,
    this.dateChanged,
    required this.label,
  });

  final DateTime dateFrom;
  final DateTime dateTo;
  final String format;
  final String label;
  final TextStyle? textStyle;
  final void Function(DateTime dateFrom, DateTime dateTo)? dateChanged;

  @override
  _MDateRangeEditState createState() => _MDateRangeEditState();
}

class _MDateRangeEditState extends State<MDateRangeEdit> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.label} : "),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          formatter.format(widget.dateFrom),
                          style: widget.textStyle,
                        ),
                      ),
                      const Text(" To "),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          formatter.format(widget.dateTo),
                          style: widget.textStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () async {
          _showDateRangePicker();
        },
      ),
    );
  }

  Future<void> _showDateRangePicker() async {
    DateTimeRange? dt = await showDateRangePicker(
      initialDateRange:
          DateTimeRange(start: widget.dateFrom, end: widget.dateTo),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (dt != null && widget.dateChanged != null) {
      widget.dateChanged!(dt.start, dt.end);
    }
  }
}
