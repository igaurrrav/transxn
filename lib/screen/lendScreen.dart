// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:transxn/widgets/chart.dart';
// import 'package:transxn/widgets/new_transaction.dart';
// import 'package:transxn/widgets/transaction_list.dart';
// import '../database/database_helper_lend.dart';
// import '../model/lend.dart';

// class LendMoney extends StatefulWidget {
//   @override
//   _LendMoneyState createState() => _LendMoneyState();
// }

// class _LendMoneyState extends State<LendMoney> {
//   List<lend> _userlends = [];
//   bool _showChart = false;

//   List<lend> get _recentlends {
//     DateTime lastDayOfPrevWeek = DateTime.now().subtract(
//       Duration(days: 6),
//     );
//     lastDayOfPrevWeek = DateTime(
//       lastDayOfPrevWeek.year,
//       lastDayOfPrevWeek.month,
//       lastDayOfPrevWeek.day,
//     );
//     return _userlends.where((element) {
//       return element.txnDateTime.isAfter(
//         lastDayOfPrevWeek,
//       );
//     }).toList();
//   }

//   _LendMoneyState() {
//     _updateUserlendsList();
//   }

//   void _updateUserlendsList() {
//     Future<List<lend>> res = DatabaseHelper.instance.getAllLends();

//     res.then((txnList) {
//       setState(() {
//         _userlends = txnList;
//       });
//     });
//   }

//   void _showChartHandler(bool show) {
//     setState(() {
//       _showChart = show;
//     });
//   }

//   Future<void> _addNewlend(
//       String title, double amount, DateTime chosenDate) async {
//     final newTxn = lend(
//       DateTime.now().millisecondsSinceEpoch.toString(),
//       title,
//       amount,
//       chosenDate,
//     );
//     int res = await DatabaseHelper.instance.insert(newTxn);

//     if (res != 0) {
//       _updateUserlendsList();
//     }
//   }

//   void _startAddNewlend(BuildContext context) {
//     showModalBottomSheet<dynamic>(
//       isScrollControlled: true,
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext bc) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.80,
//           decoration: new BoxDecoration(
//             color: Colors.white,
//             borderRadius: new BorderRadius.only(
//               topLeft: const Radius.circular(25.0),
//               topRight: const Radius.circular(25.0),
//             ),
//           ),
//           child: NewlendForm(_addNewlend),
//         );
//       },
//     );
//   }

//   Future<void> _deletelend(String id) async {
//     int res = await DatabaseHelper.instance.deletelendById(
//       int.tryParse(id),
//     );
//     if (res != 0) {
//       _updateUserlendsList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final AppBar myAppBar = AppBar(
//       title: Text(
//         'Lend Money',
//         style: TextStyle(
//           fontFamily: "Quicksand",
//           fontWeight: FontWeight.w400,
//           fontSize: 20.0,
//         ),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () => _startAddNewlend(context),
//           tooltip: "Add New lend",
//         ),
//       ],
//     );
//     MediaQueryData mediaQueryData = MediaQuery.of(context);
//     final bool isLandscape =
//         mediaQueryData.orientation == Orientation.landscape;

//     final double availableHeight = mediaQueryData.size.height -
//         myAppBar.preferredSize.height -
//         mediaQueryData.padding.top -
//         mediaQueryData.padding.bottom;

//     final double availableWidth = mediaQueryData.size.width -
//         mediaQueryData.padding.left -
//         mediaQueryData.padding.right;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       // appBar: myAppBar,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             if (isLandscape)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Show Chart",
//                     style: TextStyle(
//                       fontFamily: "Rubik",
//                       fontSize: 16.0,
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                   Switch.adaptive(
//                     activeColor: Colors.amber[700],
//                     value: _showChart,
//                     onChanged: (value) => _showChartHandler(value),
//                   ),
//                 ],
//               ),
//             if (isLandscape)
//               _showChart
//                   ? myChartContainer(
//                       height: availableHeight * 0.8,
//                       width: 0.6 * availableWidth)
//                   : mylendListContainer(
//                       height: availableHeight * 0.8,
//                       width: 0.6 * availableWidth),
//             if (!isLandscape)
//               myChartContainer(
//                 height: availableHeight * 0.3,
//                 width: availableWidth,
//               ),
//             if (!isLandscape)
//               mylendListContainer(
//                 height: availableHeight * 0.7,
//                 width: availableWidth,
//               ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Platform.isIOS
//           ? Container()
//           : FloatingActionButton(
//               child: Icon(Icons.add),
//               tooltip: "Add New lend",
//               onPressed: () => _startAddNewlend(context),
//             ),
//     );
//   }

//   Widget myChartContainer({double height, double width}) {
//     return Container(
//       height: height,
//       width: width,
//       child: Chart(_recentlends),
//     );
//   }

//   Widget mylendListContainer({double height, double width}) {
//     return Container(
//       height: height,
//       width: width,
//       child: lendList(_userlends, _deletelend),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:transxn/widgets/chart.dart';
import 'package:transxn/widgets/new_transaction.dart';
import 'package:transxn/widgets/transaction_list.dart';
import '../database/database_helper_lend.dart';
import '../model/lend.dart';

class LendMoney extends StatefulWidget {
  @override
  _LendMoneyState createState() => _LendMoneyState();
}

class _LendMoneyState extends State<LendMoney> {
  List<lend> _userlends = [];
  bool _showChart = false;

  List<lend> get _recentlends {
    DateTime lastDayOfPrevWeek = DateTime.now().subtract(
      Duration(days: 6),
    );
    lastDayOfPrevWeek = DateTime(
      lastDayOfPrevWeek.year,
      lastDayOfPrevWeek.month,
      lastDayOfPrevWeek.day,
    );
    return _userlends.where((element) {
      return element.txnDateTime.isAfter(
        lastDayOfPrevWeek,
      );
    }).toList();
  }

  _LendMoneyState() {
    _updateUserlendsList();
  }

  void _updateUserlendsList() {
    Future<List<lend>> res = DatabaseHelper.instance.getAllLends();

    res.then((txnList) {
      setState(() {
        _userlends = txnList;
      });
    });
  }

  void _showChartHandler(bool show) {
    setState(() {
      _showChart = show;
    });
  }

  Future<void> _addNewlend(
      String title, double amount, DateTime chosenDate) async {
    final newTxn = lend(
      DateTime.now().millisecondsSinceEpoch.toString(),
      title,
      amount,
      chosenDate,
    );
    int res = await DatabaseHelper.instance.insert(newTxn);

    if (res != 0) {
      _updateUserlendsList();
    }
  }

  void _startAddNewlend(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.80,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: NewlendForm(_addNewlend),
        );
      },
    );
  }

  Future<void> _deletelend(String id) async {
    int res = await DatabaseHelper.instance.deletelendById(
      int.tryParse(id),
    );
    if (res != 0) {
      _updateUserlendsList();
    }
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
    final AppBar myAppBar = AppBar(
      title: Text(
        'Lend Money',
        style: TextStyle(
          fontFamily: "Quicksand",
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewlend(context),
          tooltip: "Add New lend",
        ),
      ],
    );
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final bool isLandscape =
        mediaQueryData.orientation == Orientation.landscape;

    final double availableHeight = mediaQueryData.size.height -
        myAppBar.preferredSize.height -
        mediaQueryData.padding.top -
        mediaQueryData.padding.bottom;

    final double availableWidth = mediaQueryData.size.width -
        mediaQueryData.padding.left -
        mediaQueryData.padding.right;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ignore: sdk_version_ui_as_code
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 16.0,
                      color: Colors.grey[500],
                    ),
                  ),
                  Switch.adaptive(
                    activeColor: Colors.amber[700],
                    value: _showChart,
                    onChanged: (value) => _showChartHandler(value),
                  ),
                ],
              ),
            // ignore: sdk_version_ui_as_code
            if (isLandscape)
              _showChart
                  ? myChartContainer(
                      height: availableHeight * 0.8,
                      width: 0.6 * availableWidth)
                  : mylendListContainer(
                      height: availableHeight * 0.8,
                      width: 0.6 * availableWidth),
            // ignore: sdk_version_ui_as_code
            // if (!isLandscape)
            //   myChartContainer(
            //     height: availableHeight * 0.3,
            //     width: availableWidth,
            //   ),
            Text(
              '${totalAmount(_userlends)}',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            // ignore: sdk_version_ui_as_code
            if (!isLandscape)
              mylendListContainer(
                height: availableHeight * 0.7,
                width: availableWidth,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              tooltip: "Add New lend",
              onPressed: () => _startAddNewlend(context),
            ),
    );
  }

  Widget myChartContainer({double height, double width}) {
    return Container(
      height: height,
      width: width,
      child: Chart(_recentlends),
    );
  }

  Widget mylendListContainer({double height, double width}) {
    return Container(
      height: height,
      width: width,
      child: lendList(_userlends, _deletelend),
    );
  }
}
