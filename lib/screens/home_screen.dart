import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_bloc.dart';
import 'package:weather_app/bloc/Weather/weather_events.dart';
import 'package:weather_app/bloc/Weather/weather_states.dart';
import 'package:weather_app/bloc/authentication/auth_bloc.dart';
import 'package:weather_app/bloc/authentication/auth_event.dart';
import 'package:weather_app/bloc/authentication/auth_states.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/helper/permission_location.dart';
import 'package:weather_app/model/nearby_city_model.dart';
import 'package:weather_app/screens/server_failed_screen.dart';
import 'package:weather_app/widgets/custom_rounded_bars.dart';
import 'package:weather_app/widgets/grid_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  AnimationController _controller;
  Animation<Offset> _animationSlideUp,_animationSlideRight;
  Animation<double> _animationFade;

  @override
  void initState(){
    super.initState();
    try{
      setupLocation();
    }catch(e){
      print(e);
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animationFade = CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOutSine
    );
    
    _animationSlideUp = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _animationSlideRight = Tween<Offset>(
      begin: Offset(-1.0, .0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secoundaryColor,
        title: SlideTransition(
          position: _animationSlideRight,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('Assets/avatar.png'),
              ),
              SizedBox(width: 10.0,),
              BlocBuilder<AuthBloc,AuthStates>(
                builder:(context,state){
                  if(state is IsLogedIn)
                    return Text(state.username,style:TextStyle(color: primaryTextColor));
                  else{
                    authBloc.add(Logout());
                    return Text("");
                  }
                }
              ),
              SizedBox(width: 8.0,),
              GestureDetector(
                onTap:(){
                  weatherBloc.add(FeatchWeather());
                },
                child: Icon(Icons.gps_fixed,color: primaryColor,size: 18.0,)
              ), 
            ],
          ),
        ),
        actions: [
          IconButton(
            icon:Icon(Icons.exit_to_app,color: Colors.black,),
            onPressed: ()=>authBloc.add(Logout()),
          )
        ],
      ),
      body: BlocBuilder<WeatherBloc,WeatherState>(
        builder: (context,state){
          if(state is WeatherIsLoaded){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: CurrcentCityWeather(
                      animationFade: _animationFade,
                      state: state,
                    )
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    flex: 3,
                    child: SuggestCity(animationSlideUp: _animationSlideUp,state: state,)
                  ),
                ],
              ),
            );
          }else if(state is WeatherLodingFailed){
            return ServerFailed();
          }
        },
      ),
    );
  }
}

class CurrcentCityWeather extends StatelessWidget {
  final state,animationFade;

  CurrcentCityWeather({@required this.state,@required this.animationFade});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationFade,
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: bgGraphColor,
        elevation: 0,
        margin: EdgeInsets.all(5.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state.getWeatherModel.city,textScaleFactor: 1.6,style: TextStyle(fontWeight: FontWeight.bold),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.getWeatherModel.mainTemp+"°C",textScaleFactor: 2.2,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(state.getWeatherModel.mainWeather,textScaleFactor: 1.5)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: CustomRoundedBars(state.getWeatherModel.weatherDeatils)
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SuggestCity extends StatelessWidget {
  final animationSlideUp,state;
  SuggestCity({@required this.animationSlideUp,@required this.state});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Also Check",textScaleFactor: 1.1,style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                //TODO:
                childAspectRatio: 1.5,
                crossAxisCount: 2,
                children: state.getNearbyCites.map<Widget>((NearbyCityModel nCM){
                  return SlideTransition(
                    position: animationSlideUp,
                    child: GestureDetector(
                      onTap: (){
                        weatherBloc.add(FeatchWeather(lat: nCM.lat,long:nCM.long));
                      },
                      child: GridCard(
                        cityName: nCM.name,
                        cityTemp: nCM.temp
                      )
                    ),
                  );
                }).toList(),
              ),
            )
          ),
        ],
      ),
    );
  }
}
