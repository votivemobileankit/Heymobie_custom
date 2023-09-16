import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/privacy_policy/privacy_policy.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController? webViewContoller1;

class PrivacyPolicyPage extends StatefulWidget {
  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String? _redirectedToUrl;

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    showHideProgress(true);
    _redirectedToUrl = UrlPrivacyPolicy;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<PrivacyPolicyBloc, PrivacyPolicyState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is PrivacyPolicyBackToHomeState) {
          BlocProvider.of<PrivacyPolicyBloc>(context)
              .add(PrivacyPolicyResetEventInitialState());
          BlocProvider.of<SideNavigatBloc>(context)
              .add(SideNavigationEventGoToHomePageFromHistory());
        }
      },
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AHeaderWidget(
              strBackbuttonName: 'ic_slide_menu_icon.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                if (_timer != null) {
                  _timer?.cancel();
                }
                Scaffold.of(context).openDrawer();
                // BlocProvider.of<PrivacyPolicyBloc>(context)
                //     .add(PrivacyPolicyBackBtnClick());
              },
              rightEditButtonVisibility: false,
              strBtnRightImageName: '',
              btnEditOnPressed: () {},
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height),
              child: WebView(
                initialUrl: _redirectedToUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  webViewContoller1 = webViewController;
                },
                javascriptChannels: <JavascriptChannel>{},
                navigationDelegate: (NavigationRequest request) {
                  //_redirectedToUrl = request.url;
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');

                    return NavigationDecision.prevent;
                  }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  // showHideProgress(false);
                },
                onPageFinished: (String url) {
                  print("on page finished" + url);
                  // readJS();
                  showHideProgress(false);
                },
                gestureNavigationEnabled: true,
              ),
            ).expand()
          ],
        ).widgetBgColor(Colors.white),
      ).lightStatusBarText().pageBgColor(kColorAppBgColor),
    );
  }
}

const double _kTextBirthdateField = 128.0;
String strCity = "";
Timer? _timer;
bool isTimerOn = false;
String strProduct = "";
