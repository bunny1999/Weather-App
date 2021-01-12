String getDate(int timestamp){
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(timestamp*1000,isUtc: true);
  return date.day.toString()+"/"+date.month.toString();
}

double kelvinToCelcus(num value){
  return value-273.15;
}

String todayDate(){
  DateTime toady = DateTime.now(); 
  return toady.day.toString()+"/"+toady.month.toString(); 
}
