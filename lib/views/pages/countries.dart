import 'package:c19tracker/helpers/appHelper.dart';
import 'package:c19tracker/models/country.info.dart';
import 'package:c19tracker/providers/covid.data.provider.dart';
import 'package:c19tracker/views/pages/countryInfo.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

List<CountryInfo> filteredCountries;
List<CountryInfo> initialCountry;
TextEditingController searchController;


class _CountriesState extends State<Countries> {

  @override
  void initState() { 
    searchController = new TextEditingController();
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    var covidDataProvider = Provider.of<CovidData>(context);
    fetchData(covidDataProvider);
    return Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
        children: <Widget>[
          Container(
            height: 240,
            decoration: BoxDecoration(color: Colors.blue[800]),
            child: Column(
              children: <Widget>[
               Container(
                margin: EdgeInsets.only(top:25),
                child: Text("COUNTRIES", style: TextStyle(fontSize: 30, 
                fontWeight: FontWeight.bold,
                color: Colors.white),
                ),
                ),
                Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: searchController,
              onChanged: (value) {
                setState(() {
            
                  });
       
      },
   decoration:  InputDecoration(
     fillColor: Colors.grey[200],
     filled: true,
    border: InputBorder.none,
    prefixIcon: Icon(Icons.search, color: Colors.black45,),
    hintText: 'Ex. USA, INDIA ETC',
          ),
        ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right:20, top: 10),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35)),
            margin: EdgeInsets.only(top: 170),
            child: ListView.builder(
              
              shrinkWrap: true,
              itemBuilder: (context, indext) {
                return Container(
                  margin: EdgeInsets.only(bottom:8),
                  decoration: BoxDecoration(
                  color: Colors.grey[200],  
                  borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    highlightColor: Colors.blue.withOpacity(0),
                    splashColor: Colors.red,
                      onTap: () {
                           covidDataProvider.setSelectedCountry(filteredCountries[indext]);
                          Navigator.of(context).push( CupertinoPageRoute(
                            maintainState: false,
                            fullscreenDialog: true,
                            builder: (context)=> CountryInfoDetailPage()));
                      },
                      child: ListTile(
                     leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: Image.asset(
                                    filteredCountries[indext].countryFlag,
                                    package:
                                        'country_icons')
                                .image,
                          ),
                    title: Text(filteredCountries[indext].slug.toUpperCase().toString(),
                    style: TextStyle(color: Colors.blue[800]),),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                        Column(children: <Widget>[
                          Text("Confirmed"),
                          Text(AppHelper.formatNumber(filteredCountries[indext].totalConfirmed),
                          style: TextStyle(color: Colors.blue[800]),)
                        ],
                        ),
                         Column(children: <Widget>[
                          Text("Deaths"),
                          Text(AppHelper.formatNumber(filteredCountries[indext].totalDeaths),
                          style: TextStyle(color: Colors.red[800]),)
                        ],
                        ),
                          Column(children: <Widget>[
                          Text("Recovered"),
                          Text(AppHelper.formatNumber(filteredCountries[indext].totalRecovered),
                          style: TextStyle(color: Colors.green[800]),)
                        ],
                        )
                    ],
                    ),
                    ),
                  ),
                );
            }, 
             itemCount: filteredCountries.length),
          )
        ],
        ),
      ),
    );
  }

  void fetchData(CovidData covidDataProvider) {
    initialCountry = covidDataProvider.covidSummary.countries;
    filteredCountries = initialCountry;
    filteredCountries.forEach((countryInfo) {
      var code = covidDataProvider.countries
                    .where((x) =>
                        x.slug.toLowerCase() ==
                        countryInfo.slug.toLowerCase())
                    .first
                    .iso2;
        countryInfo.attachCountryFlag(code);
    });
    filteredCountries.sort((a,b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    if(searchController.value != null || searchController.value.text != "") {
          filteredCountries = initialCountry.where((model) => 
          model.slug.toLowerCase().contains(searchController.value.text.toLowerCase()))
          .toList();
    }
    filteredCountries = filteredCountries.take(10).toList();
  }
}


