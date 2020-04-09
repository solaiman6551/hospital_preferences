import 'package:flutter/material.dart';
import 'package:hospital_preferences_flutter/_routing/routes.dart';
import 'package:hospital_preferences_flutter/views/landing.dart';
import 'package:hospital_preferences_flutter/theme.dart';
import 'package:hospital_preferences_flutter/views/landing.dart';
import 'package:hospital_preferences_flutter/_routing/routes.dart';
import 'package:hospital_preferences_flutter/_routing/router.dart' as router;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      onGenerateRoute: router.generateRoute,
      initialRoute: landingViewRoute,
    );
  }
}