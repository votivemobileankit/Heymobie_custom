

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/privacy_policy/privacy_policy.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';

import 'package:webview_flutter/webview_flutter.dart';



class PrivacyPolicyPage extends StatefulWidget {
  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
 late String _redirectedToUrl;
 late WebViewController _webViewContoller1;
  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {

    _redirectedToUrl = UrlPrivacyPolicy;

    super.initState();

    showHideProgress(true);
    _webViewContoller1 = WebViewController();
    _webViewContoller1.setJavaScriptMode(JavaScriptMode.unrestricted);

    _webViewContoller1.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          showHideProgress(true);
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          showHideProgress(false);
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    _webViewContoller1.loadRequest(Uri.parse(_redirectedToUrl));
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
              headerText: "",
              headerSigninText: "",
              strBtnRightImageName: "",
              btnEditOnPressed: () {

              },
              strBackbuttonName: 'ic_red_btn_back.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                BlocProvider.of<PrivacyPolicyBloc>(context)
                    .add(PrivacyPolicyBackBtnClick());
              },
              rightEditButtonVisibility: false,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height),
              child: WebViewWidget(controller: _webViewContoller1),
            ).expand()
          ],
        ).widgetBgColor(Colors.white),
      ).lightStatusBarText().pageBgColor(kColorAppBgColor),
    );
  }
}
