import 'package:c19tracker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
class TopCasesWidget extends StatelessWidget {
   TopCasesWidget( this.countries, {Key key}) : super(key: key);
      final List<Country> countries;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 200,
      width: MediaQuery.of(context).size.width - 100,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
              Text('Top Country with cases.')
        ]
      ),
      
      ),
    );
  }
}