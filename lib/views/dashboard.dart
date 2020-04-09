import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hospital_preferences_flutter/utils/colors.dart';
import 'SearchResult.dart';

class ChildrenPage extends StatefulWidget {
  @override
  _ChildrenPage createState() => _ChildrenPage();
}

class _ChildrenPage extends State<ChildrenPage> {
  Map data;
  List userData;
  String _costLevel, _distance, _qualityLevel; // Option
  String _distancePreference, _costPreference, _qualityPreference; // Option

  List<int> _locations = [1, 2, 3, 4, 5];

  static const Map<String, int> distanceOptions = {
    "Very Near": 1,
    "Near": 2,
    "Average Distance": 3,
    "Far": 4,
    "Very Far": 5,
  };

  static const Map<String, int> costOptions = {
    "Very Low Cost": 1,
    "Low Cost": 2,
    "Average Cost": 3,
    "High Cost": 4,
    "Expensive": 5,
  };

  static const Map<String, int> qualityOptions = {
    "Very Low Quality": 1,
    "Low Quality": 2,
    "Average Quality": 3,
    "Good Quality": 4,
    "Excellent Quality": 5,
  };

  static const Map<String, int> preferenceChoice = {
    "Very Low": 1,
    "Low": 2,
    "Medium": 3,
    "High": 4,
    "Very High": 5,
  };

  Future getData() async {
    final response = await http.get(
        "http://my-json-server.typicode.com/solaiman6551/hospitalApi/post/");
    data = json.decode(response.body);
    setState(() {
      userData = data["list"];
      scoreDropdown(userData);
    });
  }

  Map<String, double> scoreDropdownMap = new Map();
  double currentScore = 1.0;
  List<double> scores = [1,2,3,4,5];
  scoreDropdown(List data){

    try{
      for(int i=0;i < userData.length;i++){
        scoreDropdownMap[userData[i]["name"].toString()] = 1.0;
      }
    }catch(e){
      print("error in assigingin : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Hospital Preferences"),
      backgroundColor: primaryColor,
    );

    return Scaffold(
      //bottomNavigationBar: bottomNavBar,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.grey,
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: MediaQuery.of(context).size.height+700,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("What is your preference regarding the distance of the hospital?"),
                    ),
                    Divider(),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Select Distance Level',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      value: _distance,
                      onChanged: (newValue) {
                        setState(() {
                          _distance = newValue;
                        });
                      },
                      items: distanceOptions
                          .map((description, value) {
                        return MapEntry(
                            description,
                            DropdownMenuItem<String>(
                              child: Text(description),
                              value: value.toString(),
                            ));
                      })
                          .values
                          .toList(),
                    ),
//                    DropdownButton(
//                      hint: Text('Select distance Level'),
//                      value: _distance,
//                      onChanged: (newValue) {
//                        setState(() {
//                          _distance = newValue;
//                        });
//                      },
//
//                      items: distanceOptions
//                          .map((description, value) {
//                        return MapEntry(
//                            description,
//                            DropdownMenuItem<String>(
//                              child: Text(description),
//                              value: value.toString(),
//                            ));
//                      })
//                          .values
//                          .toList(),
//
//                    ),

                    ListTile(
                      title: Text("What is your preference regarding the cost of the hospital?"),
                    ),
                    Divider(),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Select Cost Level',
                        prefixIcon: Icon(Icons.monetization_on),
                      ),
                      value: _costLevel,
                      onChanged: (newValue) {
                        setState(() {
                          _costLevel = newValue;
                        });
                      },
                      items: costOptions
                          .map((description, value) {
                        return MapEntry(
                            description,
                            DropdownMenuItem<String>(
                              child: Text(description),
                              value: value.toString(),
                            ));
                      })
                          .values
                          .toList(),
                    ),
//                    DropdownButton(
//                      hint: Text('Select cost Level'), // Not necessary for Option 1
//                      value: _costLevel,
//                      onChanged: (newValue) {
//                        setState(() {
//                          _costLevel = newValue;
//                        });
//                      },
//                      items: costOptions
//                          .map((description, value) {
//                        return MapEntry(
//                            description,
//                            DropdownMenuItem<String>(
//                              child: Text(description),
//                              value: value.toString(),
//                            ));
//                      })
//                          .values
//                          .toList(),
//                    ),

                    ListTile(
                      title: Text("What is your preference regarding the quality of the hospital?"),
                    ),
                    Divider(),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Select Quality Level',
                        prefixIcon: Icon(Icons.star),
                      ),
                      value: _qualityLevel,
                      onChanged: (newValue) {
                        setState(() {
                          _qualityLevel = newValue;
                        });
                      },
                      items: qualityOptions
                          .map((description, value) {
                        return MapEntry(
                            description,
                            DropdownMenuItem<String>(
                              child: Text(description),
                              value: value.toString(),
                            ));
                      })
                          .values
                          .toList(),
                    ),
//                    DropdownButton(
//                      hint: Text('Select Quality Level'), // Not necessary for Option 1
//                      value: _qualityLevel,
//                      onChanged: (newValue) {
//                        setState(() {
//                          _qualityLevel = newValue;
//                        });
//                      },
//                      items: qualityOptions
//                          .map((description, value) {
//                        return MapEntry(
//                            description,
//                            DropdownMenuItem<String>(
//                              child: Text(description),
//                              value: value.toString(),
//                            ));
//                      })
//                          .values
//                          .toList(),
//                    ),

                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(

                  children: <Widget>[

                    ListTile(
                      title: Text(
                          "Please give us a feedback depending on your preferences. If you are planning to go to hospital, the table below considering your service preferences depending on some category.",
                        textAlign: TextAlign.justify,

                      ),
                    ),
                    Divider(),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Select Distance Preference Level',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      value: _distancePreference,
                      onChanged: (newValue) {
                        setState(() {
                          _distancePreference = newValue;
                        });
                      },
                      items: preferenceChoice
                          .map((description, value) {
                        return MapEntry(
                            description,
                            DropdownMenuItem<String>(
                              child: Text(description),
                              value: value.toString(),
                            ));
                      })
                          .values
                          .toList(),
                    ),
//                    DropdownButton(
//                      hint: Text('Select Distance Preference Level'), // Not necessary for Option 1
//                      value: _distancePreference,
//                      onChanged: (newValue) {
//                        setState(() {
//                          _distancePreference = newValue;
//                        });
//                      },
//                      items: preferenceChoice
//                          .map((description, value) {
//                        return MapEntry(
//                            description,
//                            DropdownMenuItem<String>(
//                              child: Text(description),
//                              value: value.toString(),
//                            ));
//                      })
//                          .values
//                          .toList(),
//                    ),

                    Divider(),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Select Cost Preference Level',
                        prefixIcon: Icon(Icons.monetization_on),
                      ),
                      value: _costPreference,
                      onChanged: (newValue) {
                        setState(() {
                          _costPreference = newValue;
                        });
                      },
                      items: preferenceChoice
                          .map((description, value) {
                        return MapEntry(
                            description,
                            DropdownMenuItem<String>(
                              child: Text(description),
                              value: value.toString(),
                            ));
                      })
                          .values
                          .toList(),
                    ),
//                    DropdownButton(
//                      hint: Text('Select Cost Preference Level'), // Not necessary for Option 1
//                      value: _costPreference,
//                      onChanged: (newValue) {
//                        setState(() {
//                          _costPreference = newValue;
//                        });
//                      },
//                      items: preferenceChoice
//                          .map((description, value) {
//                        return MapEntry(
//                            description,
//                            DropdownMenuItem<String>(
//                              child: Text(description),
//                              value: value.toString(),
//                            ));
//                      })
//                          .values
//                          .toList(),
//                    ),
                    Divider(),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Select Quality Preference Levell',
                        prefixIcon: Icon(Icons.star),
                      ),
                      value: _qualityPreference,
                      onChanged: (newValue) {
                        setState(() {
                          _qualityPreference = newValue;
                        });
                      },
                      items: preferenceChoice
                          .map((description, value) {
                        return MapEntry(
                            description,
                            DropdownMenuItem<String>(
                              child: Text(description),
                              value: value.toString(),
                            ));
                      })
                          .values
                          .toList(),
                    ),
//                    DropdownButton(
//                      hint: Text(
//                          'Select Quality Preference Level'), // Not necessary for Option 1
//                      value: _qualityPreference,
//                      onChanged: (newValue) {
//                        setState(() {
//                          _qualityPreference = newValue;
//                        });
//                      },
//                      items: preferenceChoice
//                          .map((description, value) {
//                        return MapEntry(
//                            description,
//                            DropdownMenuItem<String>(
//                              child: Text(description),
//                              value: value.toString(),
//                            ));
//                      })
//                          .values
//                          .toList(),
//                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.0),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(

                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "When you want to select a hospital, you have the following options (shown below) to choose from. Please provide your impression about the hospitals considering your preferences. ",
                        textAlign: TextAlign.justify,
                      ),
                      subtitle: Text("N.B: 1=Lowest; 5=Highest",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: userData == null ? 0 : userData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            //onTap: (){Navigator.of(context).push(MaterialPageRoute(builder:(context)=>InstitutionsDetailsPage('${userData[index]["id"]}')));},
                            child: ListTile(
                              title: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          "${userData[index]["name"]}",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          "Cost: ${userData[index]["cost"]}000TK",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          "Distance: ${userData[index]["distance"]} KM",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          "Quality: ${userData[index]["quality"]}/10",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              trailing: Container(
                                width: 50,
                                height: 40,
                                //color: Colors.deepPurple,
                                child: DropdownButton(
                                  hint: Text('s'), // Not necessary for Option 1
                                  value: scoreDropdownMap.values.elementAt(index),
                                  onChanged: (newValue) {
                                    setState(() {
                                      scoreDropdownMap[scoreDropdownMap.keys.elementAt(index).toString()] = newValue;
                                      currentScore = newValue;
                                    });
                                  },
                                  items: scores.map((item) {
                                    return DropdownMenuItem(
                                      child: new Text(item.toString()),
                                      value: item,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    color: primaryColor,
                    elevation: 10.0,
                    shadowColor: Colors.white70,
                    child: MaterialButton(
                      child: Text('Search',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext) {
                          return new SearchResult(
                            distanceLevel: double.parse(_distance),
                            costLevel: double.parse(_costLevel),
                            qualityLevel: double.parse(_qualityLevel),
                            distancePreference: double.parse(_distancePreference),
                            costPreference: double.parse(_costPreference),
                            qualityPreference: double.parse(_qualityPreference),
                            userScore: scoreDropdownMap,
                          );
                        }));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


