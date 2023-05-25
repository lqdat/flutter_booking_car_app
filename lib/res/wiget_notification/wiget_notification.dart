// ignore_for_file: unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/component/emty_wiget.dart';
import 'package:flutter_application/res/service/historyservice.dart';
import 'package:flutter_application/res/wiget_home/home_page.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../DTO/notification.dart';
import '../base/const.dart' as Constrants;
import '../component/skeleton_wiget.dart';
import '../service/notificationservice.dart';
import '../stream/notification_bloc.dart';
import '../wiget_home/wigets/info_trip_wiget.dart';

class NotificationPage extends StatefulWidget {
  User user;
  NotificationPage(this.user);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _notification = new NotificationStream();
  bool isLoading = false;
  List<Notify> listNoti = [];

  void getlistHistory() async {
    setState(() {
      isLoading = true;
    });
    await NotificationService.getNotify(widget.user)
        .then((value) => setState(() {
              value.sort((a, b) {
                DateTime aDate = DateTime.parse(a.date);
                DateTime bDate = DateTime.parse(b.date);
                return bDate.compareTo(aDate);
              });
              setState(() {
                if (value.length > 0) {
                  listNoti = value;
                  isLoading = false;
                } else
                  listNoti = [];
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
              onPressed: () => Navigator.pop(context)
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => HomePage(widget.user)))
              ),
          iconTheme:
              IconThemeData(color: Color.fromARGB(136, 6, 54, 113), size: 40),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Thông báo',
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
                  : Container(
                      child: listNoti.length > 0
                          ? StreamBuilder(
                              stream: _notification.stream,
                              builder: (context, snapshot) {
                                return new ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                        key: Key(index.toString()),
                                        startActionPane: ActionPane(
                                          key: Key(index.toString()),
                                          // A motion is a widget used to control how the pane animates.
                                          motion: DrawerMotion(),
                                          dismissible: DismissiblePane(
                                            onDismissed: () => {
                                              deletebyId(
                                                  listNoti.elementAt(index).id)
                                            },
                                            key: Key(index.toString()),
                                          ),
                                          // All actions are defined in the children parameter.
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            SlidableAction(
                                              onPressed: (_) {
                                                deletebyId(listNoti
                                                    .elementAt(index)
                                                    .id);
                                              },
                                              backgroundColor:
                                                  Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                            ),
                                          ],
                                        ),
                                        child: SizedBox(
                                          height: 100.0,
                                          child: Card(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30)),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 5,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: ListTile(
                                                title: Text(
                                                    DateFormat(
                                                            'yyyy-MM-dd – kk:mm')
                                                        .format(DateTime.parse(
                                                            listNoti
                                                                .elementAt(
                                                                    index)
                                                                .date))),
                                                subtitle: Text(listNoti
                                                    .elementAt(index)
                                                    .content),
                                                leading: CircleAvatar(
                                                  child: Text(
                                                      (index + 1).toString()),
                                                ),
                                                onTap: () {},
                                                onLongPress: () {},
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: index % 2 == 0
                                                      ? Colors.green[300]
                                                      : Colors.cyan[200],
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
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      color: Colors.blueGrey,
                                      thickness: 2,
                                      indent: 50,
                                      endIndent: 50,
                                    );
                                  },
                                  itemCount: listNoti.length,
                                  scrollDirection: Axis.vertical,
                                );
                              },
                            )
                          : Empty('Chưa có thông báo'),
                    ),
            ),
            Positioned(
              top: 0,
              right: 16,
              child: listNoti.length > 0
                  ? RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Cảnh Báo'),
                                content: const Text(
                                    'Bạn có chắc muốn xóa tất cả thông báo ?'),
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
                        text: "Xóa tất cả thông báo",
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
    // for (int i = 0; i < listNoti.length; i++) {
    //   await HistoryService.deleteHistory(widget.user, listNoti[i].id);
    // }

    getlistHistory();
  }

  Future<void> deletebyId(String Id) async {
    setState(() {
      isLoading = true;
    });
    await NotificationService.deleteNotifybyId(Id);

    getlistHistory();
  }
}
