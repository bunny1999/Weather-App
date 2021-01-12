
import 'package:weather_app/model/nearby_city_model.dart';
import 'package:weather_app/model/weather_model.dart';

abstract class WeatherState{}

class WeatherIsLoading extends WeatherState{} 

class WeatherIsLoaded extends WeatherState{
  WeatherModel weatherModel;
  final List<NearbyCityModel> nearbyCityModels;

  WeatherIsLoaded({this.weatherModel,this.nearbyCityModels});

  WeatherModel get getWeatherModel => weatherModel;
  List<NearbyCityModel> get getNearbyCites => nearbyCityModels;

}

class WeatherLodingFailed extends WeatherState{}