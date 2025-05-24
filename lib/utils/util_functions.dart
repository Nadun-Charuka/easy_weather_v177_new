class UtilFunctions {
  static String getWeatherAnimation({required String conditon}) {
    switch (conditon.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloudy.json";

      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rain.json";

      case "thunderstorm":
        return "assets/thunder.json";

      case "clear":
        return "assets/sunny.json";

      default:
        return "assets/sunny.json";
    }
  }
}
