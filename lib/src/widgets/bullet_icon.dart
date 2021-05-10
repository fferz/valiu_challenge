import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/utils/bullet_colors.dart';

class BulletIcon extends StatelessWidget {
  BulletIcon();

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: getColor(),
        shape: BoxShape.circle,
      ),
    );
  }
}
