import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/features/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_details_state.dart';
import 'weather_details_bloc.dart';
import 'dart:io' show Platform;

class WeatherDetails extends DashboardPage {
  const WeatherDetails (this._bloc, {Key? key}) : super(key: key);
  final WeatherDetailsBloc _bloc;

  @override
  State<StatefulWidget> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        //value: Provider.of<WeatherDetailsBloc>(context),
      create: (_) => widget._bloc,
        child: BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: AppColors.textPrimary
                  ),
                  title:  Text(state.cityResponse?.name ?? ""),
                 backgroundColor: AppColors.backgroundDark,
                 /* actions: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],*/
                ),
                  body: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: state.background,
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 60, top: 32, right: 60, bottom: 32),
                                child: Card(
                                  color: AppColors.cardLight,
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)
                                  ),
                                  child: SizedBox(
                                    width: 300,
                                    height: 450,
                                    child: _cityDetails(state),
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  )
              );
            }
        )
    );
  }

  _cityDetails(WeatherDetailsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _mainCityDetails(state),
        Padding(
          padding: const EdgeInsets.only(top: 0, right: 10),
          child: Image.asset("assets/images/icons/${state.cityResponse?.weather?[0].icon ?? "unknown_icon"}.png", width: 75)),
      ],
    );
  }

  _mainCityDetails(WeatherDetailsState state) {
    return Row(
      children: [
        Column(
          children: [

            Text("${double.parse(((state.cityResponse?.main?.temp ?? 0) - (state.isCelsius ? 272.15 : 457.87) ).toStringAsFixed(1))}°", style: AppTextStyle.mapTemp.copyWith(color: AppColors.textWhite)),
           const SizedBox(height: 10),
            Text(state.cityResponse?.name ?? "?", style: AppTextStyle.cityText.copyWith(color: AppColors.textWhite)),
          ],
        )
      ],

    );
  }


}
