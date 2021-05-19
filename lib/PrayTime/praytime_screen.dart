import 'dart:convert';

import 'package:day12_login/PrayTime/header_content.dart';
import 'package:day12_login/PrayTime/list_jadwal.dart';
import 'package:day12_login/PrayTime/model/ResponseJadwal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class PrayTimeScreen extends StatefulWidget {
  @override
  _PrayTimeScreenState createState() => _PrayTimeScreenState();
}

class _PrayTimeScreenState extends State<PrayTimeScreen> {
  TextEditingController _locationController = TextEditingController();

  Future<ResponseJadwal> getJadwal({String location}) async {
    String url =
        'https://api.pray.zone/v2/times/today.json?city=${location}&school=9';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    return ResponseJadwal.fromJsonMap(jsonResponse);
  }

  @override
  void initState() {
    if (_locationController.text.isEmpty || _locationController.text == null) {
      _locationController.text = 'Palangkaraya';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final header = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width - 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                    color: Colors.black26)
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://cdn0-production-images-kly.akamaized.net/roz5mLax7zwqhxcGSuZpzlfPkP8=/640x360/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3006199/original/000679200_1577364563-66089674_1343284469169211_31322345451623785_n__1_.jpg"))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Tooltip(
                message: 'Ubah Lokasi',
                child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      _showDialogEditLocation(context);
                    }),
              ),
            ],
          ),
        ),
        FutureBuilder(
            future: getJadwal(
                location: _locationController.text.toLowerCase().toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HeaderContent(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Data Tidak Tersedia',
                          style: TextStyle(color: Colors.white),
                        )));
              }
              return Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
              );
            })
      ],
    );

    final body = Expanded(
        child: FutureBuilder(
            future: getJadwal(
                location: _locationController.text.toLowerCase().toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListJadwal(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Data Tidak Tersedia'));
              }

              return Center(child: CircularProgressIndicator());
            }));

    return Scaffold(
      body: Column(
        children: <Widget>[header, body],
      ),
    );
  }

  void _showDialogEditLocation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ubah Lokasi'),
            content: TextField(
              controller: _locationController,
              decoration: InputDecoration(hintText: 'Lokasi'),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Batal'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context, () {
                    setState(() {
                      getJadwal(
                          location: _locationController.text
                              .toLowerCase()
                              .toString());
                    });
                  });
                },
                child: new Text('Ok'),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }
}
