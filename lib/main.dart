import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_events.dart';
import 'package:weather_app/bloc/authentication/auth_bloc.dart';
import 'package:weather_app/bloc/authentication/auth_event.dart';
import 'package:weather_app/bloc/authentication/auth_states.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/helper/permission_location.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';

import 'bloc/Weather/weather_states.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      theme: ThemeData(
        primarySwatch:primaryColor,
        accentColor: primaryTextColor,
        splashColor: primaryColor,
        brightness: Brightness.light
      ),
      home:MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>AuthBloc(IsLoading()),
          ),
          BlocProvider<WeatherBloc>(
            create: (context) =>WeatherBloc(WeatherIsLoading()),
          ),
        ],
        child: InitApp(),
      ) 
      
    );
  }
}

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> with TickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
    try{
      setupLocation();
    }catch(e){
      print(e);
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: secoundaryColor,
      statusBarColor: secoundaryColor
    ));
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Login());
    return BlocBuilder<AuthBloc,AuthStates>(
      builder: (context,state){
        if(state is IsLogedIn){
          weatherBloc.add(FeatchWeather());
          return BlocBuilder<WeatherBloc,WeatherState>(
            builder: (context,state){        
              if(state is WeatherIsLoading){
                return SplashScreen();
              }else{
                return HomeScreen();
              }
            },
          );
        }else if(state is IsLogedOut){
          return LoginScreen();
        }else{
          return SplashScreen();
        }
      }
    );
  }
}