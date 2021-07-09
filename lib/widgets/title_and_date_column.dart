import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TitleAndDateWidget extends StatelessWidget {
  final Transaction _transaction;

  TitleAndDateWidget(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleWidget(_transaction.title),
        _DateWidget(_transaction.date)
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  final String _title;

  _TitleWidget(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style:Theme.of(context).textTheme.title
    );
  }
}

class _DateWidget extends StatelessWidget {
  final DateTime _date;

  _DateWidget(this._date);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.yMMMMd("ru").format(_date),
      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
    );
  }
}
