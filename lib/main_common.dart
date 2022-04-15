// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../../components/components.dart';
import 'general/splash_screen.dart';
import 'login/login.dart';
import 'services/services.dart';
import 'side_navigation/side_navigation_navigator.dart';
import 'theme/ft_theme_data.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
const double _kFlavourButtonHeight = 30.0;

void initializeCommon() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values)
      .then((_) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      sharedPrefs.init().then((_) {
        UserRepository userRepository = UserRepository();
        HmRootBloc rootBloc = HmRootBloc(
          userRepository: userRepository,
        );
        Firebase.initializeApp().then((_) {
          flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
          var initializationSettingsAndroid =
              AndroidInitializationSettings('@mipmap/ic_launcher');
          const IOSInitializationSettings initializationSettingsIOS =
              IOSInitializationSettings(
                  requestSoundPermission: true,
                  requestBadgePermission: false,
                  requestAlertPermission: true,
                  onDidReceiveLocalNotification: onDidReceiveLocalNotification);

          var initializationSettings = InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
          flutterLocalNotificationsPlugin.initialize(initializationSettings,
              onSelectNotification: onSelectNotification);

          FirebaseMessaging.instance.getInitialMessage().then((event) {
            if (event != null) {
              Map<String, dynamic> notificationDetailsMap = event.data;
              print('on messge Initial id${notificationDetailsMap["id"]}');
              print('on messge Initial  tag ${notificationDetailsMap["tag"]}');
              print('on messge vId ${notificationDetailsMap["vid"]}');
              // userRepository.currentDeeplink = "notification";
              // userRepository.targetId = targetId;
              // userRepository.type = notificationDetailsMap["type"];
              // userRepository.external_link =
              //     notificationDetailsMap["external_link"];
              // if (userRepository.loginCheck()) {
              //   rootBloc.add(VDRootEventPushReceived());
              // }
            }
          });
          FirebaseMessaging.onMessage.listen((event) {
            //   St        print(event.notification.body);
            Map<String, dynamic> notificationDetailsMap = event.data;
            print('on messge Id ${notificationDetailsMap["id"]}');
            print('on messge tag ${notificationDetailsMap["tag"]}');
            print('on messge vId ${notificationDetailsMap["vid"]}');
            print(event.notification.title);
            showNotification(
                event.notification.title, event.notification.title);
          });

          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            print(event.notification.body);
            Map<String, dynamic> notificationDetailsMap = event.data;
            print('on messge Opened id${notificationDetailsMap["id"]}');
            print('on messge Opened tag${notificationDetailsMap["tag"]}');
            print('on messge vId ${notificationDetailsMap["vid"]}');
            // userRepository.currentDeeplink = "Notification";
            if (sharedPrefs.isLogin == true) {
              userRepository.notifyDriverId = notificationDetailsMap["vid"];
              userRepository.notifyOrderId = notificationDetailsMap["id"];

              rootBloc.add(HmRootEventPushReceived());
            }
          });
          FirebaseMessaging.onMessage.listen((RemoteMessage event) {
            Map<String, dynamic> notificationDetailsMap = event.data;
            print('on messge Opened id${notificationDetailsMap["id"]}');
            print('on messge Opened tag${notificationDetailsMap["tag"]}');
            print('on messge vId ${notificationDetailsMap["vid"]}');
          });

          userRepository.getToken();
          runApp(
            BlocProvider.value(
              value: rootBloc,
              child: App(
                userRepository: userRepository,
                rootBloc: rootBloc,
              ),
            ),
          );
        });
      });
    });
  });
}

void showNotification(String title, String body) async {
  await _demoNotification(title, body);
}

Future<void> _demoNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_ID', 'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      playSound: true,
      icon: '@mipmap/ic_launcher',
      showProgress: true,
      priority: Priority.high,
      ticker: 'test ticker');

  var iOSChannelSpecifics = IOSNotificationDetails(
    subtitle: title,
    presentSound: true,
    presentAlert: true,
    presentBadge: false,
  );

  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: 'test');
}

Future onSelectNotification(String payload) async {
  if (payload != null) {
    print('notification payload: $payload');
  }
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  // display a dialog with the notification details, tap ok to go to another page
}

bool initialTimeValue = false;

class App extends StatefulWidget {
  final UserRepository userRepository;

  final HmRootBloc rootBloc;

  const App({Key key, @required this.userRepository, @required this.rootBloc})
      : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  FlavorBanner(

    return MaterialApp(
      theme: DRThemeData().themeData,
      localizationsDelegates: const [
        Stringss.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Stringss.delegate.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        Locale applicableLocale = (deviceLocale?.languageCode == 'en'
            ? Stringss.delegate.supportedLocales[0]
            : Stringss.delegate.supportedLocales[1]);
        String selectedLangCode = applicableLocale.languageCode;
        widget.userRepository.currentLanguageCode = selectedLangCode;
        return applicableLocale;
      },
      home: HomeWidget(
        userRepository: widget.userRepository,
        rootBloc: widget.rootBloc,
      ).lightStatusBarText(),
      navigatorKey: navigatorKey,
      navigatorObservers: [],
      debugShowCheckedModeBanner: false,
    );
    // );
  }
}

class HomeWidget extends StatefulWidget {
  final UserRepository userRepository;
  final HmRootBloc rootBloc;

  const HomeWidget(
      {Key key, @required this.userRepository, @required this.rootBloc})
      : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    //_FileLogger.read();
    // TODO: implement initState
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("in MainCommon WillPopup ${widget.userRepository.ScreenName}");
        if (widget.userRepository.ScreenName ==
            ScreenNavigation.OrderHistoryPageScreen) {
          widget.rootBloc.add(HmRootEventBackButtonOrderHistory());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.OrderHistoryDetailPageScreen) {
          widget.rootBloc.add(HmRootEventBackButtonOrderHistory());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.ProfileMainPageScreen) {
          widget.rootBloc.add(HmRootEventBackButtonProfile());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.HomeMenuItemDetailScreen) {
          widget.rootBloc.add(HmRootEventBackButtonHome());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.HomeCategoryListScreen) {
          widget.rootBloc.add(HmRootEventBackButtonHome());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.HomeProductListScreen) {
          widget.rootBloc.add(HmRootEventBackButtonHome());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.HomeMyCartScreen) {
          widget.rootBloc.add(HmRootEventBackButtonHome());
          return Future<bool>.value(false);
        } else if (widget.userRepository.ScreenName ==
            ScreenNavigation.HomeMainPageScreen) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(true);
        }
      },
      child: BlocBuilder<HmRootBloc, HmRootState>(builder: (context, state) {
        return GestureDetector(
          onDoubleTap: () {
            print("This doubletab");
            widget.rootBloc.add(HmRootEventBackButtonOrderHistory());
            // widget.rootBloc.add(HmSplashEventloading());
            // widget.rootBloc.add(HmRootEventSettingScreenSelectFromRoot());
          },
          child: Stack(
            children: [
              getWidgetBlocRootState(),
              Visibility(
                visible: false,
                child: TextButton(
                  onPressed: () async {
                    //writeFile codebelow
                    // if (printToFile) {
                    //   //stopFileLogging  ("Main.class","ankitvotive@gmail.com");
                    //   showOneButtonDialog(
                    //     context: context,
                    //     titleText: Strings.current.titleTxtAlert,
                    //     descText: Strings.current.txtMsgdelete,
                    //     btnTitleText: Strings.current.btnOk,
                    //     btnOnPressed: () {},
                    //   );
                    // }
                  },
                  child: Container(
                    width: _kFlavourButtonHeight.scale(),
                    height: _kFlavourButtonHeight.scale(),
                  ),
                ),
              ).align(Alignment.bottomRight),
            ],
          ),
        );
      }),
    ).lightStatusBarText();
  }

  Widget getWidgetBlocRootState() {
    Widget widgetForState;
    HmRootState rootBlocState = BlocProvider.of<HmRootBloc>(context).state;
    print(rootBlocState.toString());
    switch (rootBlocState.runtimeType) {
      case HmRootInitial:
        widgetForState = SplashScreen();

        break;
      case HmRootSplashLoadingComplete:
        widgetForState = LoginNavigator(userRepository: widget.userRepository);
        break;
      case HmRootHomeState:
        // print("from common in homePage");
        widgetForState = SideNavigationNavigator(
          userRepository: widget.userRepository,
        );
        break;
    }
    return widgetForState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setDeviceMetrics(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).devicePixelRatio);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //aPrint(  UserRepository().ClinicFindScreen());
    //  aPrint("state = $state");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    PaintingBinding.instance.imageCache.clear();
    super.dispose();
  }
}
