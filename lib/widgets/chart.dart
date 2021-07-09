import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../extensions.dart';
import '../model/chart_record.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;

  Chart(this._transactions);

  List<ChartRecord> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var transaction in _transactions) {
        if (transaction.date.isSameDate(weekDay)) {
          totalSum += transaction.amount;
        }
      }

      return ChartRecord(DateFormat.E().format(weekDay), totalSum);
    });
  }

  double get _overallSum {
    return _groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue += element.amount);
  }

  double _calculatePercentage(ChartRecord record) {
    if (record.amount > 0) {
      return 100 * record.amount / _overallSum;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
          elevation: 6,
          //color: Colors.orange,
          margin: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _groupedTransactionValues
                  .map((record) => Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(record, _calculatePercentage(record)),
                      ))
                  .toList(),
            ),
          )),
    );
  }
}
