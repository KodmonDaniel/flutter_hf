import 'package:flutter_hf/repository/firestore/models/user_details_response.dart';

/// Singleton class to provide user details and temp unit for all widgets
class CommonObjects {
  UserDetailsResponse? userDetails;
  late bool isCelsius;
  late bool firstLaunch;

  CommonObjects({this.userDetails});
}