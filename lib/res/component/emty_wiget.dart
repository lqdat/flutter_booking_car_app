import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class Empty extends StatefulWidget {
  String title;
  Empty(this.title);
  @override
  State<Empty> createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.topCenter,
        child: EmptyWidget(
          image: null,
          packageImage: PackageImage.Image_3,
          title: widget.title,
          // subTitle: 'No  notification available yet',
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: Color(0xff9da9c7),
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            color: Color(0xffabb8d6),
          ),
        ));
  }
}
