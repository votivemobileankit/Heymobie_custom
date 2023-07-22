import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/ridehistory/bloc/ride_history_bloc.dart';
import 'package:grambunny_customer/theme/ft_theme_styles.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../components/a_header_back_button.dart';
import '../../components/a_vertical_space.dart';
import '../../side_navigation/bloc/side_navigat_bloc.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../../utils/image_paths.dart';
import '../model/ride_history_model.dart';
import '../ridehistory_navigator.dart';
import 'item/ride_history_rowitem.dart';

class RideHistoryPage extends StatefulWidget {
  const RideHistoryPage({Key? key}) : super(key: key);

  @override
  _RideHistoryPageState createState() => _RideHistoryPageState();
}

class _RideHistoryPageState extends State<RideHistoryPage> {
  List<RideHistoryListData> rideHistoryList = [];
  late ScrollController _scrollController;
  int pageCount = 1;
  bool isLoading = false;
  late final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  void initState() {
    showHideProgress(true);
    BlocProvider.of<RideHistoryBloc>(context)
        .add(RideHistorybtnEvent('${pageCount}'));
    _scrollController = ScrollController()..addListener(_scrollListener);

    setDarkStatusBarOverlay();
    super.initState();
    print("data=====>");
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      startLoader();
    }
  }

  void startLoader() {
    setState(() {
      isLoading = !isLoading;
      showHideProgress(true);
      pageCount = pageCount + 1;
      BlocProvider.of<RideHistoryBloc>(context)
          .add(RideHistorybtnEvent('${pageCount}'));
    });
  }

  Future<Null> _refresh() async {
    pageCount = 1;
    BlocProvider.of<RideHistoryBloc>(context)
        .add(RideHistorybtnEvent('${pageCount}'));

    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: BlocListener<RideHistoryBloc, RideHistoryState>(
          listenWhen: (prevState, curState) =>
              ModalRoute.of(context)!.isCurrent,
          listener: (context, state) {
            if (state is RideHistoryApiLoadingCompleteState) {
              showHideProgress(false);
              setState(() {
                if (state.refresh == 1) {
                  rideHistoryList.clear();
                  List<RideHistoryListData> rideHistoryListnew =
                      state.rideHistoryList;
                  rideHistoryList.addAll(rideHistoryListnew);
                  print("dataprint====> ${rideHistoryList[0].vendorId}");
                  print("id=====>${rideHistoryList[0].orderId}");
                } else {
                  List<RideHistoryListData> rideHistoryListnew =
                      state.rideHistoryList;
                  rideHistoryList.addAll(rideHistoryListnew);
                }
              });
            }
            if (state is RideHisyoryLoadingErrorState) {
              showHideProgress(false);
              BlocProvider.of<RideHistoryBloc>(context)
                  .add(RideHistoryStateReset());
              showSnackBar(state.message, context);
            }

            if (state is RideListDatailPageState) {
              Navigator.of(context)
                  .pushNamed(RideHistoryNavigator.rideListdetailPage);
            }
          },
          child: SafeArea(
              bottom: false,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                AHeaderWidget(
                  headerSigninText: "",
                  headerText: "",
                  btnEditOnPressed: () {},
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    print("back");
                  },
                  strBtnRightImageName: 'ic_search_logo.png',
                  rightEditButtonVisibility: false,
                ),
                AVerticalSpace(10.0.scale()),
                Text(
                  "Ride History",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ).align(Alignment.center),
                AVerticalSpace(30.0.scale()),
                // if (rideHistoryList != null && rideHistoryList.isEmpty)
                _RideHistoryListContainer(
                        rideHistoryList.toList(), _scrollController)
                    .expand()
                // else
                //   _NoProductFoundWidget().expand()
              ]))).pageBgColor(kColorScreenBgColor),
    );
  }
}

class _NoProductFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AVerticalSpace(120.0.scale()),
        Image(
          color: kColorAppBgColor,
          fit: BoxFit.fill,
          width: 150.0.scale(),
          height: 150.0.scale(),
          image: AssetImage('${imgPathGeneral}ic_order_empty.png'),
        ),
        AVerticalSpace(20.0.scale()),
        Text("Order is empty!",
                style: textStyleBoldCustomColor(20.0.scale(), kColorAppBgColor))
            .leftPadding(12.0.scale())
            .align(Alignment.center)
      ],
    ).expand();
  }
}

class _RideHistoryListContainer extends StatelessWidget {
  List<RideHistoryListData> rideHistoryList;
  ScrollController _scrollController;

  _RideHistoryListContainer(this.rideHistoryList, this._scrollController);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: rideHistoryList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return InkWell(
            onTap: () {},
            child: RideHistoryRowItem(rideHistoryList[index]),
          );
        });
  }
}
