import 'package:bloc/bloc.dart';
import 'package:flutter_hf/logger.dart';

/// Observer for all events for debug
class Observer extends BlocObserver {

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger.log("Observer", "${bloc.runtimeType}: $change");
  }
}