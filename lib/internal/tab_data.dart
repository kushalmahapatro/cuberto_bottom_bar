import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents data for a tab in a tab bar.
class TabData extends Equatable {
  /// Icon data to be displayed in the tab.
  final IconData iconData;

  /// Text to be displayed inside the tab.
  final String title;

  /// Function to be called when the tab is clicked.
  final Function? onClick;

  /// Background color of the tab.
  final Color? tabColor;

  /// Background gradient of the tab.
  final Gradient? tabGradient;

  /// Border radius of the tab.
  final BorderRadius? borderRadius;

  /// Unique key for the tab.
  final Key? key;

  /// Constructs a TabData instance with the following parameters:
  /// - iconData: Icon data to be displayed in the tab.
  /// - title: Text to be displayed inside the tab.
  /// - onClick: Function to be called when the tab is clicked.
  /// - tabColor: Background color of the tab.
  /// - borderRadius: Border radius of the tab.
  /// - tabGradient: Background gradient of the tab.
  /// - key: Unique key for the tab.
  const TabData({
    required this.iconData,
    required this.title,
    this.onClick,
    this.tabColor,
    this.borderRadius,
    this.tabGradient,
    this.key,
  });

  @override
  List<Object?> get props => [
        iconData,
        title,
        onClick,
        tabColor,
        tabGradient,
        borderRadius,
        key,
      ];
}

/// Enum to set the tab style.
enum CubertoTabStyle { styleNormal, styleFadedBackground }
