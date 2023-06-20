import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/aboutus/bloc/bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

late WebViewController webViewContoller1;

class AboutUsPage extends StatefulWidget {
  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late String _redirectedToUrl;

  bool _isLoading = false;

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    showHideProgress(true);
    _redirectedToUrl = UrlAboutUs;
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<AboutBloc, AboutState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is AboutBackToHomeState) {
          BlocProvider.of<AboutBloc>(context)
              .add(AboutResetEventInitialState());
          BlocProvider.of<SideNavigatBloc>(context)
              .add(SideNavigationEventGoToHomePageFromHistory());
        }
      },
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AHeaderWidget(
              headerSigninText: "",
              headerText: "",
              strBtnRightImageName: "",
              strBackbuttonName: 'ic_red_btn_back.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                BlocProvider.of<AboutBloc>(context)
                    .add(AboutEventBackBtnClick());
              },
              rightEditButtonVisibility: false,
              btnEditOnPressed: () {},
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height),
              child: WebView(
                initialUrl: _redirectedToUrl,
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
