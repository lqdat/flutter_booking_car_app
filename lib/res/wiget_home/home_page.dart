// ignore_for_file: unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/service/placeservice.dart';
import 'package:flutter_application/res/wiget_home/wigets/car_wiget.dart';
import 'package:flutter_application/res/wiget_home/wigets/menu_wiget.dart';
import 'package:flutter_application/res/wiget_home/wigets/ride_wiget.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  late User user;
  HomePage(this.user);
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Future<Position> _dataPosition;
  String selectedAddress = "";
  late MapBoxPlace _mapboxPlace;
  late bool _isFromAddress;
  late GoogleMapController _mapController;
  double _tripDistance = 0.0;
  List<LatLng> latlng = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> setMarket = {};
  Set<Polyline> setPolyline = {};
  @override
  void initState() {
    super.initState();
    _dataPosition = _getGeoLocationPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder<Position>(
          future: _dataPosition,
          builder: (context, snapshot) {
            return snapshot.hasData
                // ignore: avoid_unnecessary_containers
                ? Container(
                    constraints: BoxConstraints.expand(),
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                            polylines: setPolyline,
                            zoomControlsEnabled: false,
                            markers: setMarket,
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController controller) {
                              _mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                                target: LatLng(snapshot.data?.latitude ?? 0,
                                    snapshot.data?.longitude ?? 0),
                                zoom: 14.698)),
                        Positioned(
                          left: 0,
                          top: 10,
                          right: 0,
                          child: Column(
                            children: <Widget>[
                              AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0.0,
                                title: Center(
                                    child: Text(
                                  "ITrans",
                                  style: TextStyle(color: Colors.black),
                                )),
                                leading: ElevatedButton(
                                    onPressed: () {
                                      _scaffoldKey.currentState?.openDrawer();
                                    },
                                    child: Image.asset(
                                        'assets/images/ic_menu.png'),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent),
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent))),
                                actions: <Widget>[
                                  Image.asset('assets/images/ic_bell.png')
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                child: RiderWiget(
                                    selectedAddress,
                                    (data, isFrAdrress) =>
                                        receiceData(data, isFrAdrress)),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          height: 240,
                          child: CarWiget(_tripDistance),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      drawer: Drawer(child: MenuWiget(widget.user)),
    );
  }

  void receiceData(MapBoxPlace data, _isFrAddress) {
    _mapboxPlace = data;
    _isFromAddress = _isFrAddress;
    onPlaceSelected(_mapboxPlace, _isFromAddress);
  }

  void onPlaceSelected(MapBoxPlace place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    _checkDrawPolyline();
    _moveCamera();
  }

  void _addMarker(String mkId, MapBoxPlace place) async {
    // remove old
    setMarket.removeWhere((e) => e.markerId == MarkerId(mkId));
    var address =
        "${place.context![1].text!}, " "${place.context![2].text!}, " +
            place.context![3].text!;
    Marker resultMarker = Marker(
      icon: mkId == "from_address"
          ? BitmapDescriptor.defaultMarkerWithHue(120)
          : BitmapDescriptor.defaultMarkerWithHue(0),
      markerId: MarkerId(mkId),
      infoWindow: InfoWindow(title: "${place.text}", snippet: address),
      position: LatLng(place.center![1], place.center![0]),
    );
    setState(() {
      setMarket.add(resultMarker);
    });
  }

  void _moveCamera() {
    if (setMarket.length > 1) {
      var fromLatLng = setMarket
          .where((e) => e.markerId == MarkerId("from_address"))
          .first
          .position;
      var toLatLng = setMarket
          .where((e) => e.markerId == MarkerId("to_address"))
          .first
          .position;
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(
                  fromLatLng.latitude <= toLatLng.latitude
                      ? fromLatLng.latitude
                      : toLatLng.latitude,
                  fromLatLng.longitude <= toLatLng.longitude
                      ? fromLatLng.longitude
                      : toLatLng.longitude),
              northeast: LatLng(
                  fromLatLng.latitude <= toLatLng.latitude
                      ? toLatLng.latitude
                      : fromLatLng.latitude,
                  fromLatLng.longitude <= toLatLng.longitude
                      ? toLatLng.longitude
                      : fromLatLng.longitude)),
          100));
    } else {
      _mapController.animateCamera(
          CameraUpdate.newLatLng(setMarket.elementAt(0).position));
    }
  }

  void _checkDrawPolyline() async {
//  remove old polyline
    setPolyline.removeWhere((x) => x.polylineId == PolylineId("polyline"));

    if (setMarket.length > 1) {
      var fromLatLng = setMarket
          .where((e) => e.markerId == MarkerId("from_address"))
          .first
          .position;
      var toLatLng = setMarket
          .where((e) => e.markerId == MarkerId("to_address"))
          .first
          .position;
      List<LatLng> pointLatlng = [];
      await PlaceService.getStep(fromLatLng, toLatLng).then((vl) {
        for (var item in vl) {
          for (var i in item.steps) {
            LatLng latlngPoint = new LatLng(i[1], i[0]);
            pointLatlng.add(latlngPoint);
          }
          setState(() {
            _tripDistance = item.distance;
          });
        }
        Polyline line = Polyline(
          polylineId: PolylineId("polyline"),
          visible: true,
          //latlng is List<LatLng>
          width: 3,
          color: Colors.blue,
          points: pointLatlng,
        );

        setState(() {
          setPolyline.add(line);
        });
      });
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> getPositonCur() async {
    Position position = await _getGeoLocationPosition();
    return position;
  }
}
