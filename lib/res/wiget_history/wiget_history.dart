// ignore_for_file: unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/component/loading_wiget.dart';
import 'package:flutter_application/res/service/historyservice.dart';
import 'package:flutter_application/res/stream/history_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:tiengviet/tiengviet.dart';

class HistoryPage extends StatefulWidget {
  User user;
  HistoryPage(this.user);
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _historyStream = new HistoryStream();
  bool isLoading = false;
  List<History> listHistory = [];
  void getlistHistory() async {
    setState(() {
      isLoading = true;
    });
    await HistoryService.getHistory(widget.user).then((value) => setState(() {
          value.sort((a, b) {
            DateTime aDate = DateTime.parse(a.date);
            DateTime bDate = DateTime.parse(b.date);
            return bDate.compareTo(aDate);
          });
          setState(() {
            listHistory = value;
            isLoading = false;
          });
        }));
  }

  @override
  void initState() {
    super.initState();

    getlistHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          iconTheme:
              IconThemeData(color: Color.fromARGB(136, 6, 54, 113), size: 40),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Lịch sử đặt xe',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: isLoading
            ? LoaderTransparent(Colors.black)
            : StreamBuilder(
                stream: _historyStream.stream,
                builder: (context, snapshot) {
                  return new ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 200.0,
                        child: Card(
                          shape: new RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(30)),
                          ),
                          color: Colors.transparent,
                          elevation: 5,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Column(children: <Widget>[
                              Row(children: [
                                Container(
                                  height: 90,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: new Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: new EdgeInsets.only(left: 0.0),
                                        child: new Container(
                                          height: 200,
                                          width: 300,
                                          margin: const EdgeInsets.only(
                                              top: 0.0, left: 72.0),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    child: new Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2),
                                                          child: new Row(
                                                            children: [
                                                              new Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  size: 20.0,
                                                                  color: Colors
                                                                      .red),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child: new Text(
                                                                    listHistory
                                                                        .elementAt(
                                                                            index)
                                                                        .from_address
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.94, 1),
                                                          child: Dash(
                                                              direction:
                                                                  Axis.vertical,
                                                              length: 19,
                                                              dashLength: 2,
                                                              dashColor:
                                                                  Colors.white),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  top: 2),
                                                          child: new Row(
                                                            children: [
                                                              new Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  size: 20.0,
                                                                  color: Colors
                                                                      .green),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child: new Text(
                                                                    listHistory
                                                                        .elementAt(
                                                                            index)
                                                                        .to_address
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16)),
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
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 50.0,
                                            top: 16,
                                          ),
                                          child: new Image(
                                            image: new AssetImage(
                                                "assets/images/ic_bus.png"),
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    new Row(
                                      children: [
                                        new Icon(Icons.date_range,
                                            size: 20.0, color: Colors.white),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: new Text(
                                              DateFormat('yyyy-MM-dd – kk:mm')
                                                  .format(DateTime.parse(
                                                      listHistory
                                                          .elementAt(index)
                                                          .date
                                                          .toString())),
                                              style: TextStyle(fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                      children: [
                                        new Icon(Icons.price_change,
                                            size: 20.0, color: Colors.white),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: new Text(
                                              listHistory
                                                      .elementAt(index)
                                                      .price
                                                      .toString() +
                                                  " VNĐ",
                                              style: TextStyle(fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: listHistory
                                        .elementAt(index)
                                        .rating
                                        .toDouble(),
                                    itemSize: 25,
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
                                ),
                              ),
                            ]),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(136, 6, 54, 113),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                  ),
                                ),
                                shadowColor: Colors.transparent),
                          ),
                        ),
                      );
                    },
                    itemCount: listHistory.length,
                    scrollDirection: Axis.vertical,
                  );
                }));
  }
}
