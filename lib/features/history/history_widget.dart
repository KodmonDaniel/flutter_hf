import 'package:flutter/foundation.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_nameconversion.dart';
import 'package:flutter_hf/preferences/common_objects.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class History extends DashboardPage {
  const History ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _title(state),
                    state.isLoading ? _skeletonList(screenWidth) : _list(state, screenWidth)
                  ],
                )
            ),
          );
        }
      )
    );
  }

  _title(HistoryState state) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.history_sort),
                const SizedBox(width: 5),
                ToggleSwitch(
                  minWidth: 50,
                  cornerRadius: 20,
                  activeBgColors: [[AppColors.tealColor1], [AppColors.tealColor1]],
                  activeFgColor: AppColors.backgroundDark,
                  inactiveBgColor: AppColors.lightGrey,
                  inactiveFgColor: AppColors.backgroundDark,
                  fontSize: 16,
                  initialLabelIndex: state.sortByTime ? 0 : 1,
                  totalSwitches: 2,
                  icons: const [Icons.calendar_month, Icons.pin_drop],
                  radiusStyle: true,
                  onToggle: (index) {
                    Provider.of<HistoryBloc>(context, listen: false).add(HistoryChangeSortCategoryEvent());
                    },
                ),
              ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.history_order),
                const SizedBox(width: 5),
                ToggleSwitch(
                  minWidth: 50,
                  cornerRadius: 20,
                  activeBgColors: [[AppColors.tealColor1], [AppColors.tealColor1]],
                  activeFgColor: AppColors.backgroundDark,
                  inactiveBgColor: AppColors.lightGrey,
                  inactiveFgColor: AppColors.backgroundDark,
                  fontSize: 16,
                  initialLabelIndex: state.sortASC ? 0 : 1,
                  totalSwitches: 2,
                  icons: const [Icons.arrow_upward_outlined, Icons.arrow_downward_outlined],
                  radiusStyle: true,
                  onToggle: (index) {
                    state.isLoading ? null : (Provider.of<HistoryBloc>(context, listen: false).add(HistoryChangeOrderCategoryEvent()));
                    },
                ),
              ],
            ),
            IconButton(onPressed: () => scrollTop(), icon: const Icon(Icons.keyboard_double_arrow_up))
          ],
        ),
      ),
    );
  }

  _list(HistoryState state, double screenWidth) {
    var length = state.storedWeathers?.length;
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: (state.storedWeathers == null || length == 0)
        ? _emptyList()
        : Padding(
          padding: (kIsWeb) ? EdgeInsets.fromLTRB((screenWidth/3.5), 0, (screenWidth/3.5), 0)  : const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: GroupedListView<dynamic, String>(
              elements: state.storedWeathers!,
              groupBy: (element) => state.sortByTime ? (element.time.toString().substring(0, 10)) : AppNameConversion.cityName(element.id), /*element.city.toString(),*/
              order: state.sortASC ? GroupedListOrder.ASC : GroupedListOrder.DESC,
              useStickyGroupSeparators: false,
              shrinkWrap: true,
              controller: _scrollController,
              groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  state.sortByTime ? (item1.time.toString().substring(0, 10).compareTo(item2.time.toString().substring(0, 10)))
                    : (item1.city.toString().compareTo(item2.city.toString())),
              groupSeparatorBuilder: (String value) => _separator(value),
              itemBuilder: (c, element) => _row(element, state)
          ),
        ),
      ),
    );
  }

  _emptyList() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Container(
            color: AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/background/no_element.png", scale: 3,),
                const SizedBox(height: 25),
                Text(AppLocalizations.of(context)!.list_no_element, style: AppTextStyle.secondaryLightText,)
              ],
            ),
          ),
        )
      ],
    );
  }

    scrollTop() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      }
    }

  Future<void> refresh() async {
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
          child: Text(value, textAlign: TextAlign.center, style: AppTextStyle.separator)
      ),
    );
  }

  _row(StoredWeather element, HistoryState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 3,
        color: AppColors.white,
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
            Text(Provider.of<CommonObjects>(context, listen: false).isCelsius!
                ? "${((element.temp ?? 0) - 273.15).toStringAsFixed(1)}°"
                : "${(((element.temp ?? 0) - 273.15) * 1.8 + 32).toStringAsFixed(1)}°",
              style: AppTextStyle.mapTemp,
            ),
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
                Text(AppNameConversion.cityName(element.id ?? 0), style: AppTextStyle.mainText),
                Text(DateFormat('yyyy-MMM-dd').format(element.time!).toString(), style: AppTextStyle.descText),
                Text(DateFormat('kk:mm').format(element.time!).toString(), style: AppTextStyle.descText.copyWith(fontSize: 16)),
              ],
            )
        )
    );
  }

  /// Skeleton loading
  _skeletonList(double screenWidth) {
    return Expanded(
      child: Padding(
        padding: (kIsWeb) ? EdgeInsets.fromLTRB((screenWidth/3.5), 0, (screenWidth/3.5), 0)  : const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 3,
        color: AppColors.white,
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





