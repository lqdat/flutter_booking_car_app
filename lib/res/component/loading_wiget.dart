import 'package:flutter/material.dart';

class LoaderTransparent extends StatelessWidget {
  late double height;
  late double width;
  Color colorValue;
  LoaderTransparent(this.colorValue);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          height: 60.0,
          width: 60.0,
          child: Stack(children: const <Widget>[
            Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                  strokeWidth: 5.0),
            ),
          ]),
          //Image.asset('assets/images/loader.gif',fit: BoxFit.fill,) // use you custom loader or default loader
        ),
      ),
    );
  }
}
