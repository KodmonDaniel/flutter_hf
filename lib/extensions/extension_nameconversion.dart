import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppNameConversion on String {

  /// Api returns city names without accent.
  static String cityName(int id) {
    switch (id) {
      case 722437:
        return "Békéscsaba";
      case 3054643:
        return "Budapest";
      case 721472:
        return "Debrecen";
      case 721239:
        return "Eger";
      case 3052009:
        return "Győr";
      case 3050616:
        return "Kaposvár";
      case 3050434:
        return "Kecskemét";
      case 717582:
        return "Miskolc";
      case 716935:
        return "Nyíregyháza";
      case 3046526:
        return "Pécs";
      case 3045643:
        return "Salgótarján";
      case 715429:
        return "Szeged";
      case 3044760:
        return "Szekszárd";
      case 3044774:
        return "Székesfehérvár";
      case 715126:
        return "Szolnok";
      case 3044310:
        return "Szombathely";
      case 3044082:
        return "Tatabánya";
      case 3042929:
        return "Veszprém";
      case 3042638:
        return "Zalaegerszeg";
      default:
        return "N/A";
    }
  }

  /// Localise weather type names.
  static String weatherName(int id, BuildContext context) {
    if (id >= 200 && id < 300) {
      return AppLocalizations.of(context)!.weather_thunderstorm;
    } else  if (id >= 300 && id < 400) {
      return AppLocalizations.of(context)!.weather_drizzle;
    } else  if (id >= 500 && id < 600) {
      return AppLocalizations.of(context)!.weather_rain;
    } else  if (id >= 600 && id < 700) {
      return AppLocalizations.of(context)!.weather_snow;
    } else  if (id >= 700 && id < 800) {
      return AppLocalizations.of(context)!.weather_fog;
    } else  if (id == 800) {
      return AppLocalizations.of(context)!.weather_clear;
    }  else  if (id > 800 && id < 810) {
      return AppLocalizations.of(context)!.weather_cloudy;
    } else {
      return "N/A";
    }
  }
}
