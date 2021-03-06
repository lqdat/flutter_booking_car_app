// ignore_for_file: unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/component/emty_wiget.dart';
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
            if (value.length > 0) {
              listHistory = value;
              isLoading = false;
            } else
              listHistory = [];
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
            'L???ch s??? ?????t xe',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: isLoading
                  ? LoaderTransparent(Colors.black)
                  : Container(
                      child: listHistory.length > 0
                          ? StreamBuilder(
                              stream: _historyStream.stream,
                              builder: (context, snapshot) {
                                return new ListView.builder(
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 200.0,
                                      child: Card(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30)),
                                        ),
                                        color: Colors.transparent,
                                        elevation: 5,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Column(children: <Widget>[
                                            Row(children: [
                                              Container(
                                                height: 90,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                ),
                                                child: new Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          new EdgeInsets.only(
                                                              left: 0.0),
                                                      child: new Container(
                                                        height: 200,
                                                        width: 300,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 0.0,
                                                            left: 72.0),
                                                        child: new Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            new Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child:
                                                                      new Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 2),
                                                                        child:
                                                                            new Row(
                                                                          children: [
                                                                            new Icon(Icons.location_on,
                                                                                size: 20.0,
                                                                                color: Colors.red),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 5),
                                                                              child: new Text(listHistory.elementAt(index).from_address.toString(), style: TextStyle(fontSize: 16)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -0.94,
                                                                            1),
                                                                        child: Dash(
                                                                            direction: Axis
                                                                                .vertical,
                                                                            length:
                                                                                19,
                                                                            dashLength:
                                                                                2,
                                                                            dashColor:
                                                                                Colors.white),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            bottom:
                                                                                10,
                                                                            top:
                                                                                2),
                                                                        child:
                                                                            new Row(
                                                                          children: [
                                                                            new Icon(Icons.location_on,
                                                                                size: 20.0,
                                                                                color: Colors.green),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 5),
                                                                              child: new Text(listHistory.elementAt(index).to_address.toString(), style: TextStyle(fontSize: 16)),
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
                                                          AlignmentDirectional
                                                              .topCenter,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          right: 50.0,
                                                          top: 16,
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Color(
                                                                0xfff7f7f7),
                                                          ),
                                                          width: 64,
                                                          height: 64,
                                                          child: Center(
                                                            child: getImageCar(
                                                                index),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomStart,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  new Row(
                                                    children: [
                                                      new Icon(Icons.date_range,
                                                          size: 20.0,
                                                          color: Colors.white),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: new Text(
                                                            DateFormat(
                                                                    'yyyy-MM-dd ??? kk:mm')
                                                                .format(DateTime
                                                                    .parse(listHistory
                                                                        .elementAt(
                                                                            index)
                                                                        .date
                                                                        .toString())),
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                      ),
                                                    ],
                                                  ),
                                                  new Row(
                                                    children: [
                                                      new Icon(
                                                          Icons.price_change,
                                                          size: 20.0,
                                                          color: Colors.white),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: new Text(
                                                            listHistory
                                                                    .elementAt(
                                                                        index)
                                                                    .price
                                                                    .toString() +
                                                                " VN??",
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, bottom: 8),
                                              child: Align(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
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
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              child: listHistory
                                                          .elementAt(index)
                                                          .status ==
                                                      false
                                                  ? Container(
                                                      width: 150.0,
                                                      height: 24.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Ch??a ????nh gi??',
                                                          style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            height: 1,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    )
                                                  : null,
                                            )
                                          ]),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  136, 6, 54, 113),
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
                              },
                            )
                          : Empty('Ch??a c?? l???ch s??? ?????t xe'),
                    ),
            ),
            Positioned(
              top: 0,
              right: 16,
              child: listHistory.length > 0
                  ? RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('C???nh B??o'),
                                content: const Text(
                                    'B???n c?? ch???c mu???n x??a l???ch s??? ?????t xe ?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('H???y'),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      deleteAll(),
                                      Navigator.pop(context, 'Ok')
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        text: "X??a l???ch s??? ?????t xe",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          height: 2.5,
                          letterSpacing: 0.7,
                        ),
                      ),
                    )
                  : SizedBox(),
            )
          ],
        ));
  }

  Future<void> deleteAll() async {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < listHistory.length; i++) {
      await HistoryService.deleteHistory(widget.user, listHistory[i].id);
    }

    getlistHistory();
  }

  Image? getImageCar(int index) {
    String id = listHistory.elementAt(index).carId.toString();
    switch (id) {
      case "1":
        return Image.asset("assets/images/ic_car_blue.png");
      case "2":
        return Image.asset("assets/images/ic_car_red.png");
      case "3":
        return Image.asset("assets/images/ic_car_green.png");
      case "4":
        return Image.asset("assets/images/ic_bus.png");
      default:
        return null;
    }
  }
}
