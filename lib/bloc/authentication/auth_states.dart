abstract class AuthStates{}

class IsLoading extends AuthStates{}

class IsLogedIn extends AuthStates{
  
  String username;

  IsLogedIn({this.username});

  String get getUsername => username;
}

class IsLogedOut extends AuthStates{}