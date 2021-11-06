import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'input': Icons.input,
};

Icon getIcon(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: Colors.blue);
}
