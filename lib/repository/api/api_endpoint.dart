
/// Can be used in the future for different additional APIs, supporting different methods
class ApiEndpoint {
  final String url;
  final HttpMethod method;
  final String? apiKey;

  ApiEndpoint({required this.url, required this.method, this.apiKey});

  static ApiEndpoint getCitiesWeather = ApiEndpoint(url: "http://api.openweathermap.org/data/2.5/group", method: HttpMethod.get, apiKey: "522e009a484c7953360917c5a4ec1428");  // OpenWeather API requires key
}

enum HttpMethod {
  get,
  put,
  post
}