import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:c19tracker/views/covid.main.dart';
import 'package:c19tracker/views/covid.main.v2.dart';
import 'package:c19tracker/views/covidspashscreen.dart';
import 'package:c19tracker/views/covidspashscreen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
  providers: [
      ChangeNotifierProvider(create: (_) => CovidData()
    )
  ],
  child:   MaterialApp(
    theme: ThemeData(
        primaryColor: Color.fromRGBO(248,248,248, 1),
         accentColor: Color.fromRGBO(94,74,239,1),
           cardColor: Color.fromRGBO(246, 248, 249, 1)
    ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen2(),
  ),
)
);
