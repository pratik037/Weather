class WeatherData{
  final String description;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;
  final int temperature;
  final int minTemp;
  final int maxTemp;
  final int humidity;
  final String icon;

  WeatherData(
      {
        this.icon,
        this.description,
        this.windSpeed,
        this.sunriseTime,
        this.sunsetTime,
        this.temperature,
        this.minTemp,
        this.maxTemp,
        this.humidity,
      }
    );

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
    description : json['weather'][0]['description'],
    windSpeed : json['wind']['speed'] * 3.6,
    temperature: json['main']['temp'],
    minTemp: json['main']['temp_min'],
    maxTemp: json['main']['temp_max'],
    sunriseTime : json['sys']['sunrise'],
    sunsetTime : json['sys']['sunset'],
    humidity: json['main']['humidity'],
    icon: json['weather']['icon'],
    );
  }
}