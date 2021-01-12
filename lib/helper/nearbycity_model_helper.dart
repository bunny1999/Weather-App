import 'dart:convert';

import 'package:weather_app/helper/weather_values_helper.dart';
import 'package:weather_app/model/nearby_city_model.dart';

List<NearbyCityModel> nearbyCityModelHelper(final response){
  final object = json.decode(response);
  
  if(object["list"]==null){
    throw Exception(["Object Not Detected"]);
  }

  List<NearbyCityModel> nearbyCityModels=[];
  List<dynamic> list = object["list"];

  for(int i=1;i<list.length;i++){
    if(list[i]==null || 
      list[i]["name"]==null ||
      list[i]["coord"]==null ||
      list[i]["main"]==null
    ) continue;

    nearbyCityModels.add(
      NearbyCityModel(
        name:list[i]["name"],
        lat: list[i]["coord"]["lat"]!=null
          ?list[i]["coord"]["lat"].toString()
          :null,
        long: list[i]["coord"]["lon"]!=null
          ?list[i]["coord"]["lon"].toString()
          :null,
        temp: list[i]["main"]["temp"]!=null
          ?kelvinToCelcus(list[i]["main"]["temp"]).toInt().toString()
          :"0",
      )
    );
  }

  return nearbyCityModels;
}