import 'package:c19tracker/views/pages/countries.dart';
import 'package:c19tracker/views/pages/home.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  final tabs = [
    Home(),
    Countries(),
    // CovidInfo()
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar()
    );
  }
  var bnavitemColor = Colors.blue[900];
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white70,
      selectedLabelStyle: TextStyle(color: Colors.white70),
      elevation: 5,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home', style: TextStyle(color: bnavitemColor),),
          activeIcon: Icon(Icons.home, color: bnavitemColor,)
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.map),
             title: Text('Countries', style: TextStyle(color: bnavitemColor),),
          activeIcon: Icon(Icons.home, color: bnavitemColor,)
        ),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.info),
        //      title: Text('Covid-19 Info', style: TextStyle(color:bnavitemColor),),
        //   activeIcon: Icon(Icons.home, color: bnavitemColor,)
        // )
      ],
      currentIndex: _selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black38,
    );
  }
}
