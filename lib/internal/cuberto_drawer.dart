import 'package:flutter/material.dart';

class CubertoDrawer {
  /// This icon will be used as the drawer icon
  final Icon? icon;

  /// This style will be used to decide where the drawer icon will be placed
  final CubertoDrawerStyle style;

  const CubertoDrawer({this.icon, this.style = CubertoDrawerStyle.noDrawer});
}

/// enum to set teh drawer position
enum CubertoDrawerStyle { startDrawer, endDrawer, noDrawer }
