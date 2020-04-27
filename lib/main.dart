import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:c19tracker/views/covid.main.dart';
import 'package:c19tracker/views/covidspashscreen.dart';
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
      primaryColor: Colors.white,
        accentColor: Colors.black,
    ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ),
)
);
