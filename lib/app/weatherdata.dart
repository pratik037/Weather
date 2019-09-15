class WeatherData{
  final String description;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;
  final num temperature;
  final int humidity;
  final String iconLabel;

  WeatherData(
      {
        this.description,
        this.windSpeed,
        this.sunriseTime,
        this.sunsetTime,
        this.temperature,
        this.humidity,
        this.iconLabel,
      }
    );

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
    description : json['weather'][0]['description'] ?? '',
    windSpeed : json['wind']['speed'] ?? 0.0,
    temperature: json['main']['temp'] ?? 0,
    sunriseTime : json['sys']['sunrise'] ?? 0,
    sunsetTime : json['sys']['sunset'] ?? 0,
    humidity: json['main']['humidity'] ?? 0,
    iconLabel: json['weather'][0]['icon'] ?? '',
    );
  }
}