class lend {
  String _id;
  String _title;
  double _amount;
  DateTime _date;

  String get txnId => _id;
  String get txnTitle => _title;
  double get txnAmount => _amount;
  DateTime get txnDateTime => _date;

  lend(
    this._id,
    this._title,
    this._amount,
    this._date,
  );

  // convenience constructor to create a lend object
  lend.fromMap(Map<String, dynamic> map) {
    _id = map['id'].toString();
    _title = map['title'];
    _amount = map['amount'];
    _date = DateTime.parse(map['date']);
  }

  // convenience method to create a Map from this lend object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': int.tryParse(_id),
      'title': _title,
      'amount': _amount,
      'date': _date.toIso8601String()
    };
    if (_id != null) {
      map['id'] = int.tryParse(_id);
    }

    return map;
  }

  //   int getTotal(List<lend> lend) {
  //   var total = 0;
  //   if (lend.isEmpty) {
  //     return total;
  //   }
  //   lend.forEach((item) {
  //     total += item.amount;
  //   });
  //   return total;
  // }
}
