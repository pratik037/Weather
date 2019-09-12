class WeatherData{
  final String description;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;

  WeatherData(
      {
        this.description,
        this.windSpeed,
        this.sunriseTime,
        this.sunsetTime
      }
    );

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
    description : json['weather'][0]['main'],
    windSpeed : json['wind']['speed'],
    sunriseTime : json['sys']['sunrise'],
    sunsetTime : json['sys']['sunset']
    );
    
  }
}