import 'package:flutter/material.dart';

class TabData {
  /// This iconData will be used in the Tab
  IconData iconData;

  /// This string will be used as the text inside the Tab
  String title;

  /// This onclick function to be called when clicked on Tab
  Function? onclick;

  /// This color is set as the background color of the Tab
  Color? tabColor;

  /// This gradient color is used a the background gradient of the Tab
  Gradient? tabGradient;

  /// This borderRadius is used as the the borderRadius of the Tab
  BorderRadius? borderRadius;

  /// This key is used as unique value to the Tab (if not set default UniqueKey will be added to the Tab)
  Key? key;

  TabData({
    required this.iconData,
    required this.title,
    this.onclick,
    this.tabColor,
    this.borderRadius,
    this.tabGradient,
    this.key,
  }) {
    key = key ?? UniqueKey();
  }
}

/// enum to set the tab style
enum CubertoTabStyle { styleNormal, styleFadedBackground }
