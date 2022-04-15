import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

class MapOrderTrackPage extends StatefulWidget {
  @override
  State<MapOrderTrackPage> createState() => _MapOrderTrackPageState();
}

double _originLatitude;
double _originLongitude;
double _destLatitude;
double _destLongitude;
String _vendorID;
PolylinePoints polylinePoints;

// Markers to show points on the map
Map<MarkerId, Marker> markers = {};
Map<PolylineId, Polyline> polylines = {};

class _MapOrderTrackPageState extends State<MapOrderTrackPage> {
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex;
  Timer _timer;

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    OrderHistoryState orderState =
        BlocProvider.of<OrderHistoryBloc>(context).state;
    if (orderState is MapOrderTrackPageState) {
      _originLatitude = double.parse(orderState.userLat);
      _originLongitude = double.parse(orderState.userLong);
      _destLatitude = double.parse(orderState.driverLat);
      _destLongitude = double.parse(orderState.driverLong);

      _vendorID = orderState.vendorID;

      print("Latlong===>>" +
          _originLatitude.toString() +
          _originLongitude.toString() +
          _destLatitude.toString() +
          _destLongitude.toString());
    }

    // Configure map position and zoom
    _kGooglePlex = CameraPosition(
      target: LatLng(_originLatitude, _originLongitude),
      zoom: 13.0,
    );

    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );
    _getPolyline();

    _timer = Timer.periodic(Duration(seconds: 30), (_timer) {
      setState(() {
        showHideProgress(true);
        BlocProvider.of<OrderHistoryBloc>(context)
            .add(MapScreenEventForVendorUpdateLocation(_vendorID));
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context).isCurrent,
        listener: (context, state) {
          if (state is OrderHistoryDetailPageState) {
            Navigator.of(context).pop(true);
          }
          if (state is vendorUpdateLocationApiLoadingCompleteState) {
            showHideProgress(false);
            setState(() {
              print("LOcation update");
              var lat = double.parse(state.vendorLatLong[0].lat);
              var long = double.parse(state.vendorLatLong[0].lng);
              _addMarker(
                LatLng(lat, long),
                "driver",
                BitmapDescriptor.defaultMarker,
              );
            });
            BlocProvider.of<OrderHistoryBloc>(context).add(MapScreenResetEvent(
                _destLatitude.toString(),
                _destLongitude.toString(),
                _originLatitude.toString(),
                _originLongitude.toString(),
                _vendorID));
          }
          if (state is vendorUpdateLocationApiErrorState) {
            showHideProgress(false);
            showSnackBar(state.message, context);
            BlocProvider.of<OrderHistoryBloc>(context).add(MapScreenResetEvent(
                _destLatitude.toString(),
                _destLongitude.toString(),
                _originLatitude.toString(),
                _originLongitude.toString(),
                _vendorID));
          }
        },
        child: SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AHeaderWidget(
                strBackbuttonName: 'ic_red_btn_back.png',
                backBtnVisibility: true,
                btnBackOnPressed: () {
                  //Scaffold.of(context).openDrawer();
                  BlocProvider.of<OrderHistoryBloc>(context)
                      .add(OrderEventBackBtnClicked());
                },
                strBtnRightImageName: 'ic_search_logo.png',
                rightEditButtonVisibility: false,
              ),
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                polylines: Set<Polyline>.of(polylines.values),
                markers: Set<Marker>.of(markers.values),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ).expand(),
            ],
          ).widgetBgColor(Colors.white),
        ).widgetBgColor(kColorAppBgColor));
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);

    markers[markerId] = marker;
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCSs4Tdf-8AKp9dz9_4bfsc_H9XtHrSwpY",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    print("timer cancel");
    super.dispose();
  }
}
