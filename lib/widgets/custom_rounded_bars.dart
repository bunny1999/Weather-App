import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/helper/weather_values_helper.dart';
import 'package:weather_app/model/weather_model.dart';

class CustomRoundedBars extends StatelessWidget {
  final List<WeatherDetails> data;

  CustomRoundedBars(this.data);

  @override
  Widget build(BuildContext context) {
    var seriesList = _createSampleData(data);
    return charts.BarChart(
      seriesList,
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          lineStyle: new charts.LineStyleSpec(
            color: charts.MaterialPalette.transparent),
          axisLineStyle: charts.LineStyleSpec(color: charts.MaterialPalette.white)
          )
      ),
      animationDuration: Duration(seconds: 2),
      defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(12)),
    );
  }

  static List<charts.Series<WeatherDetails, String>> _createSampleData(List<WeatherDetails> data) {

    return [
      new charts.Series<WeatherDetails, String>(
        id: 'Weather',
        colorFn: (WeatherDetails weatherDetails, __) => todayDate()==weatherDetails.date
          ?darkBarColor
          :lightBarColor,
        domainFn: (WeatherDetails weatherDetails, _) => weatherDetails.date,
        measureFn: (WeatherDetails weatherDetails, _) => weatherDetails.temp,
        data: data
      )
    ];
  }
}
