import 'package:expense_planner/widgets/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import './model/transaction.dart';
import './widgets/chart.dart';
import './widgets/transactions_list.dart';

void main() {
  runApp(MyApp());
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown
//   ]);
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrange,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                color: Colors.black,
              ),
            ),
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
  var _childToShow = _MainChildren.TRANSACTION_LIST;

  void _addRecord(String title, double amount, DateTime date) {
    setState(() => _transactions.insert(
        0,
        Transaction(
            id: _transactions.length + 1,
            title: title,
            amount: amount,
            date: date)));
  }

  void _removeRecord(Transaction transaction) {
    setState(() => _transactions.remove(transaction));
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

  List<Widget> _children(BuildContext context, double _freeHeightSpace) {
    List<Widget> result = [];
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      result.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart"),
          Switch(
            value: _childToShow == _MainChildren.CHART,
            onChanged: (value) {
              setState(() {
                _childToShow = value
                    ? _MainChildren.CHART
                    : _MainChildren.TRANSACTION_LIST;
              });
            },
          ),
        ],
      ));
    }

    if (orientation == Orientation.portrait ||
        _childToShow == _MainChildren.CHART) {
      result.add(Container(
        height: orientation == Orientation.portrait
            ? _freeHeightSpace * 0.3
            : _freeHeightSpace * 0.7,
        child: Chart(_recentTransactions),
      ));
    }

    if (orientation == Orientation.portrait ||
        _childToShow == _MainChildren.TRANSACTION_LIST) {
      result.add(Container(
        height: _freeHeightSpace * 0.7,
        child: TransactionsListWidget(_transactions, _removeRecord),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Intl.defaultLocale = "ru";

    final _appBar = AppBar(
      title: Text("Flutter App"),
      actions: [
        IconButton(
          onPressed: () => _showForm(context),
          icon: Icon(Icons.add),
        )
      ],
    );

    final _freeHeightSpace = MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          children: _children(context, _freeHeightSpace),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(context),
      ),
    );
  }
}

enum _MainChildren { CHART, TRANSACTION_LIST }
