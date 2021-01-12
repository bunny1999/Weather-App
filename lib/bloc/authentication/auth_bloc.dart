import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/authentication/auth_event.dart';
import 'package:weather_app/bloc/authentication/auth_states.dart';
import 'package:weather_app/model/user_model.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates>{
  AuthBloc(AuthStates initialState) : super(initialState);

  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async*{
    if(event is Login){
      yield IsLoading();
      try{
        UserModel userModel;
        if(event.username==null || event.password==null){
          userModel = await Login().getUser(); 
        }else{
          userModel = await Login(username: event.username,password: event.password).registerUser();
        }
        if(userModel==null) 
          yield IsLogedOut();
        yield IsLogedIn(username: userModel.username);
      }catch(e){
        print(e);
        yield IsLogedOut();
      }
    }else{
      await Logout().removeUser();
      yield IsLogedOut();
    }
  }
}