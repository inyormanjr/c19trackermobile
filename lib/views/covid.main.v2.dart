import 'package:c19tracker/views/pages/v2pages/countries.v2.dart';
import 'package:c19tracker/views/pages/v2pages/home.v2.dart';
import 'package:flutter/material.dart';

class CovidAppMain extends StatefulWidget {
  CovidAppMain({Key key}) : super(key: key);

  @override
  _CovidAppMainState createState() => _CovidAppMainState();
}

class _CovidAppMainState extends State<CovidAppMain> {
  int _selectedIndex = 0;
  final tabs = [HomeV2(), CountriesV2()];

  void onItemTapped(int index) {
    setState(() {
    _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var bnavitemColor = Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedLabelStyle: TextStyle(color: Colors.white70),
        elevation: 0,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(color: bnavitemColor),
              ),
              activeIcon: Icon(
                Icons.home,
                color: bnavitemColor,
              )),
          BottomNavigationBarItem(
             backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.map),
              title: Text(
                'Countries',
                style: TextStyle(color: bnavitemColor),
              ),
              activeIcon: Icon(
                Icons.map,
                color: bnavitemColor,
              )),
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
      ),
    );
  }
}
