import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dashboard_page.dart';
import 'weather_state.dart';
import 'weather_bloc.dart';
import 'cities.dart';
import 'dart:io' show Platform;

class Weather extends DashboardPage {
  const Weather ({Key? key});
  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Provider.of<WeatherBloc>(context),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 140,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background/banner.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                 // SizedBox(height: 140,), //banner
                  _map(state),
                  SizedBox(height: 270,) //list
                ],
              ),
            ),
          );
        }
      )
    );
  }

  _map(WeatherState state){
    var length = state.citiesWeatherList?.length ?? 0;
    return Expanded(
        child: FlutterMap(
      options: MapOptions(
        center: LatLng(47.1, 19.5),
        zoom: Platform.isAndroid ? 6.4 : 10,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            for (var i = 0; i < 2; i++)
            Marker(
              point: LatLng(state.citiesWeatherList?[i].coord?.lat ?? 0, state.citiesWeatherList?[i].coord?.lon ?? 0),
              width: 40,
              height: 40,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(), //todo weather icon
                  Expanded(child: Text(state.citiesWeatherList?[i].weather?[0].main ?? "123", /*style: AppTextStyle.mapTemp*/))
                ],
              ),
            ),
          ],
        )
      ],
    )
    );
  }

  _list(){

  }


//todo state adatok első kettő (egész lista mehetne a stateba)
  List<CityMarker> cities = [
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Békéscsaba", LatLng(46.68211, 21.10013), "722437"),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "50℃", "Budapest", LatLng(47.497913, 19.040236), "3054643"),
    /* CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Debrecen", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Eger", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Győr", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Kaposvár", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Kecskemét", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Miskolc", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Nyíregyháza", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Pécs", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Salgótarján", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Szeged", this.location),
    CityMarker(AssetImage("assets/images/icons/unknown_icon.png"), "?", "Szekszárd", this.location),*/
  ];

}





