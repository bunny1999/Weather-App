import 'dart:convert';

import 'package:weather_app/helper/weather_values_helper.dart';
import 'package:weather_app/model/weather_model.dart';

WeatherModel weatherModelHelper(final response){
  final object = json.decode(response);

  if(object["list"]==null || object["city"]==null){
    throw Exception(["Object Not Detected"]);
  } 

  List<dynamic> dailyWeather = object["list"];
  
  List<WeatherDetails> weatherDeatils=[];
  
  String todaysWeather="",
    todaysTemp="0",
    tD=todayDate();
  
  for(int i=0;i<dailyWeather.length;i += 8){
    
    if(dailyWeather[i]==null || 
      dailyWeather[i]["main"]==null ||
      dailyWeather[i]["weather"]==null || 
      dailyWeather[i]["weather"][0]==null ||
      dailyWeather[i]["dt"]==null
      ) continue;

    String date=getDate(dailyWeather[i]["dt"]);
    if(tD==date){
      todaysWeather=dailyWeather[i]["weather"][0]["main"]!=null
        ?dailyWeather[i]["weather"][0]["main"].toString()
        :"0";
      todaysTemp=dailyWeather[i]["main"]["temp"]!=null
        ?kelvinToCelcus(dailyWeather[i]["main"]["temp"]).toInt().toString()
        :"0";
    }

    weatherDeatils.add(
      WeatherDetails(
        temp:dailyWeather[i]["main"]["temp"]!=null
          ?kelvinToCelcus(dailyWeather[i]["main"]["temp"])
          :0,
        date:date,
        temp_max:dailyWeather[i]["main"]["temp_max"]!=null
          ?kelvinToCelcus(dailyWeather[i]["main"]["temp_max"]).toString()
          :"",
        temp_min:dailyWeather[i]["main"]["temp_min"]!=null
          ?kelvinToCelcus(dailyWeather[i]["main"]["temp_min"]).toString()
          :"",
        pressure:dailyWeather[i]["main"]["pressure"]!=null
          ?dailyWeather[i]["main"]["pressure"].toString()
          :"",
        humidity:dailyWeather[i]["main"]["humidity"]!=null
          ?dailyWeather[i]["main"]["humidity"].toString()
          :"",
      )
    );
  }

  return WeatherModel(
    mainWeather:todaysWeather,
    mainTemp: todaysTemp,
    city:object["city"]["name"]!=null
      ?object["city"]["name"]
      :"",
    weatherDeatils: weatherDeatils   
  );
}