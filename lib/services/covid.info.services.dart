import 'dart:convert';
import 'package:c19tracker/models/country.dart';
import 'package:c19tracker/models/covid.summary.dart';
import 'package:http/http.dart' as http;

class CovidInfoService {
  final String apiBaseUrl = 'https://api.covid19api.com/';

  Future<CovidSummary> getCovidSummary() async {
    try {
        final response = await http.get(this.apiBaseUrl + 'summary');
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      var e = CovidSummary.fromJson(decode);
      return e;
    } else {
      print(response);
      throw Exception(response.body);
    }
    } catch (e) {
      
      print(e);
      return null;
    }
   
  }

  Future<List<Country>> getCountries() async {
    try {
      final response = await http.get(this.apiBaseUrl + 'countries');
      if (response.statusCode == 200) {
        Iterable decoded = json.decode(response.body);
        return decoded.map((model) => Country.fromJson(model)).toList();
      } else {
        throw Exception('Failed to fetch countries');
      }
    } catch (e) {
      
      print(e);
      return null;
    }
  }
}
