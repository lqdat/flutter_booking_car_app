// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter_application/res/DTO/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  static Future<List<PlaceStep>> getStep(LatLng from, LatLng to) async {
    String accesKey =
        "pk.eyJ1IjoiZW5kZXJnOTciLCJhIjoiY2t5YjZuOHF4MDV2azJ6bGRvbHQzM2pkdSJ9.VKxaO_3m3l7bcKjKymUZQg";
    String url = "https://api.mapbox.com/directions/v5/mapbox/driving/"
        "${from.longitude},${from.latitude}; ${to.longitude},${to.latitude}"
        "?alternatives=true&geometries=geojson&language=vi&overview=simplified&steps=true&access_token=$accesKey";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return PlaceStep.fromJson(json.decode(res.body));
    } else {
      return [];
    }
  }
}
