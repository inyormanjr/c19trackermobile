import 'package:c19tracker/models/country.info.dart';

import 'global.info.dart';

class CovidSummary {
  Global globalInfo;
  List<CountryInfo> countries;

  CovidSummary(this.globalInfo, this.countries);

 CovidSummary.fromJson(Map json) {
   this.globalInfo = Global.fromJson(json['Global']);
   Iterable l = json['Countries'];
   this.countries = l.map((model)=> CountryInfo.fromJson(model)).toList(); 
 }
}