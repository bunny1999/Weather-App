import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/helper/user_model_helper.dart';
import 'package:weather_app/model/user_model.dart';

abstract class AuthEvents{}

class Login extends AuthEvents{
  String username,password;
  Login({this.password,this.username});
  
  Future<UserModel> registerUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user',json.encode({"username":username,"password":password}).toString());
    return getUser(prefs: prefs);
  }

  Future<UserModel> getUser({SharedPreferences prefs}) async{
    SharedPreferences _prefs;
    if(prefs==null)
      _prefs = await SharedPreferences.getInstance();
    else{
      _prefs=prefs;
    }
    final object = json.decode(_prefs.getString('user'));
    if(object==null) return null;
    return userModelHelper(object);
  }
}

class Logout extends AuthEvents{
  
  Future<bool> removeUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('user');
  }
}