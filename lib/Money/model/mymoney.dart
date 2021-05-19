class Mymoney {
  int _id;
  String _desc;
  String _type;
  int _amount;

  int get id => this._id;

  set id(int value) => this._id = value;

  String get desc => this._desc;

  set desc(String value) => this._desc = value;

  String get type => this._type;

  set type(String value) => this._type = value;

  int get amount => this._amount;

  set amount(int value) => this._amount = value;

  Mymoney(this._desc, this._type, this._amount);

  Mymoney.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._type = map['type'];
    this._desc = map['desc'];
    this._amount = map['amount'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['desc'] = desc;
    map['type'] = type;
    map['amount'] = amount;
    return map;
  }
}
