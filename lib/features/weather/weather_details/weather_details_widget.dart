import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_nameconversion.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/features/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_details_state.dart';
import 'weather_details_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      create: (_) => widget._bloc,
        child: BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: AppColors.textWhite
                  ),
                  title:  Text("${AppNameConversion.cityName(state.cityResponse?.id ?? 0)} ${AppLocalizations.of(context)!.weather_details}", style: AppTextStyle.tabTitle,),
                 backgroundColor: AppColors.backgroundDark,
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
                      SingleChildScrollView(
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 0),
                                  child: Card(
                                    color: AppColors.cardDark,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)
                                    ),
                                    child: Padding(
                                     // width: 500,
                                     // height: 450,
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: _cityDetails(state),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  )
              );
            }
        )
    );
  }


  _cityDetails(WeatherDetailsState state) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _mainRow(state),
          const SizedBox(height: 30),
          _detailsList(state)
        ],
      ),
    );
  }

  _mainRow(WeatherDetailsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(state.isCelsius
                ? "${((state.cityResponse?.main?.temp ?? 0) - 273.15).toStringAsFixed(1)}°"
                : "${(((state.cityResponse?.main?.temp ?? 0) - 273.15) * 1.8 + 32).toStringAsFixed(1)}°",
              style: AppTextStyle.mainText.copyWith(fontSize: 40, color: AppColors.textPrimary),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 0, right: 10),
            child: Image.asset("assets/images/icons/${state.cityResponse?.weather?[0].icon ?? "unknown_icon"}.png", width: 75)),
      ],
    );
  }

  _detailsList(WeatherDetailsState state) { // not dynamic, list not necessary
    String weatherName = AppNameConversion.weatherName(state.cityResponse?.weather?[0].id ?? 0, context);
    return Column(
      children: [
        _weatherCategory(weatherName),
        _detailElementRow(AppLocalizations.of(context)!.weather_details_min_tmp,
          state.isCelsius
            ? "${((state.cityResponse?.main?.temp_min ?? 0) - 273.15).toStringAsFixed(1)}°"
            : "${(((state.cityResponse?.main?.temp_min ?? 0) - 273.15) * 1.8 + 32).toStringAsFixed(1)}°"),
        _detailElementRow(AppLocalizations.of(context)!.weather_details_max_tmp, state.isCelsius
            ? "${((state.cityResponse?.main?.temp_max ?? 0) - 273.15).toStringAsFixed(1)}°"
            : "${(((state.cityResponse?.main?.temp_max ?? 0) - 273.15) * 1.8 + 32).toStringAsFixed(1)}°"),
        _detailElementRow(AppLocalizations.of(context)!.weather_details_pressure, "${state.cityResponse?.main?.pressure?.toStringAsFixed(0) ?? "N/A"} hPa"),
        _detailElementRow(AppLocalizations.of(context)!.weather_details_humidity, "${state.cityResponse?.main?.humidity?.toStringAsFixed(0) ?? "N/A"} %"),
        _simpleDivider(),
        _detailElementRow(AppLocalizations.of(context)!.weather_details_wind_speed, "${state.cityResponse?.wind?.speed?.toStringAsFixed(0) ?? "N/A"} m/s"),
        _detailElementRow(AppLocalizations.of(context)!.weather_details_clouds, "${state.cityResponse?.clouds?.all?.toStringAsFixed(0) ?? "N/A"} %"),
      ],
    );
  }

  _weatherCategory(String string) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
          color: AppColors.textPrimary.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Text("$string ${AppLocalizations.of(context)!.weather_details_weather}", style: AppTextStyle.mainText,),
          )
      ),
    );
  }

  _detailElementRow(String type, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type, style: AppTextStyle.weatherDetailsTypes),
          Text(value, style: AppTextStyle.weatherDetailsValue),
        ],
      ),
    );
  }

  _simpleDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Divider(
        color: AppColors.lightGrey,
      ),
    );
  }
}
