import 'package:flutter/material.dart';

class AddTransactionWidget extends StatefulWidget {
  final Function _addRecord;

  AddTransactionWidget(this._addRecord);

  @override
  _AddTransactionWidgetState createState() => _AddTransactionWidgetState();
}

class _AddTransactionWidgetState extends State<AddTransactionWidget> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _prepareAndAddRecord() {
    final title = _titleController.text;
    final amountText = _amountController.text;

    if(title.isEmpty || amountText.isEmpty) {
      return;
    }

    final amount =  double.parse(amountText);

    if(amount <= 0) {
      return;
    }

    widget._addRecord(title, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Column(
          children: [
            _CustomTextField(
              label: "Наименование",
              controller: _titleController,
              onSubmit: _prepareAndAddRecord,
            ),
            _CustomTextField(
              label: "Цена",
              controller: _amountController,
              inputType: TextInputType.number,
              onSubmit: _prepareAndAddRecord,
            ),
            _AddTransactionButton(_prepareAndAddRecord),
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final Function onSubmit;

  _CustomTextField(
      {this.label, this.controller, this.inputType, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        onSubmitted: (_) => onSubmit(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }
}

class _AddTransactionButton extends StatelessWidget {
  final Function _addRecord;

  _AddTransactionButton(this._addRecord);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text("Добавить"),
      onPressed: _addRecord,
    );
  }
}
