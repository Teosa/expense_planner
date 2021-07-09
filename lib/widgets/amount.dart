import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final double _amount;

  AmountWidget(this._amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "\$${_amount.toStringAsFixed(2)}",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).accentColor),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).accentColor, width: 2)),
    );
  }
}
