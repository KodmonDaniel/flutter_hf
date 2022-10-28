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
      model = "${androidDeviceInfo.manufacturer ?? "unknown manufacturer"} ${androidDeviceInfo.model ?? "unknown model"}";
      os = (androidDeviceInfo.version.codename ?? "unknown sdk");
    }
    if(kIsWeb){
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      model = (webBrowserInfo.userAgent ?? "unknown agent");
      os = (webBrowserInfo.appVersion ?? "unknown version");
    }

    return {
      //Authorization: accessToken  //for future use if needed
      "platform": Platform.operatingSystem,
      "app": "$appName $version",
      "model": model,
      "os": os,
      if (endpoint.method == HttpMethod.put) "Content-Type": "application/json"  //for future use, not yet needed
    };
  }

  /// Base request
  Future<dynamic> baseRequest<T>(ApiEndpoint endpoint, Map<String, dynamic> params, Function(Map<String, dynamic>) parser) async {
    late http.Response response;
    var headers = await _headers(endpoint);

    if(endpoint.method == HttpMethod.get){
      http.Response resp = await http.get(Uri.parse(endpoint.url + "?" + makeQuery(params)), headers: headers);
      response = resp;
    }

    // POST, PUT here for future use, not yet needed

    if(response.statusCode == 401){
      return baseRequest<T>(endpoint, params, parser);
    }

    var jsonString = json.decode(response.body);
   // print(jsonString['list'][0]['name']);
   // print(jsonString['cnt']-1);
    dynamic completer;
    dynamic parsed;

    print(jsonString['cnt']);
    if(/*jsonString['list'] is List*/ true){    //List response
      completer = Completer<List<T>>();
      var tmpList = <T>[];
      for (var i = 0; i < 2; i++){

        print("itten:::::::::::::::::::::::"+ i.toString());
      /*  print(jsonString['list'][i]['weather'][i]['main']);
        print(jsonString['list'][i]['coord']['lat']);
        print("----------->"+ jsonString['list'][i]['name']);*/

        tmpList.add(parser(jsonString['list'][i]));

        print("55555555555555555555--------------");
      }
      parsed = tmpList;
    } else {  // single object response
      completer = Completer<T>();
      parsed = parser(jsonString);
    }
    print("005--------------");
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
    //print("object");
    //var wasd = json.decode(dummydata);
   // print(wasd['list'][0]['coord']['lon']);

    var completer = Completer<List<CityResponse>?>();
   // dynamic completer;
   // completer = Completer<List<CityResponse>>();
    try {
     var cityWeathers = await baseRequest<CityResponse>(ApiEndpoint.getCitiesWeather, {
        "id" : idList,
        "appid" : ApiEndpoint.getCitiesWeather.apiKey
      }, CityResponse.fromJson);


      //!!!!!!!!!!!!!!
  /*   var cityWeathers = dummydata;



                  var tmpList = <CityResponse>[];
                  for (var i = 0; i < /*jsonString['list'].length*/1; i++){


                    //print(cityWeathers['list'][i]['weather'][i]['main']);

                    tmpList.add(CityResponse.fromJson(cityWeathers[2][i]));

                    print("55555555555555555555--------------");
                  }
*/








//stream??
      citiesResponseController.sink.add(cityWeathers);
      completer.complete(cityWeathers);
      return completer.future;
    } catch (error) {
      completer.complete(null);
      return completer.future;
    }
  }

  String dummydata = """
  {
	"cnt": 2,
	"list": [
		{
			"coord": {
				"lon": 21.1,
				"lat": 46.6833
			},
			"sys": {
				"country": "HU",
				"timezone": 7200,
				"sunrise": 1666760899,
				"sunset": 1666798236
			},
			"weather": [
				{
					"id": 802,
					"main": "Clouds",
					"description": "scattered clouds",
					"icon": "03d"
				}
			],
			"main": {
				"temp": 289.79,
				"feels_like": 289.42,
				"temp_min": 289.79,
				"temp_max": 289.79,
				"pressure": 1024,
				"humidity": 73
			},
			"visibility": 10000,
			"wind": {
				"speed": 1.79,
				"deg": 102
			},
			"clouds": {
				"all": 37
			},
			"dt": 1666782546,
			"id": 722437,
			"name": "Bekescsaba"
		},
		{
			"coord": {
				"lon": 19.0399,
				"lat": 47.498
			},
			"sys": {
				"country": "HU",
				"timezone": 7200,
				"sunrise": 1666761484,
				"sunset": 1666798640
			},
			"weather": [
				{
					"id": 803,
					"main": "Clouds",
					"description": "broken clouds",
					"icon": "04d"
				}
			],
			"main": {
				"temp": 290.4,
				"feels_like": 290.19,
				"temp_min": 287.44,
				"temp_max": 290.41,
				"pressure": 1022,
				"humidity": 77
			},
			"visibility": 6000,
			"wind": {
				"speed": 2.06,
				"deg": 170
			},
			"clouds": {
				"all": 75
			},
			"dt": 1666782557,
			"id": 3054643,
			"name": "Budapest"
		}
	]
}
  """;

}

