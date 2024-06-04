import 'package:flutter/material.dart';

/// A custom drawer widget with configurable icon and style.
class CubertoDrawer {
  /// This icon will be used as the drawer icon.
  final Icon? icon;

  /// This style will be used to decide where the drawer icon will be placed.
  final CubertoDrawerStyle style;

  /// Creates a CubertoDrawer.
  ///
  /// The [icon] parameter specifies the icon to be used.
  /// The [style] parameter determines the placement of the drawer icon.
  const CubertoDrawer({this.icon, this.style = CubertoDrawerStyle.noDrawer});
}

/// Enum to set the drawer position.
enum CubertoDrawerStyle { startDrawer, endDrawer, noDrawer }
