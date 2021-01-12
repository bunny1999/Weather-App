import 'package:location/location.dart';

Future<bool> setupLocation() async {
  Location location=new Location();
  PermissionStatus _permissionStatus;
  bool _serviceEnabled;
    _serviceEnabled= await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await location.requestService();
      if(!_serviceEnabled){
        throw Exception(["Request Not Enabled"]);
      }
    }

    _permissionStatus = await location.hasPermission();
    if(_permissionStatus==PermissionStatus.DENIED){
      _permissionStatus=await location.requestPermission();
      if(_permissionStatus==PermissionStatus.GRANTED){
        return true;  
      }
    }
    return true;
  }
