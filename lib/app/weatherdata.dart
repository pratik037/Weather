class WeatherData {
  final String name;
  final String description;
  final double windSpeed;
  final int sunriseTime;
  final int sunsetTime;
  final num temperature;
  final int humidity;
  final String iconLabel;
  final double windDirection;

  WeatherData(
      {this.name,
      this.description,
      this.windSpeed,
      this.sunriseTime,
      this.sunsetTime,
      this.temperature,
      this.humidity,
      this.iconLabel,
      this.windDirection});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      windSpeed: json['wind']['speed'] * 3.6 ?? 0.0,
      temperature: json['main']['temp'] ?? 0,
      sunriseTime: json['sys']['sunrise'] ?? 0,
      sunsetTime: json['sys']['sunset'] ?? 0,
      humidity: json['main']['humidity'] ?? 0,
      iconLabel: json['weather'][0]['icon'] ?? '',
      windDirection: json['wind']['deg'].toDouble() ?? 0.0,
    );
  }
}
