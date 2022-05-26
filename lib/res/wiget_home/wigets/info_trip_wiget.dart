import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class InfoTrip extends StatefulWidget {
  @override
  State<InfoTrip> createState() => _InfoTripState();
}

class _InfoTripState extends State<InfoTrip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 300.0,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          color: Color.fromARGB(136, 6, 54, 113),
          // elevation: 5,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: <Widget>[
              Column(children: [
                Stack(children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56.0,
                    child: Center(
                        child: Text("My Title",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white))),
                  ),
                  Positioned(
                      left: 0.0,
                      top: 0.0,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }))
                ]),
              ]),
              Row(children: [
                SizedBox(
                  height: 120,
                  // margin: const EdgeInsets.symmetric(
                  //   vertical: 8.0,
                  // ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: EdgeInsets.only(left: 0.0),
                        child: Container(
                          height: 250,
                          width: 350,
                          margin: const EdgeInsets.only(top: 0.0, left: 120.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 2),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.location_on,
                                                  size: 24.0,
                                                  color: Colors.red),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text("aaa",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.92, 1),
                                          child: Dash(
                                              direction: Axis.vertical,
                                              length: 19,
                                              dashLength: 2,
                                              dashColor: Colors.white),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 2),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.location_on,
                                                  size: 24.0,
                                                  color: Colors.green),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text("bbb",
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xfff7f7f7),
                          ),
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Image.asset("assets/images/ic_bus.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range, size: 20.0, color: Colors.white),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                              DateFormat('yyyy-MM-dd – kk:mm').format(
                                  DateTime.parse(DateTime.now().toString())),
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.price_change,
                            size: 20.0, color: Colors.white),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(" VNĐ",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Xếp hạng & dánh giá :",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white))),
                        RatingBar.builder(
                          ignoreGestures: false,
                          initialRating: 1,
                          itemSize: 50,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    )),
              ),
              Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text("aaa",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white)))),
                  )),
            ]),
          )),
    );
  }
}
