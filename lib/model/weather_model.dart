class WeatherModel{
  String city,
    mainWeather,
    mainTemp;
  List<WeatherDetails> weatherDeatils;

  WeatherModel({
    this.mainWeather,
    this.mainTemp,
    this.city,
    this.weatherDeatils
  });
}

class WeatherDetails{
  String date,
    temp_max,
    temp_min,
    pressure,
    humidity;
  
  double temp;

  WeatherDetails({
    this.date,
    this.humidity,
    this.pressure,
    this.temp,
    this.temp_max,
    this.temp_min,
  });
}