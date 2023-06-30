import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:http/http.dart' as http;

import '../../components/a_vertical_space.dart';
import '../../services/herbarium_cust_shared_preferences.dart';
import '../../theme/ft_theme_styles.dart';
import '../../utils/image_paths.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class RidelocationSearchPage extends StatefulWidget {
  const RidelocationSearchPage({Key? key}) : super(key: key);

  @override
  _RidelocationSearchPageState createState() => _RidelocationSearchPageState();
}

class _RidelocationSearchPageState extends State<RidelocationSearchPage> {
  var _controller = TextEditingController();
  late String _sessionToken;

  List<dynamic> _placeList = [];
  String? type;

  @override
  void initState() {
    super.initState();

    HomeState state = BlocProvider.of<HomeBloc>(context).state;

    if (state is HomeRideLocationSeatchPageState) {
      type = state.type;
    }
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    // if (_sessionToken == null) {
    //   setState(() {
    //     _sessionToken = Uuid.generateV4();
    //   });
    // }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    // String kPLACES_API_KEY = "AIzaSyB6jpjQRZn8vu59ElER36Q2LaxptdAghaA";
    String kPLACES_API_KEY = "AIzaSyDbpMqvtCo2HIYWzRdbySryYiZoCfBHrT0";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY';
    var response = await http.get(Uri.parse(request));
    //  print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<void> searchLatLong(String location) async {
    try {
      List<Location> address =
          await locationFromAddress(location).then((value) {
        var first = value.first;
        sharedPrefs.keyLatitude = first.latitude;
        sharedPrefs.keyLongitude = first.longitude;
        if (type == "Pickup") {
          sharedPrefs.searchLocation = location;
        } else {
          sharedPrefs.searchDropLocation = location;
        }

        print(location);
        BlocProvider.of<HomeBloc>(context).add(HomeEventRideBackBtnClicked());
        return value;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          if (state is HomeEventDriverRideListClickPageState) {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            AVerticalSpace(5.0.scale()),
            InkWell(
              onTap: () {
                BlocProvider.of<HomeBloc>(context)
                    .add(HomeEventRideBackBtnClicked());
              },
              child: Image(
                fit: BoxFit.fill,
                width: 35.0.scale(),
                height: 35.0.scale(),
                image: AssetImage('${imgPathGeneral}ic_black_cross.png'),
              ),
            ).align(Alignment.centerLeft).leftPadding(10.0.scale()),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Seek your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
            for (int i = 0; i < _placeList.length; i++)
              GestureDetector(
                onTap: () {
                  print(" tap tap");
                  searchLatLong(_placeList[i]["description"]);
                },
                child: Column(
                  children: [
                    Text(
                      _placeList[i]["description"],
                      style: textStyleCustomColor(12.0.scale(), Colors.black),
                    ).align(Alignment.centerLeft)
                  ],
                ).topPadding(8.0.scale()).bottomPadding(8.0.scale()),
              )
          ],
        )).pageBgColor(Colors.white);
  }
}
