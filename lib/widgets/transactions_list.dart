import 'package:flutter/material.dart';

import './amount.dart';
import './title_and_date_column.dart';
import '../model/transaction.dart';

class TransactionsListWidget extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionsListWidget(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _getChild(context),
    );
  }

  Widget _getChild(BuildContext context) {
    if(_transactions.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return _TransactionWidget(_transactions[index]);
        },
        itemCount: _transactions.length,
      );
    } else {
      return Column(
        children: [
          Text("No transaction added yet",
          style: Theme.of(context).textTheme.title,),
          SizedBox(height: 30,),
          Container(height: 200, child: Image.asset("resources/images/waiting.png", fit: BoxFit.cover,)),
        ],
      );
    }
  }
}

class _TransactionWidget extends StatelessWidget {
  final Transaction _transaction;

  _TransactionWidget(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          AmountWidget(_transaction.amount),
          TitleAndDateWidget(_transaction)
        ],
      ),
    );
  }
}
