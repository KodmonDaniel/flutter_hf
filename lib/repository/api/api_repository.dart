import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hf/repository/api/models/city_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;
import 'api_endpoint.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  ApiRepository();

  /// City weather stream
  final citiesResponseController = StreamController<List<CityResponse>?>.broadcast();
  Stream<List<CityResponse>?> get cityResponse => citiesResponseController.stream;

  /// Dispose
  void dispose(){
    citiesResponseController.close();
  }

  /// Header for base request
  /// Additional access token can be added as a parameter here if necessary in future
  Future<Map<String, String>> _headers(ApiEndpoint endpoint) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String appName = packageInfo.appName;
    String version = packageInfo.version;
    var model = "unknown";
    var os = "unknown";

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      model = "${androidDeviceInfo.manufacturer} ${androidDeviceInfo.model}";
      os = (androidDeviceInfo.version.codename);
    }
    if(kIsWeb){
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      model = (webBrowserInfo.userAgent ?? "unknown agent");
      os = (webBrowserInfo.appVersion ?? "unknown version");
    }

    return {
      //Authorization: accessToken  // for future use if needed OpenWeatherAPI doesn't need it
      "platform": Platform.operatingSystem,
      "app": "$appName $version",
      "model": model,
      "os": os,
      if (endpoint.method == HttpMethod.put) "Content-Type": "application/json"  // for future use, not yet needed
    };
  }

  /// Base request
  Future<dynamic> baseRequest<T>(ApiEndpoint endpoint, Map<String, dynamic> params, Function(Map<String, dynamic>) parser) async {
    late http.Response response;
    var headers = await _headers(endpoint);

    if(endpoint.method == HttpMethod.get){
      http.Response resp = await http.get(Uri.parse("${endpoint.url}?${makeQuery(params)}"), headers: headers);
      response = resp;
    }

    // POST, PUT here for future use, not yet needed

    if(response.statusCode == 401){
      return baseRequest<T>(endpoint, params, parser);  // retry
    }

    var jsonString = json.decode(response.body);
    dynamic completer;
    dynamic parsed;

    if(jsonString['list'] is List){    // List response
      completer = Completer<List<T>>();
      var tmpList = <T>[];
      for (var i = 0; i < jsonString['cnt']; i++){
        tmpList.add(parser(jsonString['list'][i]));
      }
      parsed = tmpList;
    } else {  // single object response, later use
      completer = Completer<T>();
      parsed = parser(jsonString);
    }
    completer.complete(parsed);
    return completer.future;
  }

  /// Makes query from map
  String makeQuery(Map<String, dynamic>? params) {
    var result = [];
    if (params != null) {
      params.forEach((key, value) {
        if (value != null && (value is! String || value.trim().isNotEmpty)) {
          result.add("$key=${value.toString()}");
        }
      });
    }
    return result.join("&");
  }

  /// Get the weather of the cities
  Future<List<CityResponse>?> getWeather(String idList) async {
    var completer = Completer<List<CityResponse>?>();
    try {
     var cityWeathers = await baseRequest<CityResponse>(ApiEndpoint.getCitiesWeather, {
        "id" : idList,
        "appid" : ApiEndpoint.getCitiesWeather.apiKey
      }, CityResponse.fromJson);
      citiesResponseController.sink.add(cityWeathers);
      completer.complete(cityWeathers);
      return completer.future;
    } catch (error) {
      completer.complete(null);
      return completer.future;
    }
  }
}

