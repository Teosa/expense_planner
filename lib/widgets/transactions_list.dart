import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionsListWidget extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeRecord;

  TransactionsListWidget(this._transactions, this._removeRecord);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _getChild(context),
    );
  }

  Widget _getChild(BuildContext context) {
    if (_transactions.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return _TransactionWidget(_transactions[index], _removeRecord);
        },
        itemCount: _transactions.length,
      );
    } else {
      return Column(
        children: [
          Text(
            "No transaction added yet",
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              height: 200,
              child: Image.asset(
                "resources/images/waiting.png",
                fit: BoxFit.cover,
              )),
        ],
      );
    }
  }
}

class _TransactionWidget extends StatelessWidget {
  final Transaction _transaction;
  final Function _removeRecord;

  _TransactionWidget(this._transaction, this._removeRecord);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
                child: Text("\$${_transaction.amount.toStringAsFixed(2)}")),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMd("ru").format(_transaction.date),
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeRecord(_transaction),
        ),
      ),
    );
  }
}
