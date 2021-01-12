import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_events.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/helper/permission_location.dart';

class ServerFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Server Failed"),
          RaisedButton(
            color: secoundaryColor,
            onPressed: ()async{
              weatherBloc.add(FeatchWeather());
            },
            child: Text("Refresh")
          )
        ],
      ),
    );
  }
}