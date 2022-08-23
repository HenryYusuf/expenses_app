import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      // * Stamdard Looping for List in any programming language
      // for (var i = 0; i < recentTransactions.length; i++) {
      //   if (recentTransactions[i].date.day == weekDay.day &&
      //       recentTransactions[i].date.month == weekDay.month &&
      //       recentTransactions[i].date.year == weekDay.year) {
      //     totalSum += recentTransactions[i].amount;
      //   }
      // }

      // * Iterable Collection or Looping Feature in Dart
      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E('id_ID').format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            // * To check data wrong or not
            // * By using print((data['amount'] as double) / totalSpending);
            // * For checking different percentage of total spending by using fold function

            // print((data['amount'] as double) / totalSpending);

            return Flexible(
              // flex: 1,
              fit: FlexFit.tight,
              child: ChartBar(
                (data['day'] as String),
                (data['amount'] as double),
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
