import 'dart:math';

import 'package:flutter/material.dart';

Random random = new Random();

final _colors = <int, Color>{
  0: Colors.deepPurple,
  1: Colors.cyan,
  2: Colors.grey,
  3: Colors.yellow,
  4: Colors.blue,
};

String setColor() {
  int randomIndex = random.nextInt(_colors.length); // from 0 to 4 included
  Color _color = _colors[randomIndex];

  return '#${_color.value.toRadixString(16)}';
}
