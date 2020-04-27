import 'package:c19tracker/helpers/appHelper.dart';
import 'package:c19tracker/models/cases.enum.dart';
import 'package:flutter/material.dart';

class NewCasesCard extends StatelessWidget {
  const NewCasesCard({
    Key key,
    @required this.newCaseCount,
    @required this.totalCaseCount,
    @required this.cardColor,
    @required this.color,
    @required this.type
  }) : super(key: key);
  final int newCaseCount;
  final int totalCaseCount;
  final Color cardColor;
  final Color color;
  final caseType type;

  @override
  Widget build(BuildContext context) {
    
    final cardTitleStyle = TextStyle( fontSize: 18.0, color: Colors.white);
    var arrowColor = Colors.white60;
    var percentValue = newCaseCount / totalCaseCount * 100;
    var caseName;
    switch (type) {
      case caseType.NewConfirmed:
          arrowColor = Colors.red;
          caseName = "Confirmed";
        break;
        case caseType.NewRecovered:
        arrowColor = Colors.green;
        caseName = "Recovered";
        break;
        case caseType.NewDeath:
        arrowColor = Colors.red[900];
        caseName = "Deceased";
        break;
      default:
    }


    return Card(
      elevation: 4.0,
      child: Container(
          color: cardColor,
          width: MediaQuery.of(context).size.width - 30,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Container(
                decoration: BoxDecoration(color: cardColor.withOpacity(0.99),
                borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: EdgeInsets.all(10),
                child: Text(
                  caseName,
                  style: cardTitleStyle,
                ),
              ),

              Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 23,
                    child:   Row(
                children: <Widget>[
                  Icon(Icons.arrow_upward, size: 20.0, color: arrowColor),
                  Text(AppHelper.formatNumber(percentValue.round()) + '%',
                    style: TextStyle(color: arrowColor, fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  ],
                  ),
                    backgroundColor: Colors.white,),

              ],
              ),
              ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.people, size: 80, color: Colors.white,),
                    ),
                  Container(
                    child: Column(
                      children: <Widget>[
                      Text(AppHelper.formatNumber(newCaseCount),
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                           ),
                           Text('New', style: TextStyle(
                           color: Colors.white70, 
                           fontSize: 18, 
                           fontWeight: FontWeight.bold),
                           ),
                      ],
                    ),
                    ),
                ],
                ),
              ),
            ],
          )),
    );
  }
}
