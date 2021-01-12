import 'package:flutter/material.dart';
import 'package:weather_app/constant/colors.dart';

class BigLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: primaryColorLite,
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: primaryColor,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image(
            image: AssetImage("Assets/light_128.png"),
          ),
        ),
      ),
    );
  }
}

class SmallLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image(
            image: AssetImage("Assets/light_128.png"),
          ),
        ),
      ),
    );
  }
}