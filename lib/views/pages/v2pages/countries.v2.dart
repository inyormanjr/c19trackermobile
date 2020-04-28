import 'package:flutter/material.dart';

class CountriesV2 extends StatefulWidget {
  CountriesV2({Key key}) : super(key: key);

  @override
  _CountriesV2State createState() => _CountriesV2State();
}

class _CountriesV2State extends State<CountriesV2> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text("Countries"),),
    );
  }
}