import 'package:location/location.dart';
import 'package:weather_app/constant/text.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/helper/nearbycity_model_helper.dart';
import 'package:weather_app/helper/weather_model_helper.dart';
import 'package:weather_app/model/nearby_city_model.dart';
import 'package:weather_app/model/weather_model.dart';

abstract class WeatherEvent {}

class FeatchWeather extends WeatherEvent {
  String lat,long;
  FeatchWeather({this.lat,this.long});

  Future<WeatherModel> getWeather() async{
    String _myLocation;
    if(lat==null || long==null){
      Location location=new Location();
      await location.getLocation()
      .then((locationData){
        lat=locationData.latitude.toString();
        long=locationData.longitude.toString();
      });
      if(lat==null && long==null)
        throw Exception(["Location Not Working"]);
    }
    _myLocation="lat=$lat&lon=$long";
    final result = await http.Client().get(API_DETAILED_URL_INIT+_myLocation+API_DETAILED_URL_END);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed:${result.statusCode}"]);
    
    return weatherModelHelper(result.body);
  }

  Future<List<NearbyCityModel>> getCityes() async{
    String _myLocation;
    if(lat==null || long==null){
      throw Exception(["Location Not Working"]);
    }
    _myLocation="lat=$lat&lon=$long";
    final result = await http.Client().get(API_AROUND_URL_INIT+_myLocation+API_AROUND_URL_END);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed:${result.statusCode}"]);
    return nearbyCityModelHelper(result.body);
  }
}

class NavigateOutWeatherScreen extends WeatherEvent{}