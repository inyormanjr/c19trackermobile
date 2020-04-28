
import 'package:c19tracker/models/country.dart';
import 'package:c19tracker/models/country.info.dart';
import 'package:c19tracker/models/covid.summary.dart';
import 'package:c19tracker/models/global.info.dart';
import 'package:c19tracker/services/covid.info.services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CovidData with ChangeNotifier  {

    CountryInfo _selectedCountry;
    CountryInfo get selectedCountry => _selectedCountry;

    setSelectedCountry(CountryInfo selCountry) {
      if(selCountry != null)
      _selectedCountry = selCountry;
    }

    List<Country> _countries;
    List<Country> get countries => _countries;

    initialCountries(List<Country> __countries) {
      if(__countries != null)
      this._countries = __countries;
    }

    CovidSummary _covidSummary;
    CovidSummary get covidSummary => _covidSummary;
    
      initialSummaryInfo(CovidSummary _summary) {
        if(_summary != null)
        _covidSummary = _summary;
      }

      attachCountryISO(List<Country> countryWithISO) {
        this._covidSummary.countries.forEach((countryInfo) {
        var code = countryWithISO
                    .where((x) =>
                        x.slug.toLowerCase() ==
                        countryInfo.slug.toLowerCase())
                    .first
                    .iso2;
        countryInfo.attachCountryFlag(code);
        });
      }

      refreshSummaryInfo() async{
      CovidInfoService().getCovidSummary().then((onValue) {
        if(onValue != null){
        this._covidSummary = onValue;
       notifyListeners();
        }
       }, onError: (err)=> print(err));
      }


    Global _globalInfo;
    Global get globalInfo => _globalInfo;

    
      initialGlobalInfo(Global global) {
        if(global != null)
        _globalInfo = global;
      }


     refreshGlobalInfo(Global __globalInfo)  {
       if(__globalInfo != null)
       _globalInfo = __globalInfo;
      notifyListeners();
    }

    DateTime _timeUpdated;
    DateTime get timeUpdate => _timeUpdated;

    updateRefreshTime(DateTime dateTime) {
      _timeUpdated = dateTime;
      notifyListeners();
    }



    bool _isDoneLoading = false;
    bool get isDoneLoading => _isDoneLoading;


    doneLoading() {
      _isDoneLoading = !isDoneLoading;
      notifyListeners();
    }


}