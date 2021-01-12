import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/authentication/auth_bloc.dart';
import 'package:weather_app/bloc/authentication/auth_event.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/widgets/custom_text_form_field.dart';
import 'package:weather_app/widgets/logo.dart';
import 'package:weather_app/widgets/logo_backgroud_container.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Expanded(
                flex: 2,
                child: Center(child: Text("Log In",textScaleFactor: 2.5,style: TextStyle(fontWeight: FontWeight.bold),))
              ),
              Expanded(
                flex: 3,
                child: AuthForm()
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallLogo(),
                    Text(' Weather App',textScaleFactor: 1.5,style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String _username,_password;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
      return Center(
          child: LogoBgContainer(
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                              errorMessgae: 'Enter username', 
                              hintText: 'Name/Username', 
                              onChanged: (value){
                                _username=value;
                              }
                            ),
                            SizedBox(height: 22,),
                            MyTextField(
                              obsureText: true,
                              errorMessgae: 'Enter Password', 
                              hintText: 'Password', 
                              onChanged: (value){
                                _password=value;
                              }
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 42,),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: RaisedButton(
                            onPressed: (){
                              if(formKey.currentState.validate()){
                                authBloc.add(Login(username: _username,password: _password));
                              }
                            },
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: primaryColor,
                            child: Text("Submit",textScaleFactor: 1.3,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ),
        );
      }
    }