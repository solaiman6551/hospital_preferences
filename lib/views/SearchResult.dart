import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hospital_preferences_flutter/views/Utility.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';

class SearchResult extends StatefulWidget {
  double distanceLevel;
  double costLevel;
  double qualityLevel;

  double distancePreference;
  double costPreference;
  double qualityPreference;
  Map<String, double> userScore = new Map();

  SearchResult({
    this.distanceLevel,
    this.costLevel,
    this.qualityLevel,
    this.distancePreference,
    this.costPreference,
    this.qualityPreference,
    this.userScore
  });
  MyApp createState() => MyApp();
}

class MyApp extends State<SearchResult> {
  Map data;
  List userData;

  int x = 1, y = 3, z = 3, a = 1;
  List<List<double>> first = new List();
  List<List<double>> second = new List();
  List<List<double>> second2 = new List();
  List<List<double>> third = new List();

  List<double> ans1 = new List();
  List<double> ans2 = new List();
  List<double> ans3 = new List();

  Map<String,double> a1 = new Map();
  Map<String,double> a2 = new Map();
  Map<String,double> a3 = new Map();


  List<List<double>> sqr1 = new List();
  List<List<double>> sqr2 = new List();
  List<List<double>> product1 = new List();
  List<List<double>> sub1 = new List();
  List<List<double>> sub2 = new List();
  List<List<double>> del1 = new List();
  List<List<double>> del2 = new List();
  List<List<double>> product1st = new List();
  List<List<double>> sum_utility = new List();
  List<List<double>> sub1st = new List();
  List<List<double>> div1 = new List();
  double result_utility = 0.0;

  double smallest = 100.00;
  double largest = 0.00;
  double sum1 = 0.0;
  double sum2 = 0.0;
  double sum3 = 0.0;
  double sum4 = 0.0;
  double sum5 = 0.0;
  double sat_result = 0;
  double sum1st = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool simFlag = true;
  bool utiFlag = true;
  bool satFlag = true;
  bool hospitalScore = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          if (ConnectionState.done != snap.connectionState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(first);
            print(second);
            print(third);
            var sortedKeys1 = a1.keys.toList(growable:false)..sort((k2, k1) => a1[k1].compareTo(a1[k2]));
            LinkedHashMap sortedMap1 = new LinkedHashMap.fromIterable(sortedKeys1, key: (k) => k, value: (k) => a1[k]);

            var sortedKeys2 = a2.keys.toList(growable:false)..sort((k2, k1) => a2[k1].compareTo(a2[k2]));
            LinkedHashMap sortedMap2 = new LinkedHashMap.fromIterable(sortedKeys2, key: (k) => k, value: (k) => a2[k]);

            var sortedKeys3 = a3.keys.toList(growable:false)..sort((k2, k1) => a3[k1].compareTo(a3[k2]));
            LinkedHashMap sortedMap3 = new LinkedHashMap.fromIterable(sortedKeys3, key: (k) => k, value: (k) => a3[k]);


            if(simFlag){
              simFlag = false;
              insertAllData(sortedMap1, "Similarity", random);
            }
            if(utiFlag){
              simFlag = false;
              insertAllData(sortedMap2, "Utility", random);
            }
            if(satFlag){
              simFlag = false;
              insertAllData(sortedMap3, "Satisfaction", random);
            }

            if(hospitalScore){
              hospitalScore = false;
              insertScoreIntoDB(random , "Input_From_User");
            }
            
            return Stack(
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
                          title: Text("${sortedMap1.keys.elementAt(index).toString()}"),
                          subtitle: Text("Similarity : ${sortedMap1.values.elementAt(index).toString()}"),
//                    trailing: Text("${a2.values.elementAt(index).toString()}"),
                        );
                      },
                      itemCount: sortedMap1.length,
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
                            return new Utility(a1: sortedMap1, a2 : sortedMap2, a3: sortedMap3, hospitalName: allHospitalsNameList, id: random);
                      }));
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }




  List<String> allHospitalsNameList = new List();
  Map<String, List<double>> hospitalNameWisthScore = new Map();
  List<List<double>> parseData(Map data)  {
    List<List<double>> mytemp = new List();
    for (int i=0;i<data.values.elementAt(0).length; i++) {

      String cost = data['list'][i]['cost'];
      String distance = data['list'][i]['distance'];
      String quality = data['list'][i]['quality'];
      String hospitalName = data['list'][i]['name'];
      allHospitalsNameList.add(hospitalName);

      List<double> temp = new List();

      temp.add(double.parse(cost));
      temp.add(double.parse(distance));
      temp.add(double.parse(quality));

      hospitalNameWisthScore[hospitalName] = temp;

      mytemp.add(temp);
    }
    return mytemp;
  }

  String random = "";
  Future getData() async {
    if(data == null){
      random = numGenerator();
      print("loading");
      final response = await http.get(
          "http://my-json-server.typicode.com/solaiman6551/hospitalApi/post/");
      data = json.decode(response.body);
      List<List<double>>  myParsedData = parseData(data);
      makeArithmeticOperation(myParsedData);
    }else{
      print("not loading");
    }

    return data;
  }

  // --------------------main algorithm starts-------------------------------
  // --------------------main algorithm starts-------------------------------
  // --------------------main algorithm starts-------------------------------

  void makeArithmeticOperation(List<List<double>> myParsedData) {

    List<double> tm = new List();
    List<double> km = new List();
    tm.add(widget.costLevel);
    tm.add(widget.distanceLevel);
    tm.add(widget.qualityLevel);
    first.add(tm);
    second = myParsedData;

    km.add(widget.costPreference);
    km.add(widget.distancePreference);
    km.add(widget.qualityPreference);
    third.add(km);
    //third.add([1,2,3]);

    for (int l = 0; l < a; l++) {
      for (int k = 0; k < data.values.elementAt(0).length; k++) {
        for (int i = 0; i < x; i++) {
          for (int j = 0; j < y; j++) {

            List<double> sqr1Temp = new List();
            for(int i=0;i<100;i++){
              sqr1Temp.insert(i, 0);
            }
            sqr1Temp.insert(j, (first[l][j]*first[l][j]));
            sqr1.insert(i, sqr1Temp);
            sqr1[i][j] =(first[l][j]*first[l][j]);

            sum2 += sqr1[i][j];

            List<double> prodTemp = new List();
            for(int i=0;i<100;i++){
              prodTemp.insert(i, 0);
            }
            prodTemp.insert(j, (first[l][j] * second[k][j]));
            product1.insert(i, prodTemp);
            sum1 = sum1 + product1[i][j];
            //square of second matrix
            List<double> sqr2Temp = new List();
            for(int i=0;i<100;i++){
              sqr2Temp.insert(i, 0);
            }
            sqr2Temp.insert(j, (second[k][j] * second[k][j]));
            sqr2.insert(i, sqr2Temp);
            //sum of square for second matrix


            sum3 += sqr2[i][j];
            sum4 = sqrt(sum2 * sum3);
            sum5 = (sum1 / sum4);

            //utility
            List<double> sub1Temp = new List();
            for(int i=0;i<100;i++){
              sub1Temp.insert(i, 0);
            }
            sub1Temp.insert(j, abs(second[k][j], first[l][j]));
            sub1.insert(i, sub1Temp);

            //min
            if (sub1[i][j] < smallest) {
              smallest = sub1[i][j];
            }
            //max
            if (sub1[i][j] > largest) {
              largest = sub1[i][j];
            }

            //finding the value of del
            if (second[k][j] - first[l][j] > 0) {
              List<double> del1Temp = new List();
              for(int i=0;i<100;i++){
                del1Temp.insert(i, 0);
              }
              del1Temp.insert(j, (second[k][j] - first[l][j]));
              del1.insert(i, del1Temp);
            } else if (second[k][j] - first[l][j] < 0) {

              List<double> del1Temp = new List();
              for(int i=0;i<100;i++){
                del1Temp.insert(i, 0);
              }

              del1Temp.insert(j, (abs(second[k][j], (first[l][j]) + largest)));
              del1.insert(i, del1Temp);
            } else if ((second[k][j] - first[l][j]) == 0) {
              List<double> del1Temp = new List();
              for(int i=0;i<100;i++){
                del1Temp.insert(i, 0);
              }
              del1Temp.insert(j, smallest);
              del1.insert(i, del1Temp);
            }
            List<double> sumUtiTemp = new List();
            for(int i=0;i<100;i++){
              sumUtiTemp.insert(i, 0);
            }
            sumUtiTemp.insert(j, (third[i][j] / del1[i][j]));
            sum_utility.insert(i, sumUtiTemp);
            result_utility += sum_utility[i][j];

            //subtraction w-d
            List<double> sub1stTemp = new List();
            for(int i=0;i<100;i++){
              sub1stTemp.insert(i, 0);
            }
            sumUtiTemp.insert(j, abs(second[k][j], first[l][j]));
            sub1st.insert(i, sumUtiTemp);

            //product of sub1
            List<double> product1stTemp = new List();
            for(int i=0;i<100;i++){
              product1stTemp.insert(i, 0);
            }
            product1stTemp.insert(j, (sub1st[i][j] * third[i][j]));
            product1st.insert(i, product1stTemp);

            //div
            List<double> div1Temp = new List();
            for(int i=0;i<100;i++){
              div1Temp.insert(i, 0);
            }
            div1Temp.insert(j, (product1st[i][j] / first[l][j]));
            div1.insert(i, div1Temp);
            //summation of the matrix
            sum1st += div1[i][j];
            sat_result = abs(1, (1.00 / 3.00) * sum1st);
          }
        }

        ans1.add(double.parse(sum5.toStringAsFixed(2)));
        ans2.add(double.parse(result_utility.toStringAsFixed(2)));
        ans3.add(double.parse(sat_result.toStringAsFixed(2)));

        a1[allHospitalsNameList.elementAt(k)] = double.parse(sum5.toStringAsFixed(2));
        a2[allHospitalsNameList.elementAt(k)] = double.parse(result_utility.toStringAsFixed(2));
        a3[allHospitalsNameList.elementAt(k)] = double.parse(sat_result.toStringAsFixed(2));
        sum1 = sum3 = sum4 = sum5 = result_utility = sat_result = 0;
      }
    }
  }

  // --------------------main algorithm ends-------------------------------
  // --------------------main algorithm ends-------------------------------
  // --------------------main algorithm ends-------------------------------

  final databaseRef = FirebaseDatabase.instance.reference().child("Hospital");
  bool databaseFlag = false;


  insertAllData(Map<dynamic, dynamic> map, String node, String random){
    for(int i = 0; i< map.keys.length; i++){
      insertIntoDB(map.keys.elementAt(i), map.values.elementAt(i).toString(), node, random, i);

    }
  }
  insertScoreIntoDB(String key, String node){
    for(int i=0; i < widget.userScore.length; i++){
      var data = {
        "User-Score" : widget.userScore.values.elementAt(i).toString()
      };
      databaseRef.child(key).child(node).child(widget.userScore.keys.elementAt(i)).set(data);
    }
  }

  insertIntoDB(String key, String value, String node, String random, int index){
    var data = {
      "Hosplital_Name" : key,
      "Score" : value,
      "d1": first,
      "d2": hospitalNameWisthScore[key],
      "d3": third,
    };

    //databaseRef.child(random).child(node).child(key).set(data).then((v){});
    databaseRef.child(random).child(node).child(key).set(data);
  }

  numGenerator(){
    var rng = new Random();
    String random = '';
    for (var i = 0; i < 20; i++) {
      random += rng.nextInt(200).toString();
    }
    return random;
  }
  double abs(double a, double b) {
    return a >= b ? a - b : b - a;
  }
}