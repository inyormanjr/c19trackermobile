import 'package:flutter/material.dart';

class HomeLightTheme extends StatefulWidget {
  HomeLightTheme({Key key}) : super(key: key);

  @override
  _HomeLightThemeState createState() => _HomeLightThemeState();
}

class _HomeLightThemeState extends State<HomeLightTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
       body: Text("Hello"),
    );
  }
}