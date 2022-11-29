import 'package:flutter_hf/preferences/secure_storage.dart';
import 'package:flutter_hf/repository/firestore/models/user_details_response.dart';

/// Singleton class to provide user details and temp unit for all widgets
class CommonObjects {
  UserDetailsResponse? userDetails;
 /* late */bool? isCelsius;
  /*late*/ bool? firstLaunch;

  CommonObjects({this.userDetails});

  getStoredTempUnitInside() async {
    var value = await SecureStorage.instance.get("tempUnit");
    if (value == "false") {
      isCelsius = false;
    } else {
      isCelsius = true;
    }
  }

  isFirstLaunchInside() async {
    var value = await SecureStorage.instance.get("firstLaunch");
    if (value == null) {
      firstLaunch =  true;
    } else {
      firstLaunch =  false;
    }
  }
}