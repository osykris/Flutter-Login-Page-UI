import 'package:day12_login/Money/model/dbhelper.dart';
import 'package:day12_login/Money/model/mymoney.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'entryFormMoney.dart';

//pendukung program asinkron
class Money extends StatefulWidget {
  @override
  MoneyState createState() => MoneyState();
}

class MoneyState extends State<Money> {
  @override
  DbHelper dbHelper = DbHelper();
  int count = 0;
  int total_money = 0;
  List<Mymoney> itemList;

  @override
  void initState() {
    super.initState();
    updateListView();
    cariTotalFirst();
  }

  void cariTotalFirst() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Mymoney>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          for (var i = 0; i < itemList.length; i++) {
            if (itemList[i].type.toString() == 'Income') {
              total_money = total_money + itemList[i].amount;
            } else if (itemList[i].type.toString() == 'Outcome') {
              total_money = total_money - itemList[i].amount;
            }
          }
        });
      });
    });
  }

  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Mymoney>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Money'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          height: 70,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Color(0xFFF1E6FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Text("Balance : Rp. $total_money,00",
                style: TextStyle(fontSize: 22, color: Colors.black87)),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            int result = await dbHelper.insertMoney(item);
            if (item.type == 'Income') {
              setState(() {
                this.total_money += item.amount;
              });
            } else {
              setState(() {
                this.total_money -= item.amount;
              });
            }
            if (result > 0) {
              updateListView();
            }
          }
        },
        tooltip: 'Increment',
        backgroundColor: Color(0xff392850),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Mymoney> navigateToEntryForm(
      BuildContext context, Mymoney item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryFormMoney(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        if (itemList[index].type == 'Income') {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFF1E6FF),
                child: Icon(Icons.arrow_back),
              ),
              title: Text(
                "Rp." + this.itemList[index].amount.toString() + ",00",
                style: textStyle,
              ),
              subtitle: Text(this.itemList[index].desc.toString()),
              onTap: () async {
                // var item =
                //     await navigateToEntryForm(context, this.itemList[index]);

                // if (item != null) {
                //   int result = await dbHelper.updateMoney(item);

                //   updateListView();
                // }
              },
            ),
          );
        } else {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                 backgroundColor: Color(0xFFF1E6FF),
                child: Icon(Icons.arrow_forward),
              ),
              title: Text(
                "Rp." + this.itemList[index].amount.toString() + ",00",
                style: textStyle,
              ),
              subtitle: Text(this.itemList[index].desc.toString()),
              onTap: () async {
                // var item =
                //     await navigateToEntryForm(context, this.itemList[index]);

                // if (item != null) {
                //   int result = await dbHelper.updateMoney(item);

                //   updateListView();
                // }
              },
            ),
          );
        }
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Mymoney>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
