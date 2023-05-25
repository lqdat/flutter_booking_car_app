// ignore_for_file: unnecessary_new

import 'dart:async';


class NotificationStream {
  StreamController _selectedController = new StreamController.broadcast();

  get stream => _selectedController.stream;

  void dispose() {
    _selectedController.close();
  }
}
