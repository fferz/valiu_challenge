import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BulletIcon extends StatelessWidget {
  final String color;

  BulletIcon({@required this.color});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: HexColor(color),
        shape: BoxShape.circle,
      ),
    );
  }
}
