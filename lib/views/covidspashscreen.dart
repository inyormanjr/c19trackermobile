import 'dart:async';

import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:c19tracker/services/covid.info.services.dart';
import 'package:c19tracker/views/covid.main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loadingMessage = "Fetching Covid-19 Cases Data";
  bool isDone = false;
  Timer _timer;

  Future futureInitialData;

  @override
  void initState() {
    futureInitialData = getInitialData();
    super.initState();
  }

  @override
  void dispose() { 
    super.dispose();
  }

  getInitialData() async {
    return new CovidInfoService().getCovidSummary();
  }

  refreshData() {
    setState(() {
      futureInitialData = getInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(180, 40),
                bottomRight: Radius.elliptical(180, 40)),
            gradient: LinearGradient(
                colors: [Color(0xFF3383CD), Color(0xFF11249F)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Icon(
                        Icons.track_changes,
                        size: 60.0,
                        color: Colors.red[800],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      'Covid-19 Tracker',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder(
                future: futureInitialData,
                builder: (context, snapshot) {
                  var covidData = Provider.of<CovidData>(context);
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return null;
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return loadingNotifier("Fetching covid-19 data.");
                    case ConnectionState.done:
                    if(snapshot.data != null) {
                       covidData.initialSummaryInfo(snapshot.data);
                      _timer = new Timer(const Duration(seconds: 3), () {
                        Navigator.pushReplacement(
                            context,
                            (MaterialPageRoute(
                                builder: (BuildContext context) => MainApp())));
                      });
                      
                      return doneLoading("Welcome User", true, null);
                    } 
                    return doneLoading("Fetching data failed.", false, refreshData);
                    default:
                      return doneLoading("Welcome User", true,null);
                  }
                },
              ),
            )
          ],
        )
      ],
    ));
  }
}

Widget loadingNotifier(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
     CircularProgressIndicator(backgroundColor: Colors.white,),
      Padding(
        padding: EdgeInsets.only(top: 10.0),
      ),
      Text(
        message,
        style: TextStyle(
            color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w500),
      )
    ],
  );
}

Widget doneLoading(String message, bool isSuccess, Function function) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      isSuccess ? Icon(
        Icons.verified_user,
        color: Colors.white,
      ): IconButton(icon: Icon(Icons.refresh, color: Colors.white),
       onPressed: () {
           if(function != null) {
             function();
           }
      },),
      Padding(
        padding: EdgeInsets.only(top: 10.0),
      ),
      Text(
        message,
        style: TextStyle(
            color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w500),
      )
    ],
  );
}

class LoadingStatusWidget extends StatelessWidget {
  const LoadingStatusWidget({
    Key key,
    @required this.isDone,
    @required this.loadingMessage,
  }) : super(key: key);

  final bool isDone;
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !isDone
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Icon(
                  Icons.verified_user,
                  color: Colors.white,
                ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Text(
            loadingMessage,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
