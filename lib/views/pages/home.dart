import 'package:c19tracker/helpers/appHelper.dart';
import 'package:c19tracker/models/cases.enum.dart';
import 'package:c19tracker/models/country.dart';
import 'package:c19tracker/models/country.info.dart';
import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:c19tracker/services/covid.info.services.dart';
import 'package:c19tracker/widgets/case.card.dart';
import 'package:c19tracker/widgets/global.info.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Country>> countriesWithISO;

  @override
  void initState() {
    fetchCountriesWIthISO();
    super.initState();
  }

  void fetchCountriesWIthISO() async {
    try {
     countriesWithISO =  CovidInfoService().getCountries();
    }
    catch (e) {
        print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var covidDataProvider = Provider.of<CovidData>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
                  child: RefreshIndicator(
                    color: Colors.white,
            backgroundColor: Colors.red,
            onRefresh: () {
              return onRefresh(covidDataProvider);
            },
              child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                HomeHeaderWidget(),
                HorizontalCardList(context: context),
                HighestCasesSection(countriesWithISO: countriesWithISO, covidDataProvider: covidDataProvider)
              ],
            ),
          ),
        ));
  }

  onRefresh(CovidData covidDataProvider) {
    fetchCountriesWIthISO();
    return covidDataProvider.refreshSummaryInfo();
  }
}

class HighestCasesSection extends StatelessWidget {
  const HighestCasesSection({
    Key key,
    @required this.countriesWithISO,
    @required this.covidDataProvider,
  }) : super(key: key);

  final Future<List<Country>> countriesWithISO;
  final CovidData covidDataProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: countriesWithISO,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  ));
            case ConnectionState.done:
              covidDataProvider.initialCountries(snapshot.data);
              var topCountries =
                  covidDataProvider.covidSummary.countries;

              topCountries.sort((a, b) =>
                  b.totalConfirmed.compareTo(a.totalConfirmed));
              var topConfirmed  = topCountries.take(5).toList();
              topConfirmed.forEach((model) {
                var code = covidDataProvider.countries
                    .where((x) =>
                        x.slug.toLowerCase() ==
                        model.slug.toLowerCase())
                    .first
                    .iso2;
                model.attachCountryFlag(code);
              });

               topCountries.sort((a, b) =>
                  b.totalDeaths.compareTo(a.totalDeaths));
              var topDeaths  = topCountries.take(5).toList();
              topDeaths.forEach((model) {
                var code = covidDataProvider.countries
                    .where((x) =>
                        x.slug.toLowerCase() ==
                        model.slug.toLowerCase())
                    .first
                    .iso2;
                model.attachCountryFlag(code);
              });

              topCountries.sort((a, b) =>
                  b.totalRecovered.compareTo(a.totalRecovered));
              var topRecovered  = topCountries.take(5).toList();
              topRecovered.forEach((model) {
                var code = covidDataProvider.countries
                    .where((x) =>
                        x.slug.toLowerCase() ==
                        model.slug.toLowerCase())
                    .first
                    .iso2;
                model.attachCountryFlag(code);
              });


              return Container(
                  margin: EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 30),
                  child:   Column(children: <Widget>[
                    HighestCardByCase(topCountries: topConfirmed,
                    caseName: "HIGHEST CONFIRMED",type: caseType.TotalConfirmed),
                    HighestCardByCase(topCountries: topDeaths,caseName: "HIGHEST DEATHS", type: caseType.TotalDeath),
                    HighestCardByCase(topCountries: topRecovered,caseName: "HIGHEST RECOVERY", type: caseType.TotalRecovered,),
                  ],));
            default:
              return Text("None");
          }
        });
  }
}

class HighestCardByCase extends StatelessWidget {
   const HighestCardByCase({
    Key key,
    @required this.topCountries,
    @required this.caseName,
    @required this.type
  }) : super(key: key);

  final List<CountryInfo> topCountries;
  final String caseName;
  final caseType type;
  
  getValueByCase(CountryInfo country) {

      switch (type) {
        case caseType.TotalConfirmed:
          return country.totalConfirmed;
          break;
          case caseType.TotalDeath:
          return country.totalDeaths;
          break;
          case caseType.TotalRecovered:
          return country.totalRecovered;
          break;
        default:
        return 0;
      }
  }

  setCardColorByCase() {
      switch (type) {
          case caseType.TotalConfirmed:
          case caseType.NewConfirmed:
          return Color.fromRGBO(53, 109, 228, 1);
          break;
          case caseType.TotalDeath:
          case caseType.NewDeath:
          return Color.fromRGBO(229, 65, 65, 1);
          break;
          case caseType.TotalRecovered:
          case caseType.NewRecovered:
          return Color.fromRGBO(90, 176, 119, 1);
          break;
        default:
        return Colors.blue[800];
      }
  }

  @override
  Widget build(BuildContext context) {
      Color caseCountColor = Colors.red.shade800;
      if(type == caseType.TotalRecovered) {
        caseCountColor = Colors.green[900];
      }

    
    return Card(
      color:  setCardColorByCase(),
      elevation: 2.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            child: Center(
              child: Text(
                caseName,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Column(
            children: topCountries
                .map((model) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: Image.asset(
                                model.countryFlag,
                                package:
                                    'country_icons')
                            .image,
                      ),
                      title: Align(
                          alignment:
                              Alignment.topLeft,
                          child: Text(
                            model.slug.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight:
                                    FontWeight.bold),
                          )),
                      trailing: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white30, 
                              boxShadow: [
                                BoxShadow(color: Colors.white, spreadRadius: 3),
                              ]),
                            child: Text(
                              AppHelper.formatNumber(
                                 getValueByCase(model)),
                              style: TextStyle(
                                  color:
                                     caseCountColor,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
        ],
      ),
    );
  }
}

class HorizontalCardList extends StatelessWidget {
  const HorizontalCardList({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final covidData = Provider.of<CovidData>(context);
    var data = covidData.covidSummary.globalInfo;

    return Container(
      margin: EdgeInsets.only(top: 15.0),
      height: 180,
      child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10, right: 10),
          children: <Widget>[
            NewCasesCard(
              newCaseCount: data.newConfirmed,
              totalCaseCount: data.totalConfirmed,
              cardColor: Color.fromRGBO(90, 176, 119, 1),
              color: Color.fromRGBO(90, 176, 119, 1),
              type: caseType.NewConfirmed,
            ),
            NewCasesCard(
              newCaseCount: data.newDeaths,
              cardColor: Color.fromRGBO(229, 65, 65, 1),
              totalCaseCount: data.totalDeaths,
              color: Color.fromRGBO(229, 65, 65, 1),
              type: caseType.NewDeath,
            ),
            NewCasesCard(
              newCaseCount: data.newRecovered,
              cardColor: Color.fromRGBO(53, 109, 228, 1),
              totalCaseCount: data.totalRecovered,
              color: Color.fromRGBO(229, 65, 65, 1),
              type: caseType.NewRecovered,
            )
          ]),
    );
  }
}

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(190, 40),
            bottomRight: Radius.elliptical(190, 40)),
        gradient: LinearGradient(
            colors: [Color(0xFF3383CD), Color(0xFF11249F)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(alignment: Alignment.center, child: TotalCasesWidget())
        ],
      ),
    );
  }
}

class TotalCasesWidget extends StatelessWidget {
  const TotalCasesWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final covidData = Provider.of<CovidData>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Case Summary',
              style: TextStyle(
                  fontFamily: 'LexendGiga',
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 35.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GlobalInfoWidget(
                caseCount: covidData.covidSummary.globalInfo.totalConfirmed,
                iconColor: Colors.blue,
                caseTitle: 'Confirmed',
                icon: Icon(Icons.confirmation_number),
              ),
              GlobalInfoWidget(
                caseCount: covidData.covidSummary.globalInfo.totalDeaths,
                iconColor: Colors.red[900],
                caseTitle: 'Deceased',
                icon: Icon(Icons.airline_seat_flat),
              ),
              GlobalInfoWidget(
                caseCount: covidData.covidSummary.globalInfo.totalRecovered,
                iconColor: Colors.green,
                caseTitle: 'Recovered',
                icon: Icon(Icons.supervised_user_circle),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(new DateFormat.yMMMd().format(new DateTime.now()),
            style: TextStyle(color: Colors.white, fontSize: 20),
            )
            ),
        ],
      ),
    );
  }
}
