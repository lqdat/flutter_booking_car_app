// ignore_for_file: import_of_legacy_library_into_null_safe


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_client/signalr_client.dart';

class SignalR extends StatefulWidget {
  @override
  State<SignalR> createState() => _SignalRState();
}

class _SignalRState extends State<SignalR> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final serverUrl = "https://bookingapp.somee.com/chathub";
  late HubConnection hubConnection;
  LatLng currentPosition = new LatLng(0, 0);
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  @override
  void initState() {
    super.initState();
    initSignalR();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Báo'),
        automaticallyImplyLeading: false,
        
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(currentPosition.latitude.toString() +
                "," +
                currentPosition.longitude.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if(hubConnection.state==HubConnectionState.Connected){
                    await hubConnection.start();

                  }
                  await hubConnection.invoke("ReceiveNewPosition",args:<Object>[
                    currentPosition.latitude,
                    currentPosition.longitude
                  ]);

                  getPositonCur();
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose((error) => print("Connection Closed"));
    hubConnection.on("ReceiveNewPosition", _handlerNewPosition);
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
    setState(() {
      currentPosition = new LatLng(position.latitude, position.longitude);
    });
    print({currentPosition.latitude, currentPosition.longitude});
    return position;
  }

   _handlerNewPosition(List<Object> arguments) {

  }
  
}
