import 'package:c19tracker/helpers/appHelper.dart';
import 'package:flutter/material.dart';

class HomeV2 extends StatefulWidget {
  HomeV2({Key key}) : super(key: key);

  @override
  _HomeV2State createState() => _HomeV2State();
}

void refreshData() {}

class _HomeV2State extends State<HomeV2> {
  @override
  Widget build(BuildContext context) {
    String caseName = "Total Confirmed";
    int caseCount = 2420220;
    Color percentColor = Colors.red[800];

    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Center(
                      child: Text("Case Tracker",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                    ),
                    RefreshButtonWidget(),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: ListView(
                  padding: EdgeInsets.only(left:20),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    TotalCaseWidget(caseName: caseName, caseCount: caseCount, percentColor: percentColor),
                    TotalCaseWidget(caseName: caseName, caseCount: caseCount, percentColor: percentColor),
                    TotalCaseWidget(caseName: caseName, caseCount: caseCount, percentColor: percentColor)
                  ],),
              ),
              Expanded(flex: 5,
              child: Center(),
              ),
            ]),
          )
        ],
      ),
    );
  }

  BoxShadow defaultBoxShadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 9,
      offset: Offset(2, 5), // changes position of shadow
    );
  }
}

class TotalCaseWidget extends StatelessWidget {
  const TotalCaseWidget({
    Key key,
    @required this.caseName,
    @required this.caseCount,
    @required this.percentColor,
  }) : super(key: key);

  final String caseName;
  final int caseCount;
  final Color percentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 130,
      width: MediaQuery.of(context).size.width - 50,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.5),
              child: Text(caseName,
              style: TextStyle(color: Colors.grey[500], fontSize: 15, fontWeight: FontWeight.w700),),
            ),
            Text(AppHelper.formatNumber(caseCount),
            style: TextStyle(color: Colors.black87, fontSize: 35, fontWeight: FontWeight.w900),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.arrow_drop_up, size: 30,color: percentColor,),
              Text("6%", style: TextStyle(fontSize: 17,color: percentColor),)
             ],
            ),
          ],
        ),
      ),
    );
  }
}

class RefreshButtonWidget extends StatelessWidget {
  const RefreshButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 2.2), // changes position of shadow
            ),
          ]),
      child: IconButton(
        padding: EdgeInsets.all(2),
        icon: Icon(
          Icons.refresh,
          color: Colors.grey[800],
        ),
        onPressed: () => refreshData,
        iconSize: 20,
      ),
    );
  }
}
