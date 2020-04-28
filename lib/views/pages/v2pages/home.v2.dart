
import 'package:c19tracker/helpers/appHelper.dart';
import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeV2 extends StatefulWidget {
  HomeV2({Key key}) : super(key: key);

  @override
  _HomeV2State createState() => _HomeV2State();
}

void refreshData() {}

class _HomeV2State extends State<HomeV2> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() { 
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<CovidData>(context);
    var globalInfo = cp.covidSummary.globalInfo;
    var countriesInfo = cp.covidSummary.countries;
    Color percentColor = Colors.red[800];
    countriesInfo.sort((a,b) =>b.totalConfirmed.compareTo(a.totalConfirmed));
    var top3Confirmed = countriesInfo;
    countriesInfo = cp.covidSummary.countries;
    countriesInfo.sort((a,b) =>b.totalDeaths.compareTo(a.totalDeaths));
    var top3Deaths = countriesInfo;
    countriesInfo = cp.covidSummary.countries;
     countriesInfo.sort((a,b) => b.totalRecovered.compareTo(a.totalRecovered));
    var top3Recovered = countriesInfo;
    

    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
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
                height: 185,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    TotalCaseWidget(caseName: "Confirmed", caseCount: globalInfo.totalConfirmed,newCaseCOunt: globalInfo.newConfirmed, percentColor: Colors.orangeAccent),
                    TotalCaseWidget(caseName: "Deseased",  caseCount: globalInfo.totalDeaths,newCaseCOunt: globalInfo.newDeaths, percentColor: percentColor),
                    TotalCaseWidget(caseName: "Recovery",  caseCount: globalInfo.totalRecovered,newCaseCOunt: globalInfo.newRecovered, percentColor: Colors.green[900])
                  ],),
              ),
              Expanded(flex: 5,
              child: Container(
                margin: EdgeInsets.only(top:10),
                  child: DefaultTabController(
                  initialIndex: 0,
                  length: 3,
                  child: Column(children: <Widget>[
                    TabBar(
                   tabs: [
                Tab(child: Text("Top Confirmed", style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 14),),),
                Tab(child: Text("Top Deaths", style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 14),),),
                Tab(child: Text("Top Recovery", style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 14),),),
                  ],
            ),
             Expanded(
              flex: 10,
              child: TabBarView(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right:10, top: 15),
                    child: Stack(
                      fit:StackFit.expand,
                      children: <Widget>[
                      Container(
                        child: Column(children: top3Confirmed.take(3).map((model) => 
                           Expanded(child: buildCountryCaseCard(context, model.countryFlag, model.slug.toUpperCase(), model.countryCode))
                        ).toList()
                        ),
                      )
                  ],
                 ),
                  ),
                ),
                 Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right:10, top: 15),
                    child: Stack(
                      fit:StackFit.expand,
                      children: <Widget>[
                      Container(
                        child: Column(children: top3Deaths.take(3).map((model) => 
                           Expanded(child: buildCountryCaseCard(context, model.countryFlag, model.slug.toUpperCase(), model.countryCode))
                        ).toList()
                        ),
                      )
                  ],
                 ),
                  ),
                ),
                 Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right:10, top: 15),
                    child: Stack(
                      fit:StackFit.expand,
                      children: <Widget>[
                      Container(
                        child: Column(children: top3Recovered.take(3).map((model) => 
                           Expanded(child: buildCountryCaseCard(context, model.countryFlag, model.slug.toUpperCase(), model.countryCode))
                        ).toList()
                        ),
                      )
                  ],
                 ),
                  ),
                ),
              ],
            ),
            ),
                ],
                ),
                ),
              ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget buildCountryCaseCard(BuildContext context, String countryFlagString, String countryName, String countryCode) {
    return   Container(
              child: Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 4,
                      child: ListTile(
                        leading: CircleAvatar(backgroundImage: Image.asset(countryFlagString, package:'country_icons').image),
                        title: Text(countryName),
                        subtitle: Text(countryCode),
                      ),
                      ),
    );
  }

  BoxShadow defaultBoxShadow() { return BoxShadow(
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
    @required this.newCaseCOunt,
    @required this.percentColor,
  }) : super(key: key);

  final String caseName;
  final int caseCount;
  final int newCaseCOunt;
  final Color percentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 5, right: 5),
      height: 130,
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
        elevation: 2,
        color: Theme.of(context).cardColor,
        child: Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: percentColor.withOpacity(0.5), width: 3), 
                      left: BorderSide(color: percentColor.withOpacity(0.5), width: 3),
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
                      ),

      ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.people, size: 180,color: percentColor.withOpacity(0.2),)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.5),
                    child: Text(caseName,
                    style: TextStyle(color: Colors.grey[800], fontSize: 18, fontWeight: FontWeight.w800),),
                  ),
                  Text(AppHelper.formatNumber(caseCount),
                  style: TextStyle(color: Colors.black87, fontSize: 35, fontWeight: FontWeight.w900),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(AppHelper.formatNumber(newCaseCOunt) + " (New)", 
                      style: TextStyle(fontSize: 20, 
                      color: percentColor,
                      fontWeight: FontWeight.bold),)
                   ],
                  ),
                ],
              ),
            ],
          ),
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
