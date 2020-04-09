import 'package:flutter/material.dart';
import 'package:hospital_preferences_flutter/_routing/routes.dart';
import 'package:hospital_preferences_flutter/views/landing.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());

    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
