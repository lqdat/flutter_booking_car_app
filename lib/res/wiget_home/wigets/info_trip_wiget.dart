// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/component/loading_wiget.dart';
import 'package:flutter_application/res/component/orientation.dart';
import 'package:flutter_application/res/service/historyservice.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class InfoTrip extends StatefulWidget {
  String historyId;
  User user;

  InfoTrip(this.historyId, this.user);

  @override
  State<InfoTrip> createState() => _InfoTripState();
}

class _InfoTripState extends State<InfoTrip> {
  int rating = 1;
  String text = "";
  Base base = new Base();
  bool isLoading = false;
  History history = new History(
      car_name: '',
      carId: "",
      date: '',
      distance: 0,
      from_address: '',
      id: '',
      price: 0,
      rating: 0,
      text: '',
      to_address: '',
      userId: '',
      status: false);

  Future<void> getHistoryNew() async {
    await HistoryService.getHistorybyId(widget.user, widget.historyId)
        .then((value) => setState(() {
              history = value!;
            }));
  }

  @override
  void initState() {
    super.initState();
    getHistoryNew();
  }

  @override
  Widget build(BuildContext context) {
    return history.id == ''
        ? LoaderTransparent(Colors.black)
        : Container(
            padding: EdgeInsets.zero,
            height: 300.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              color: Colors.white,
              // elevation: 5,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Column(children: [
                      Stack(children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56.0,
                          child: Center(
                              child: Text("????nh gi?? chuy???n ??i",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black))),
                        ),
                        Positioned(
                            right: 0.0,
                            top: 0.0,
                            child: IconButton(
                                icon:
                                    Image.asset("assets/images/ic_remove.png"),
                                iconSize: 40,
                                color: Colors.black,
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
                                margin: const EdgeInsets.only(
                                    top: 0.0, left: 120.0),
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
                                                padding:
                                                    EdgeInsets.only(bottom: 2),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        size: 18.0,
                                                        color: Colors.green),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text(
                                                          "?????n: " +
                                                              history
                                                                  .from_address,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.94, 1),
                                                child: Dash(
                                                    direction: Axis.vertical,
                                                    length: 19,
                                                    dashLength: 2,
                                                    dashColor: Colors.black),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10, top: 2),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        size: 20.0,
                                                        color: Colors.red),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text(
                                                          "T???: " +
                                                              history
                                                                  .to_address,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black)),
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
                                  color: Colors.blueGrey,
                                ),
                                width: 80,
                                height: 80,
                                child: Center(
                                  child:
                                      Image.asset("assets/images/ic_bus.png"),
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
                              Icon(Icons.date_range,
                                  size: 20.0, color: Colors.black),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                    DateFormat('yyyy-MM-dd ??? kk:mm').format(
                                        DateTime.parse(
                                            history.date.toString())),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.price_change,
                                  size: 20.0, color: Colors.black),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(history.price.toString() + " VN??",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
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
                          child: OrientationSwitcher(children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Row(children: [
                                Icon(Icons.rate_review,
                                    size: 20.0, color: Colors.black),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(" X???p h???ng & ????nh gi??:",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: RatingBar.builder(
                                ignoreGestures: false,
                                initialRating: 1,
                                itemSize: 40,
                                minRating: 0,
                                direction: Axis.horizontal,
                                // allowHalfRating: true,
                                itemCount: 5,
                                // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (_rating) {
                                  setState(
                                    () {
                                      rating = _rating.toInt();
                                    },
                                  );
                                },
                              ),
                            )
                          ])),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: TextField(
                            onChanged: (value) =>
                                {setState((() => text = value))},
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nh???p ????nh gi??...',
                            ),
                          )),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _putFeedback();
                            },
                            icon: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Icon(Icons.send, color: Colors.white),
                            label: Text(
                              "G???i ????nh gi??",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueGrey)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _putFeedback() async {
    setState(() {
      isLoading = true;
    });
    DateTime date = DateTime.parse(history.date);
    double expense = history.price.toDouble();
    await HistoryService.putHistory(
      widget.user,
      history.from_address,
      history.to_address,
      date,
      expense,
      rating,
      history.distance.toInt(),
      text,
      1,
      widget.historyId,
      true,
    ).then((value) => {
          if (value == true)
            {
              setState(() {
                isLoading = false;
              }),
              base.showToastSucces(context, '???? g???i ????nh gi??  !'),
              Navigator.of(context).pop(),
            }
          else
            {throw new Exception('Kh??ng th??? l???y d??? li???u')}
        });
  }
}
