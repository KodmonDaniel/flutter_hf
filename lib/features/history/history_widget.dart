import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../extensions/extension_textstyle.dart';
import '../dashboard_page.dart';
import 'history_event.dart';
import 'history_state.dart';
import 'history_bloc.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class History extends DashboardPage {
  const History ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
    value: Provider.of<HistoryBloc>(context),
      child: BlocBuilder<HistoryBloc, HistoryState>(  // stream builder can be used for firestore but real time updates are not necessary
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.backgroundDark,
              title: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    color: AppColors.backgroundDark,
                  ),
                  Text(
                    AppLocalizations.of(context)!.history,
                    style: AppTextStyle.tabTitle,
                  ),
                ],
              ),
            ),


            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.backgroundPrimary,
                        AppColors.backgroundSecondary,
                      ],
                    )
                ),

                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    _title(),

                    state.isLoading ? _skeletonList() : Expanded(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: GroupedListView<dynamic, String>(
                          elements: state.storedWeathers!,
                          groupBy: (element) => element.time.toString().substring(0, 10),
                          order: GroupedListOrder.ASC,
                          useStickyGroupSeparators: false,
                            shrinkWrap: true,//todo
                          groupComparator: (value1, value2) => value2.compareTo(value1),
                          itemComparator: (item1, item2) =>
                          item1.time.toString().substring(0, 10).compareTo(item2.time.toString().substring(0, 10)),

                          groupSeparatorBuilder: (String value) => _separator(value),

                          itemBuilder: (c, element) => _row(element, state)
              ),
                      ),
            ),
                    ),
                  ],
                )),
          );
        }
      )
    );
  }


  _title() {
    return Container(
       // width: MediaQuery.of(context).size.width,
       //height: 50,
      color: AppColors.textWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child:  Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Text(AppLocalizations.of(context)!.history_sort),

                    const SizedBox(width: 10),


                        ToggleSwitch(
                          minWidth: 50,
                          cornerRadius: 20,
                          activeBgColors: [[AppColors.textPrimary], [AppColors.textPrimary]],
                          activeFgColor: AppColors.backgroundDark,
                          inactiveBgColor: AppColors.lightGrey,
                          inactiveFgColor: AppColors.backgroundDark,
                          fontSize: 16,
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                         // labels: [AppLocalizations.of(context)!.sort_time, AppLocalizations.of(context)!.sort_city],
                          icons: const [Icons.pin_drop, Icons.calendar_month],
                          radiusStyle: true,
                          onToggle: (index) {
                            print('switched to: $index');
                            Provider.of<HistoryBloc>(context, listen: false).add(HistoryChangeSortCategoryEvent(index == 0 ? false : true));
                          },
                        ),


                    const SizedBox(width: 30),

                    Text(AppLocalizations.of(context)!.history_order),

                    const SizedBox(width: 10),

                    ToggleSwitch(
                      minWidth: 50,
                      cornerRadius: 20,
                      activeBgColors: [[AppColors.textPrimary], [AppColors.textPrimary]],
                      activeFgColor: AppColors.backgroundDark,
                      inactiveBgColor: AppColors.lightGrey,
                      inactiveFgColor: AppColors.backgroundDark,
                      fontSize: 16,
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                    // iconSize: 50,
                     // labels: [AppLocalizations.of(context)!.sort_asc, AppLocalizations.of(context)!.sort_desc],
                      icons: const [Icons.arrow_upward_outlined, Icons.arrow_downward_outlined],
                      radiusStyle: true,
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
              ),


      ),
    );
  }




  Future<void> refresh() async {//todo LISTEN FALSE!!!!!!!!!!!!!!!!!!!!!!
    Provider.of<HistoryBloc>(context, listen: false).add(HistoryRefreshEvent());
  }

  _separator(String value) {
    return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Container(
              decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(value, textAlign: TextAlign.center, style: AppTextStyle.separator,
              )
          ),
    );
  }

  _row(StoredWeather element, HistoryState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        elevation: 3,
        color: AppColors.textWhite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _listRowMain(element, state),
                  _listRowDetails(element)
                ],
              )
            ],
          ),
        ),
    );
  }

  _listRowMain(StoredWeather element, HistoryState state) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Image.asset("assets/images/icons/${element.icon ?? "unknown_icon"}.png", fit: BoxFit.fitWidth, width: 45),
            const SizedBox(width: 20),
            Text("${double.parse(((element.temp ?? 0) - (state.isCelsius ? 272.15 : 457.87) ).toStringAsFixed(1))}°", style: AppTextStyle.mapTemp)
          ],
        ),
      ),
    );
  }

  _listRowDetails(StoredWeather element) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(element.city ?? "", style: AppTextStyle.cityText),
                Text(DateFormat('yyyy-MMM-dd').format(element.time!).toString(), style: AppTextStyle.descText),
                Text(DateFormat('kk:mm').format(element.time!).toString(), style: AppTextStyle.descText.copyWith(fontSize: 16)),
              ],
            )
        )
    );
  }





  /// Skeleton loading
  _skeletonList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
           // padding: const EdgeInsets.fromLTRB(30, 20, 30, 16),
            itemCount: 20,
            itemBuilder: (context, index) {
              return _skeletonRow();
            },
          ),
        ),
    );
  }

  _skeletonRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        elevation: 3,
        color: AppColors.textWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _skeletonListRowMain(),
                _skeletonListRowDetails()
              ],
            )
          ],
        ),
      ),
    );
  }

  _skeletonListRowMain() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.circle, width: 50, height: 50),
            ),
            const SizedBox(width: 25),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 30,
                  width: 55,
                  alignment: Alignment.centerLeft,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ],
        ),
      ),
    );
  }

  _skeletonListRowDetails() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 15,
                  width: 100,
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(height: 10),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 15,
                  width: 100,
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(height: 10),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 15,
                  width: 100,
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ],
        ),
      ),
    );
  }





}





