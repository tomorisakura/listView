import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http; //import from library pubspec.yml

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {

  Map _country = new Map();

  void _getData() async {
    var url ="http://country.io/names.json";
    var response = await http.get(url);

    if(response.statusCode == 200) {
      setState(() {
        _country = jsonDecode(response.body);
        print("Loading ... Country Length " +_country.length.toString());
      });
    } else {
      print("session destroy");
    }
  }


  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("List View Example"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("List View"),
              new Expanded(child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  String key = _country.keys.elementAt(index);
                  return new Row(children: <Widget>[
                    new Text(key.toString()+" - "),
                    new Text(_country[key].toString())
                  ],);
                },
                itemCount: _country.length,
              ))
            ],
          ),
        ),
      ),
    );
  }
}