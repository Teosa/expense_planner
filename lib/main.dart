import 'package:expense_planner/widgets/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import './model/transaction.dart';
import './widgets/chart.dart';
import './widgets/transactions_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.deepOrange,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    color: Colors.black))),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _addRecord(String title, double amount) {
    setState(() => _transactions.insert(
        0,
        Transaction(
            id: _transactions.length + 1,
            title: title,
            amount: amount,
            date: DateTime.now())));
  }

  void _showForm(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: AddTransactionWidget(_addRecord),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  List<Transaction> get _recentTransactions {
    var weekAgo = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tr) => tr.date.isAfter(weekAgo)).toList();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Intl.defaultLocale = "ru";

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
        actions: [
          IconButton(
            onPressed: () => _showForm(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionsListWidget(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(context),
      ),
    );
  }
}
