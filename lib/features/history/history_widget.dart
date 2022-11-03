import 'package:flutter/gestures.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';
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
import '../../repository/firestore/firestore_repository.dart';
import '../dashboard_page.dart';
import 'history_state.dart';
import 'history_bloc.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            /*body: StreamBuilder<List<StoredWeather>>(
              stream:
            );*/










                ///STACK ELEMENT
               body: Column(
                 children: [
               Text("wwwww"),
          Text(state.storedWeathers?[0].temp.toString() ?? ""),
          Text(state.storedWeathers?[0].city.toString() ?? ""),
                   Text("waaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
                   Text(state.storedWeathers?[0].city.toString() ?? ""),
                   Text(state.storedWeathers?[1].city.toString() ?? ""),
                   Text(state.storedWeathers?[2].city.toString() ?? ""),
            Text("wasd"),
                 ],
               )

                ///------------
                /*Positioned(
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
                ),*/


          );
        }
      )
    );
  }

  _actualList(HistoryState state, BuildContext context/*, ScrollController scrollController*/) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.cardLight,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12))),
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                //controller: scrollController,
                dragStartBehavior: DragStartBehavior.start,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 16),
                itemBuilder: (BuildContext context, int index) {
                  var length = state.storedWeathers?.length ?? 0;
                  if (length == 0) {
                    return  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),  //todo
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.list_no_element, style: AppTextStyle.planeText),
                        ));
                  }
                  return Text(state.storedWeathers?[1].temp.toString() ?? "");
                },
                itemCount: () {
                  var length = state.storedWeathers?.length ?? 0;
                  if (length == 0) {
                    length = 1;
                  }
                  return length;
                }(),
              ),
            ),
          ),
        )
    );
  }

  Future<void> refresh() async {//todo
    //widget._bloc.add
  }





}





