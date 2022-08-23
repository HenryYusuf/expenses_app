import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  const NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController(text: '0');

  void submitData() {
    final enteredTtile = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTtile.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget._addNewTransaction(
      enteredTtile,
      enteredAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              // ! function without parameter
              onSubmitted: (_) => submitData(),
              // * onChanged: (val) => titleInput = val,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              // ! function without parameter
              onSubmitted: (_) => submitData(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              // * onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              onPressed: submitData,
              textColor: Colors.purple,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
