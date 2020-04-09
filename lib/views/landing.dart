import 'package:flutter/material.dart';
//import 'package:hospital_preferences_flutter/_routing/routes.dart';
import 'package:hospital_preferences_flutter/utils/colors.dart';
import 'package:hospital_preferences_flutter/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:hospital_preferences_flutter/views/dashboard.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Change Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );


    final registerBtn = Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext){
            return new ChildrenPage();
          }));
        }, //navigation
        //onPressed: () => Navigator.pushNamed(context, registerViewRoute),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'Tap To Proceed',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
      ),
    );

    final buttons = Padding(
      padding: EdgeInsets.only(
        top: 80.0,
        bottom: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Column(
        children: <Widget>[SizedBox(height: 20.0), registerBtn],
      ),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 70.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                //children: <Widget>[logo, appName, buttons],
                children: <Widget>[buttons],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
