import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/setting/model/notification_list_model.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../setting.dart';

class NotificationListPage extends StatefulWidget {
  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
 late List<Data> notificationList;
 late ScrollController _scrollController;
  int pageCount = 1;
  bool isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    notificationList = [];
    showHideProgress(true);
    BlocProvider.of<SettingBloc>(context)
        .add(SettingNotificationListApiCall('$pageCount', '0'));
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
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
      BlocProvider.of<SettingBloc>(context)
          .add(SettingNotificationListApiCall('$pageCount', '0'));
    });
  }

  Future<Null> _refresh() async {
    pageCount = 1;
    BlocProvider.of<SettingBloc>(context)
        .add(SettingNotificationListApiCall('$pageCount', '1'));
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: BlocListener<SettingBloc, SettingState>(
          listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
          listener: (context, state) {
            if (state is SettingNotificationDataListState) {
              showHideProgress(false);
              setState(() {
                if (state.isRefresh == "1") {
                  notificationList.clear();
                  List<Data> notificationListnew =
                      state.notificationDataList.data;
                  notificationList.addAll(notificationListnew);
                } else {
                  List<Data> notificationListnew =
                      state.notificationDataList.data;
                  notificationList.addAll(notificationListnew);
                }
              });
            } else if (state is SettingNotificationDetailPageState) {
              showHideProgress(false);
              Navigator.of(context)
                  .pushNamed(SettingNavigator.notificationDetailPage);
            } else if (state is SettingUpdateUserSettingState) {
              Navigator.of(context).pop(true);
            } else if (state is SettingErrorState) {
              showHideProgress(false);
              showSnackBar(state.message, context);
              BlocProvider.of<SettingBloc>(context)
                  .add(SettingEventNotificationStateReset());
            } else if (state is SettingNotificationListPageState) {
              showHideProgress(false);
            }
          },
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                AHeaderWidget(
                  headerSigninText: "",
                  headerText: "",
                  btnEditOnPressed: () {

                  },
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    BlocProvider.of<SettingBloc>(context)
                        .add(SettingEventBackBtnClick());
                  },
                  strBtnRightImageName: 'ic_search_logo.png',
                  rightEditButtonVisibility: false,
                ),
                if (notificationList != null)
                  ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    physics: ClampingScrollPhysics(),
                    itemCount: notificationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child:
                            NotificationListContainer(notificationList[index]),
                        onTap: () {
                          print(notificationList[index].order_id);
                          print(notificationList[index].vendorId);
                          showHideProgress(true);
                          BlocProvider.of<SettingBloc>(context).add(
                              NotificationListItemClick(
                                  notificationList[index].order_id,
                                  notificationList[index].vendorId));
                        },
                      );
                    },
                  ).expand()
                else
                  _NoProductFoundWidget().expand()
              ],
            ).widgetBgColor(Colors.white),
          ),
        ));
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
          width: 120.0.scale(),
          height: 120.0.scale(),
          image: AssetImage('${imgPathGeneral}ic_empty_notifications.png'),
        ),
        AVerticalSpace(20.0.scale()),
        Text("No Notification Yet!",
                style: textStyleBoldCustomColor(20.0.scale(), kColorAppBgColor))
            .leftPadding(12.0.scale())
            .align(Alignment.center)
      ],
    ).expand();
  }
}

class NotificationListContainer extends StatelessWidget {
  Data notificationList;

  NotificationListContainer(this.notificationList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Image(
              width: 5.0.scale(),
              height: 5.0.scale(),
              color: KColorAppThemeColor,
              image: AssetImage('${imgPathGeneral}ic_dot_icon.png'),
            ),
            AHorizontalSpace(7.0.scale()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notificationList.orderid != null)
                  Text(
                    "Order id: #" + notificationList.orderid,
                    style: textStyleCustomColor(14.0.scale(), KColorCommonText),
                  ),
                Text(
                  notificationList.notiDesc,
                  style: textStyleCustomColor(14.0.scale(), KColorCommonText),
                ),
                Text(
                  notificationList.agoTime,
                  style: textStyleCustomColor(14.0.scale(), KColorTextGrey),
                )
              ],
            )
          ],
        )
            .topPadding(15.0.scale())
            .bottomPadding(15.0.scale())
            .leftPadding(5.0.scale())
            .rightPadding(5.0.scale()),
        ASeparatorLine(height: 1, color: Colors.black38)
      ],
    );
  }
}
