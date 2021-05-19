import 'package:day12_login/Money/model/dbhelper.dart';
import 'package:day12_login/Money/model/mymoney.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class EntryFormMoney extends StatefulWidget {
  final Mymoney mymoney;
  EntryFormMoney(this.mymoney);
  @override
  EntryFormMoneyState createState() => EntryFormMoneyState(this.mymoney);
}

//class controller
class EntryFormMoneyState extends State<EntryFormMoney> {
  String dropdownAtas;
  String dropdownValue = 'Income';
  DbHelper dbHelper = DbHelper();

  int count = 0;

  Mymoney mymoney;
  EntryFormMoneyState(this.mymoney);
  TextEditingController descController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi

    bool check = false;
    if (mymoney != null) {
      descController.text = mymoney.desc;
      typeController.text = mymoney.type.toString();
      amountController.text = mymoney.amount.toString();
      check = true;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: mymoney == null
              ? Text('Entry Money')
              : Text('Edit Money'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  items: <String>['Income', 'Outcome'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedItem) => setState(() {
                    dropdownValue = selectedItem;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color:  Color(0xff392850),
                        textColor: Colors.white,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                           if (mymoney == null) {
                            mymoney = Mymoney(
                                descController.text,
                                this.dropdownValue,
                                int.parse(amountController.text));
                          } else {
                            // ubah data
                            // mymoney.code = codeController.text;
                            // mymoney.name = nameController.text;
                            // mymoney.price = int.parse(priceController.text);
                            // mymoney.qty = int.parse(qtyController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek mymoney
                          Navigator.pop(context, mymoney);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color:  Color(0xff392850),
                        textColor: Colors.white,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (check == true)
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color:  Color(0xff392850),
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            dbHelper.deleteMoney(mymoney.id);
                            Navigator.pop(context, mymoney);
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}
