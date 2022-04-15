import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      // BlocProvider.of<HmRootBloc>(context).add(HmSplashEventloading());
      BlocProvider.of<HmRootBloc>(context)
          .add(HmRootEventLoginLoadingComplete());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        //bottom: false,
        child: Stack(
      children: [
        // Image(
        //   image: AssetImage('${imgPathGeneral}splash.png'),
        //   fit: BoxFit.cover,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('${imgPathGeneral}ic_app_name_logo.png'),
                  fit: BoxFit.fill,
                  width: 289.0.scale(),
                  height: 289.0.scale(),
                )
              ],
            )
                .leftPadding(15.0.scale())
                .rightPadding(15.0.scale())
                .bottomPadding(30.0.scale())
          ],
        ).align(Alignment.center),
      ],
    )).pageBgColor(Colors.white).lightStatusBarText();
  }
}
