import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionWidget extends StatefulWidget {
  final Function _addRecord;

  AddTransactionWidget(this._addRecord);

  @override
  _AddTransactionWidgetState createState() => _AddTransactionWidgetState();
}

class _AddTransactionWidgetState extends State<AddTransactionWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate;

  void _prepareAndAddRecord() {
    final title = _titleController.text;
    final amountText = _amountController.text;
    final date = _dateController.text;

    if (title.isEmpty || amountText.isEmpty || date.isEmpty) {
      return;
    }

    final amount = double.parse(amountText);

    if (amount <= 0) {
      return;
    }

    widget._addRecord(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((value) {
      if(value != null) {
        _selectedDate = value;
        _dateController.text = DateFormat.yMMMMd("ru").format(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
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
              _DateField(_showDatePicker, _dateController),
              _AddTransactionButton(_prepareAndAddRecord),
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
        ),
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
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        primary: Theme.of(context).textTheme.button.color,
      ),
      onPressed: _addRecord,
    );
  }
}

class _DateField extends StatelessWidget {
  final Function _showDatePicker;
  final TextEditingController _dateController;

  _DateField(this._showDatePicker, this._dateController);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: TextField(
              controller: _dateController,
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Дата",
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: TextButton(
              onPressed: _showDatePicker,
              child: Text("Выбрать дату"),
              style: TextButton.styleFrom(
                  primary: Theme.of(context).textTheme.button.color),
            ),
          )
        ],
      ),
    );
  }
}
