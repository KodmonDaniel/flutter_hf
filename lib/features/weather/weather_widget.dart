import 'package:flutter/gestures.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/features/weather/weather_details/weather_details_bloc.dart';
import 'package:flutter_hf/features/weather/weather_details/weather_details_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../extensions/extension_route.dart';
import '../../extensions/extension_textstyle.dart';
import '../dashboard_page.dart';
import 'weather_state.dart';
import 'weather_bloc.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hf/repository/api/models/city_response.dart' as city_model;

class Weather extends DashboardPage {
  const Weather ({Key? key});
  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  double panelOpenedHeight = 0;
  double panelClosedHeight = 95.5;

  @override
  Widget build(BuildContext context) {
    panelOpenedHeight = MediaQuery.of(context).size.height * 0.6;
    
    return BlocProvider.value(
      value: Provider.of<WeatherBloc>(context),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                ///STACK ELEMENT
                SlidingUpPanel(
                  maxHeight: panelOpenedHeight,
                  minHeight: panelClosedHeight,
                  parallaxEnabled: true,
                  parallaxOffset: .5,
                  body: _map(state),
                  panelBuilder: (scrollController) => /*_list(state, scrollController)*/_panel(state,context, scrollController),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)
                  ),
                ),

                ///------------
                Positioned(
                  top: 0,
                  child: Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background/banner.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),


                ///------------INFO PANEL TODO dashboardra!!!!!!!!!!!!!


              ],
            )
          );
        }
      )
    );
  }

  /// Returns the map with the city weather markers
  _map(WeatherState state){
    return FlutterMap(
          options: MapOptions(
            center: LatLng(47.1, 19.5),
          //  zoom: Platform.isAndroid ? 6.4 : 10,
            zoom: 7.2,
          ),
          children: [
        TileLayer(
         /* urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',*/
          urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png",
          //userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            for (var i = 0; i < (state.citiesWeatherList?.length ?? 0); i++)
            Marker(
              point: LatLng(state.citiesWeatherList?[i].coord?.lat ?? 0, state.citiesWeatherList?[i].coord?.lon ?? 0),
              width: 50,
              height: 70,
              builder: (context) => _cityMarker(state, i)
            ),
          ],
        )
      ],
    );
  }

  /// Returns one city weather marker for a given city
  _cityMarker(WeatherState state, int i) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Container(
        color: AppColors.cardLight,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: IconButton(icon: Image.asset("assets/images/icons/${state.citiesWeatherList?[i].weather?[0].icon ?? "unknown_icon"}.png", fit: BoxFit.fitHeight), onPressed: () {  },)),
            // FlutterLogo(), //todo weather icon
            Expanded(child: Text("${((state.citiesWeatherList?[i].main?.temp ?? 0) - (state.isCelsius ? 272.15 : 457.87) ).round()}°",/* style: TextStyle(fontWeight: FontWeight.w500)*/style: AppTextStyle.mapTemp))
          ],
        ),
      ),
    );
  }

  /// Returns the list of the cities
 /* _list(WeatherState state, ScrollController scrollController){
    return  MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
       // controller: scrollController,
        children: [
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary,
                  borderRadius: const BorderRadius.all(Radius.circular(12)
                  )
                ),
              ),
              SizedBox(height: 20),
              //TODO LIST

             // Container(color: Colors.red, child: Text("WASD!!!!!"),),
           /*   Skeleton(
                  isLoading: state.isLoading,
                  skeleton: Container(color: Colors.red, child: Text("WASD!!!! todo skeli"),),
                  child: _actualList(state, context))
*/
              state.isLoading ? Container(color: Colors.red, child: Text("WASD!!!! todo skeli")) : _actualList(state, context, scrollController),


            ],
          ),
        ],
      ),




      );

  }*/

  _actualList(WeatherState state, BuildContext context, ScrollController scrollController) {
    return Padding(
        padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Expanded(
              child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (BuildContext context, int index) {
                      var length = state.citiesWeatherList?.length ?? 0;
                      if (length == 0) {
                        return  Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.list_no_element, style: AppTextStyle.planeText),
                        ));
                      }
                      //return _row(state, context, state.citiesWeatherList![index]);
                      return Container(color: Colors.red, child: Text("WASD!!!! todo skeli\n\n\n"));

                    },
                    itemCount: () {
                      var length = state.citiesWeatherList?.length ?? 0;
                      if (length == 0) {
                        length = 1;
                      }
                      return length;
                    }(),
                    dragStartBehavior: DragStartBehavior.start,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  ),
              )
          ),


    );
  }

  Future<void> refresh() async {//todo
    //widget._bloc.add
  }

  _row(WeatherState state, BuildContext context, city_model.CityResponse cityResponse) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Card(
        elevation: 3,
        color: AppColors.textWhite,
        child: InkWell(
          onTap: () {
             var weatherDetailsBloc = WeatherDetailsBloc(cityResponse: cityResponse, isCelsius: state.isCelsius);
             var weatherDetails = WeatherDetails(weatherDetailsBloc);
             var route = AppRoute.createRoute(weatherDetails);
             Navigator.of(context).push(route);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _listRowMain(state, context, cityResponse),
                  _listRowDetails(state, context, cityResponse)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _listRowMain(WeatherState state, BuildContext context, city_model.CityResponse cityResponse) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/icons/${cityResponse.weather?[0].icon ?? "unknown_icon"}.png", fit: BoxFit.fitWidth, width: 35),
            const SizedBox(width: 15),
            Text("${double.parse(((cityResponse.main?.temp ?? 0) - (state.isCelsius ? 272.15 : 457.87) ).toStringAsFixed(1))}°", style: AppTextStyle.mapTemp)
          ],
        ),
      ),
    );
  }

  _listRowDetails(WeatherState state, BuildContext context, city_model.CityResponse cityResponse) {
    return Expanded(
        child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(cityResponse.name ?? "", style: AppTextStyle.cityText),
                Text(cityResponse.weather?[0].main ?? "", style: AppTextStyle.descText),
              ],
            )

        )
    );
  }


  //ROUND/*
 /* Expanded(child: Text(double.parse(((state.citiesWeatherList?[i].main?.temp ?? 0) - (state.isCelsius ? 272.15 : 457.87) ).toStringAsFixed(1)).toString() +
  "°",/* style: TextStyle(fontWeight: FontWeight.w500)*/style: AppTextStyle.mapTemp))
*/






  Widget _panel(WeatherState state, BuildContext context, ScrollController scrollController) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: AppColors.textSecondary,
                      borderRadius: const BorderRadius.all(Radius.circular(12))),
                ),
              ],
            ),

          const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.cardLight,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12))),
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      dragStartBehavior: DragStartBehavior.start,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 16),
                      itemBuilder: (BuildContext context, int index) {
                        var length = state.citiesWeatherList?.length ?? 0;
                        if (length == 0) {
                          return  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),  //todo
                              child: Center(
                                child: Text(AppLocalizations.of(context)!.list_no_element, style: AppTextStyle.planeText),
                              ));
                        }
                        return _row(state, context, state.citiesWeatherList![index]);
                        },
                      itemCount: () {
                        var length = state.citiesWeatherList?.length ?? 0;
                        if (length == 0) {
                          length = 1;
                        }
                        return length;
                      }(),
                    ),
                  ),
                ),
              )
            ),
          ],
        )
    );
  }

  _skeletonList() {

  }


}





