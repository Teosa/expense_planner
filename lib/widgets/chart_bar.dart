import 'package:flutter/material.dart';

import '../model/chart_record.dart';

class ChartBar extends StatelessWidget {
  final ChartRecord _record;
  final double _percent;

  ChartBar(this._record, this._percent);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FittedBox(
            child: Text("\$${_record.amount.toStringAsFixed(0)}"),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 60,
            width: 20,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: _percent * 0.01,
                  widthFactor: 0.9,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text("${_record.day}"),
        ],
      ),
    );
  }
}
