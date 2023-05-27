// ignore_for_file: unnecessary_new, import_of_legacy_library_into_null_safe

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/component/emty_wiget.dart';
import 'package:flutter_application/res/component/loading_wiget.dart';
import 'package:flutter_application/res/service/historyservice.dart';
import 'package:flutter_application/res/stream/history_bloc.dart';
import 'package:flutter_application/res/wiget_home/home_page.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import '../base/const.dart' as Constrants;
import '../DTO/car.dart';
import '../component/skeleton_wiget.dart';
import '../service/carservice.dart';
import '../wiget_home/wigets/info_trip_wiget.dart';

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
  List<Car> listCar = [];

  Future<void> getlistHistory() async {
    setState(() {
      isLoading = true;
    });
    await CarService.getCar().then((value) {
      setState(() {
        listCar = value;
      });
      ;
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
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Color.fromARGB(136, 6, 54, 113), size: 40),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(widget.user)))),
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
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              
              child: isLoading
                  ? SkeletonWiget()
                  : new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),child: Container(
                      child: listHistory.length > 0
                          ? StreamBuilder(
                              stream: _historyStream.stream,
                              builder: (context, snapshot) {
                                return RefreshIndicator(onRefresh: () =>getlistHistory() ,
                                child: new ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                        startActionPane: ActionPane(
                                          // A motion is a widget used to control how the pane animates.
                                          motion: DrawerMotion(),
                                          // All actions are defined in the children parameter.
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            SlidableAction(
                                              onPressed: (_) {
                                                deletebyId(listHistory
                                                    .elementAt(index)
                                                    .id);
                                              },
                                              backgroundColor:
                                                  Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Xóa',
                                            ),
                                            SlidableAction(
                                              onPressed: (_) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            (InfoTrip(
                                                                listHistory
                                                                    .elementAt(
                                                                        index)
                                                                    .id,
                                                                widget.user,
                                                                false))));
                                              },
                                              backgroundColor:
                                                  Color(0xFF21B7CA),
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit,
                                              label: listHistory.elementAt(index).status==0?'Đánh giá' :'Chỉnh sửa',
                                            ),
                                          ],
                                        ),
                                        child: SizedBox(
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
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8.0,
                                                    ),
                                                    child: new Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          margin: new EdgeInsets
                                                              .only(left: 0.0),
                                                          child: new Container(
                                                            height: 200,
                                                            width: 300,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0.0,
                                                                    left: 72.0),
                                                            child: new Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                new Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          new Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 2),
                                                                            child:
                                                                                new Row(
                                                                              children: [
                                                                                new Icon(Icons.location_on, size: 20.0, color: Colors.red),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 5),
                                                                                  child: new Text(listHistory.elementAt(index).from_address.toString(), style: TextStyle(fontSize: 16)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-0.94, 1),
                                                                            child: Dash(
                                                                                direction: Axis.vertical,
                                                                                length: 19,
                                                                                dashLength: 2,
                                                                                dashColor: Colors.white),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 10, top: 2),
                                                                            child:
                                                                                new Row(
                                                                              children: [
                                                                                new Icon(Icons.location_on, size: 20.0, color: Colors.green),
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
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 50.0,
                                                              top: 16,
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xfff7f7f7),
                                                              ),
                                                              width: 64,
                                                              height: 64,
                                                              child: Center(
                                                                child: getImageCar(
                                                                    listHistory
                                                                        .elementAt(
                                                                            index)
                                                                        .carId),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomStart,
                                                  child: new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      new Row(
                                                        children: [
                                                          new Icon(
                                                              Icons.date_range,
                                                              size: 20.0,
                                                              color:
                                                                  Colors.white),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: new Text(
                                                                DateFormat(
                                                                        'yyyy-MM-dd – kk:mm')
                                                                    .format(DateTime.parse(listHistory
                                                                        .elementAt(
                                                                            index)
                                                                        .date
                                                                        .toString())),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
                                                          ),
                                                        ],
                                                      ),
                                                      new Row(
                                                        children: [
                                                          new Icon(
                                                              Icons
                                                                  .price_change,
                                                              size: 20.0,
                                                              color:
                                                                  Colors.white),
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
                                                                    " VNĐ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
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
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    child: RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating: listHistory
                                                          .elementAt(index)
                                                          .rating
                                                          .toDouble(),
                                                      itemSize: 25,
                                                      minRating: 0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomEnd,
                                                  child: listHistory
                                                              .elementAt(index)
                                                              .status ==
                                                          0
                                                      ? Container(
                                                          width: 150.0,
                                                          height: 24.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                            ),
                                                            color: Colors.red,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'Chưa đánh giá',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Arial',
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                height: 1,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        )
                                                      : null,
                                                )
                                              ]),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      136, 6, 54, 113),
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  shadowColor:
                                                      Colors.transparent),
                                            ),
                                          ),
                                        ));
                                  },
                                  itemCount: listHistory.length,
                                  scrollDirection: Axis.vertical,
                                )
                                );
                              },
                            )
                          : Empty('Chưa có lịch sử đặt xe'),
                    )),
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
                                title: const Text('Cảnh Báo'),
                                content: const Text(
                                    'Bạn có chắc muốn xóa lịch sử đặt xe ?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Hủy'),
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
                        text: "Xóa lịch sử đặt xe",
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

  Future<void> deletebyId(String Id) async {
    setState(() {
      isLoading = true;
    });
    await HistoryService.deleteHistorybyId(Id);

    getlistHistory();
  }

  Image? getImageCar(String Id) {
    var URL = listCar.where((element) => element.id == Id).single.URLImage;

    return Image.network(Constrants.URl + URL);
  }
}
