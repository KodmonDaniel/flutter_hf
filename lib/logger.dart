import 'package:flutter/foundation.dart';

class Logger {

  static log(String tag, String string) {
    if(kDebugMode) {
      print("$tag-$string");
    }
  }
}