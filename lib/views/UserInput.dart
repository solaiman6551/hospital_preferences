import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital_preferences_flutter/views/Satisfaction.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UserInput extends StatefulWidget{
  Map<dynamic, dynamic> a1 = new Map();
  Map<dynamic, dynamic> a2 = new Map();
  Map<dynamic, dynamic> a3 = new Map();
  List<String> hospitalName = new List();
  String id = '';

  UserInput({this.a1, this.a2, this.a3, this.hospitalName, this.id});
  UserInputApp createState() => UserInputApp();

}

class UserInputApp extends State<UserInput>{

  Map data;
  List userData;

  Future getData() async {
    final response = await http.get(
        "http://my-json-server.typicode.com/solaiman6551/hospitalApi/post/");
    data = json.decode(response.body);
    setState(() {
      userData = data["list"];
      print("keno ${userData}");
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<List<double>> parseData(Map data)  {
    List<List<double>> mytemp = new List();
    for (int i=0;i<data.values.elementAt(0).length; i++) {

      String cost = data['list'][i]['cost'];
      String distance = data['list'][i]['distance'];
      String quality = data['list'][i]['quality'];
      String hospitalName = data['list'][i]['name'];

      List<double> temp = new List();

      temp.add(double.parse(cost));
      temp.add(double.parse(distance));
      temp.add(double.parse(quality));

      mytemp.add(temp);
    }
    return mytemp;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            height: size.height - 200,
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              height: 550.0,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: userData == null ? 0 : userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "${userData[index]["name"]}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Similarity : ${widget.a1.values.elementAt(index).toString()}")
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Utility : ${widget.a2.values.elementAt(index).toString()}")
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Satisfaction : ${widget.a3.values.elementAt(index).toString()}")
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: 40,
            child: FlatButton(

              child: Container(
                alignment: Alignment.center,
                width: size.width,
                child: Text('Done And Exit'),
              ),
              color: Colors.blueGrey,
              onPressed: (){
                SystemNavigator.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

}