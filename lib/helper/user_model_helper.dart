import 'package:weather_app/model/user_model.dart';

UserModel userModelHelper(final object){
  if(object["username"]==null){
    throw Exception(["Username not found"]);
  }
  return UserModel(
    username: object["username"]
  );
}