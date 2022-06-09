import 'package:flutter/material.dart';
import 'package:kaamasaan/screens/home_screen.dart';

class RouteGenerator {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return _errorPage();
    }
  }

  static MaterialPageRoute _errorPage() {
    return MaterialPageRoute(
      builder: (context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("Error Route")),
          body: Text("Error Route"),
        ),
      ),
    );
  }
}
