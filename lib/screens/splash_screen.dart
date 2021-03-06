import 'package:flutter/material.dart';
import 'package:weather_app/widgets/logo.dart';
import 'package:weather_app/widgets/logo_backgroud_container.dart';

class SplashScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:LogoBgContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigLogo(),                
              SizedBox(height: 20,),
              Text("Weather App",textScaleFactor: 1.8,style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
