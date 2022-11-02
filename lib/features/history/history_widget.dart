import 'package:flutter/gestures.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
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
import 'history_state.dart';
import 'history_bloc.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hf/repository/api/models/city_response.dart' as city_model;

class History extends DashboardPage {
  const History ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  double panelOpenedHeight = 0;
  double panelClosedHeight = 95.5;

  @override
  Widget build(BuildContext context) {
    panelOpenedHeight = MediaQuery.of(context).size.height * 0.6;

    return BlocProvider.value(
    value: Provider.of<HistoryBloc>(context),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                ///STACK ELEMENT
                Padding(
                  padding: const EdgeInsets.only( top: 145),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background/rain_bg.png"),
                            fit: BoxFit.cover
                        )
                    ),
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
              ],
            )
          );
        }
      )
    );
  }







}





