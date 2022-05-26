import 'dart:async';

import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

class PlaceCheck {
  final _placeController = StreamController();

  Stream get placeStream => _placeController.stream;

  void searchPlace(MapBoxPlace place) {
    if (place != null) {
      _placeController.sink.add(place);
    }
  }
}
