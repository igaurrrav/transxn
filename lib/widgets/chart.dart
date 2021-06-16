import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/lend.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<lend> _recentLends;
  double _totalSpending = 0.0;
  List<lend> _userlends = [];

  Chart(this._recentLends);

  List<Map<String, Object>> get groupedlendValues {
    final today = DateTime.now();
    List<double> weekSums = List<double>.filled(7, 0);

    for (lend txn in _recentLends) {
      weekSums[txn.txnDateTime.weekday - 1] += txn.txnAmount;
      _totalSpending += txn.txnAmount;
    }

    return List.generate(7, (index) {
      final dayOfPastWeek = today.subtract(
        Duration(days: index),
      );

      return {
        'day': DateFormat('E').format(dayOfPastWeek)[0],
        'amount': weekSums[dayOfPastWeek.weekday - 1],
      };
    }).reversed.toList();
  }

  double totalAmount(List<lend> tx) {
    double total = 0;
    for (int i = 0; i < tx.length; i++) {
      total += tx[i].txnAmount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedlendValues.map((data) {
            
            Text(
              '${totalAmount(_userlends)}',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            );
            // data['day'],
            // data['amount'],
            // _totalSpending == 0.0
            //     ? 0.0
            //     : (data['amount'] as double) / _totalSpending,
          }).toList(),
        ),
      ),
    );
  }
}
