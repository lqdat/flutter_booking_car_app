// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

class RiderWiget extends StatefulWidget {
  String selectedAddress;

  final Function(MapBoxPlace, bool) onSelect;
  String _placeFrom;
  String _placeTo;

  RiderWiget(
      this.selectedAddress, this.onSelect, this._placeFrom, this._placeTo);

  @override
  _RiderWiget createState() => _RiderWiget();
}

class _RiderWiget extends State<RiderWiget> {
  var placeFrom = "";
  var placeTo = "";

  void calbackDataFrom(MapBoxPlace placefrom) {
    widget.onSelect(placefrom, true);
    widget.selectedAddress = placefrom.placeName!;
  }

  void calbackDataTo(MapBoxPlace placeto) {
    widget.onSelect(placeto, false);
    widget.selectedAddress = placeto.placeName!;
  }

  void removeSelected() {
    setState(() {
      placeFrom = "";
      placeTo = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 5),
              blurRadius: 5.0,
            )
          ]),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapBoxAutoCompleteWidget(
                      apiKey:
                          "pk.eyJ1IjoiZW5kZXJnOTciLCJhIjoiY2t5YjZuOHF4MDV2azJ6bGRvbHQzM2pkdSJ9.VKxaO_3m3l7bcKjKymUZQg",
                      hint: "Chọn điểm đến",
                      country: "vn",
                      onSelect: (place) {
                        calbackDataFrom(place);
                        setState(() {
                          placeFrom = place.text!;
                        });
                      },
                      limit: 10,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(Icons.location_pin, color: Colors.green),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/images/ic_remove.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        getText(widget._placeFrom, "Chọn điểm đến", true),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapBoxAutoCompleteWidget(
                      apiKey:
                          "pk.eyJ1IjoiZW5kZXJnOTciLCJhIjoiY2t5YjZuOHF4MDV2azJ6bGRvbHQzM2pkdSJ9.VKxaO_3m3l7bcKjKymUZQg",
                      hint: "Chọn điểm đi",
                      onSelect: (place) {
                        calbackDataTo(place);
                        setState(() {
                          placeTo = place.text!;
                        });
                      },
                      limit: 10,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(Icons.location_pin, color: Colors.red),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/images/ic_remove.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        getText(widget._placeTo, "Chọn điểm đi", false),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getText(String placeName, String hint, bool fr_add) {
    String rs;
    if (placeName != "") {
      print(placeName);
      rs = fr_add ? "Đến: " + placeName : "Đi: " + placeName;
    } else {
      rs = hint;
    }
    return rs;
  }
}
