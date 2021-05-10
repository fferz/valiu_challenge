import 'package:flutter/material.dart';

int _index = 0;

final _colors = <int, Color>{
  0: Colors.deepPurple,
  1: Colors.cyan,
  2: Colors.grey,
  3: Colors.yellow,
  4: Colors.blue,
};

Color getColor() {
  Color _color = _colors[_index];
  _index == 4 ? _index = 0 : _index += 1;
  return _color;
}
