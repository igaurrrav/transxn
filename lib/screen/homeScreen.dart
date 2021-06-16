import 'package:flutter/material.dart';
import 'lendScreen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.teal),
          ),
          title: Text(
            "MMW Expenses",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Quicksand",
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                ),
                text: "Lend Money",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: TabBarView(
            children: <Widget>[
              LendMoney(),
            ],
          ),
        ),
      ),
    );
  }
}
