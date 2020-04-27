

import 'package:c19tracker/helpers/appHelper.dart';
import 'package:c19tracker/models/country.info.dart';
import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryInfoDetailPage extends StatefulWidget {
  CountryInfoDetailPage({Key key}) : super(key: key);
  @override
  _CountryInfoDetailPageState createState() => _CountryInfoDetailPageState();
}

class _CountryInfoDetailPageState extends State<CountryInfoDetailPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var covidDataProvider = Provider.of<CovidData>(context);
    var country = covidDataProvider.selectedCountry;
    
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body:  buildSafeArea(country),);
  }

  SafeArea buildSafeArea(CountryInfo country) {

  
    return SafeArea(
            child: Stack(
              children: <Widget>[
                
          Align(alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.close, size: 30, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
            ),
            ),
                Container(
                  margin: EdgeInsets.only(top: 20),
       child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                                        maxRadius: 40.0,
                                        backgroundColor: Colors.white,
                                        backgroundImage: Image.asset(
                                                country.countryFlag,
                                                package:
                                                    'country_icons')
                                            .image,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          country.slug.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                          ),
                                        ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(children: <Widget>[
                        Card(
                       child: Container(margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                          Center(child: Text("CONFIRMED",style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue[900]),
                            ),
                            ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              buildCaseCounterInfo("Total", country.totalConfirmed, Colors.red[900]),
                              buildCaseCounterInfo("New", country.newConfirmed, Colors.red[900])
                          ],
                          ),
                      ],
                    ),
                    ),
                        ),
                     Card(
                     child: Container(margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                        children: <Widget>[
                           Center(child: Text("DECEASED",style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue[900]),),),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              buildCaseCounterInfo("Total", country.totalDeaths, Colors.red[900]),
                              buildCaseCounterInfo("New ", country.newDeaths, Colors.red[900])
                          ],
                          ),
                        ],
                    ),
                    ),
                     ),
                    Card(
                     child: Container(margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: Column(
                        children: <Widget>[
                           Center(child: Text("RECOVERED",style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue[900]),),),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              buildCaseCounterInfo("Total Recovery", country.totalRecovered, Colors.green[900]),
                              buildCaseCounterInfo("New Recovery", country.newRecovered, Colors.green[900])
                          ],
                          ),
                        ],
                    ),
                    ),
                     ),
                    ],),
                  ),
                ],
       ),
  ),
              ],
            ),
    );
  }

  Widget buildCaseCounterInfo(String caseType, int caseCount, Color caseColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
                        Text(AppHelper.formatNumber(caseCount).toString(),
                        style: TextStyle(color: caseColor,
                        shadows: [
                          Shadow(color: caseColor, blurRadius: 35.0,)
                        ],
                         fontSize: 35)),
                        Text(caseType, style: TextStyle(color: Colors.blue[900]),)
                      ],
                      ),
    );
  }
}