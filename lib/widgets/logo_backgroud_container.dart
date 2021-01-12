import 'package:flutter/material.dart';

class LogoBgContainer extends StatelessWidget {
  Widget child;
  LogoBgContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('Assets/bg_2.png')
        )
      ),
      child: child,
    );
  }
}