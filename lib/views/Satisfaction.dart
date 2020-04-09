import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_preferences_flutter/views/UserInput.dart';


class Satisfaction extends StatefulWidget {
  Map<dynamic, dynamic> a1 = new Map();
  Map<dynamic, dynamic> a2 = new Map();
  Map<dynamic, dynamic> a3 = new Map();
  List<String> hospitalName = new List();
  String id = '';

  Satisfaction({this.a1, this.a2, this.a3, this.hospitalName, this.id});
  SatisfactionApp createState() => SatisfactionApp();
}
class SatisfactionApp extends State<Satisfaction>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            height: 40,
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              color: Colors.blueGrey,
              child: Text('Similarity Result'),
            ),
          ),
          Positioned(
            top: 50,
            height: size.height - 150,
            child: Container(
              height: size.height - 150,
              width: size.width,
              child: ListView.builder(
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text("${widget.a3.keys.elementAt(index).toString()}"),
                    subtitle: Text("Similarity : ${widget.a3.values.elementAt(index).toString()}"),
//                    trailing: Text("${a2.values.elementAt(index).toString()}"),
                  );
                },
                itemCount: widget.a3.length,
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
                child: Text('Next'),
              ),
              color: Colors.blueGrey,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return new UserInput(
                    a1: widget.a1,
                    a2: widget.a2,
                    a3: widget.a3,
                    hospitalName: widget.hospitalName,
                    id: widget.id,
                  );
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}