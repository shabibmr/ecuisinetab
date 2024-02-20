import 'package:flutter/material.dart';

class GMProgress extends StatelessWidget {
  const GMProgress({
    super.key,
    this.msg,
  });
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(msg ?? '___|||'),
          )
        ],
      ),
    );
  }
}
