import 'package:flutter/material.dart';
import "package:intl/intl.dart";
class GlobalInfoWidget extends StatelessWidget {

  GlobalInfoWidget({this.caseCount, this.iconColor, this.caseTitle, this.icon});
   final int caseCount;
   final Color iconColor;
   final String caseTitle;
   final Icon icon;
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            maxRadius: 30.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(icon.icon, size: 40.0, color: iconColor,),
          ),
          Padding(padding: EdgeInsets.only(top: 10.0),),
          Text(formatter.format(caseCount),
              style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          Padding(padding: EdgeInsets.only(top: 5.0),),
          Text(caseTitle,
            style: TextStyle(color: iconColor, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }
}
