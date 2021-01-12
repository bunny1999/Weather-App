import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_events.dart';
import 'package:weather_app/bloc/Weather/weather_states.dart';
import 'package:weather_app/helper/weather_model_helper.dart';
import 'package:weather_app/model/nearby_city_model.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  WeatherBloc(WeatherState initialState) : super(initialState);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if(event is FeatchWeather){
      yield WeatherIsLoading();
      try{
        FeatchWeather _featchWeather = FeatchWeather(lat: event.lat,long: event.long);
        WeatherModel weatherModel = await _featchWeather.getWeather();
        List<NearbyCityModel> nearbyCityModels = await _featchWeather.getCityes();
        yield WeatherIsLoaded(weatherModel: weatherModel,nearbyCityModels: nearbyCityModels);
      }catch(e){
        print(e);
        yield WeatherLodingFailed();
      }
    }else{
      yield WeatherLodingFailed();
    }
  }
  
}