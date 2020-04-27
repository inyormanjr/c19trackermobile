
import 'package:c19tracker/models/country.info.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class BarchartByCaseWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  BarchartByCaseWidget({this.seriesList, this.animate});


  factory BarchartByCaseWidget.createByCase(String caseName, List<CountryInfo> countries) {
      
    return  BarchartByCaseWidget(
      seriesList: _createSampleData( caseName,countries),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  charts.BarChart(
            seriesList,
            animate: animate,
          ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(String caseName, List<CountryInfo> countries) {
     List<OrdinalSales> data = [];
      countries.sort((a,b)=> b.totalConfirmed.compareTo(a.totalConfirmed));
      countries.take(5).forEach((country) {
          data.add(new OrdinalSales(country.slug, country.totalConfirmed));
      });

    return [
      new charts.Series<OrdinalSales, String>(
        id: caseName,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}