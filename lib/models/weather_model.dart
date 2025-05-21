class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final double pressure;
  final double humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      pressure: (json['main']['pressure'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }

  Weather copyWith({
    String? cityName,
    double? temperature,
    String? condition,
    String? description,
    double? pressure,
    double? humidity,
    double? windSpeed,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
      description: description ?? this.description,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
    );
  }
}
