import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

/// Offset value for the icon when it is off.
const double iconOff = -3;

/// Offset value for the icon when it is on.
const double iconOn = 0;

/// Offset value for the text when it is off.
const double textOff = 3;

/// Offset value for the text when it is on.
const double textOn = 1;

/// Alpha value for the icon when it is off.
const double alphaOff = 0;

/// Alpha value for the icon when it is on.
const double alphaOn = 1;

class TabItem extends StatefulWidget {
  /// This bool is used to know if the respective tab is selected or not
  final bool selected;

  /// This callbackFunction is called when the Tab is clicked
  final Function(TabData tabData) callbackFunction;

  /// THis color is used as inactive color if [tabData.color] is null
  final Color inactiveColor;

  /// This color is used fot the text inside the Tab
  final Color textColor;

  /// This color is used as the icon color of the Tab
  final Color iconColor;

  /// This gradient is used a the background gradient color of the Tab
  final Gradient? backGroundGradientColor;

  /// This value is used to YAlignment of the icon of the Tab
  final double iconYAlign = iconOn;

  /// This value is used to YAlignment of the text of the Tab
  final double textYAlign = textOff;

  /// This value is used as the alpha of the icon of the Tab
  final double iconAlpha = alphaOn;

  /// This value is used as a GlobalKey of the Tab
  final GlobalKey stickyKey = GlobalKey();

  /// This style is used to set the tabStyle
  final CubertoTabStyle? tabStyle;

  /// This TabData is used to set the TabData of the Tab
  final TabData tabData;

  /// Constructor for TabItem widget.
  ///
  /// Parameters:
  /// - selected: Indicates if the tab is selected.
  /// - callbackFunction: Callback function called when the tab is clicked.
  /// - textColor: Color used for the text inside the tab.
  /// - iconColor: Color used as the icon color of the tab.
  /// - inactiveColor: Color used as inactive color if [tabData.color] is null.
  /// - tabData: TabData used to set the data of the tab.
  /// - backGroundGradientColor: Gradient used as the background gradient color of the tab.
  /// - tabStyle: Style of the tab, default is CubertoTabStyle.styleNormal.
  TabItem({
    super.key,
    required this.selected,
    required this.callbackFunction,
    required this.textColor,
    required this.iconColor,
    required this.inactiveColor,
    required this.tabData,
    this.backGroundGradientColor,
    this.tabStyle = CubertoTabStyle.styleNormal,
  }) {
    _iconData = tabData.iconData;
    _title = tabData.title;
    _tabColor = tabData.tabColor ?? inactiveColor;
    _borderRadius = tabData.borderRadius ??
        const BorderRadius.all(
          Radius.circular(20.0),
        );
  }

  late final IconData _iconData;
  late final String _title;
  late final Color _tabColor;
  late final BorderRadius? _borderRadius;

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    Gradient backGradient = const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
      stops: [0.0, 0.7],
    );
    Color iconColor = widget.iconColor;
    if (widget.tabStyle == CubertoTabStyle.styleNormal) {
      backGradient = widget.selected
          ? LinearGradient(
              colors: [widget.iconColor, widget.iconColor],
              stops: const [0.0, 0.7],
            )
          : const LinearGradient(
              colors: [Colors.transparent, Colors.transparent],
              stops: [0.0, 0.7],
            );
      iconColor = widget.selected ? widget.textColor : widget.iconColor;
    } else {
      backGradient = widget.selected
          ? widget.backGroundGradientColor != null
              ? widget.backGroundGradientColor ??
                  const LinearGradient(
                      colors: [Colors.transparent, Colors.transparent],
                      stops: [0.0, 0.7])
              : LinearGradient(
                  colors: [
                    widget._tabColor.withOpacity(0.1),
                    widget._tabColor.withOpacity(0.1)
                  ],
                  stops: const [0.0, 0.7],
                )
          : const LinearGradient(
              colors: [Colors.transparent, Colors.transparent],
              stops: [0.0, 0.7],
            );
      iconColor = widget.selected ? widget._tabColor : widget.iconColor;
    }

    return InkWell(
      key: widget.tabData.key,
      child: AnimatedContainer(
        padding: const EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
        duration: const Duration(milliseconds: kAnimationDuration),
        decoration: BoxDecoration(
          gradient: backGradient,
          borderRadius: widget._borderRadius,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: kAnimationDuration),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget._iconData,
                color: iconColor,
              ),
              const SizedBox(width: 8.0),
              AnimatedContainer(
                duration: const Duration(milliseconds: kAnimationDuration),
                padding: widget.selected
                    ? const EdgeInsets.only(left: 3.0, right: 3.0)
                    : const EdgeInsets.all(0.0),
                child: Text(
                  widget.selected ? widget._title : "",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        /// Callback called when the Tab is clicked
        widget.callbackFunction(widget.tabData);
      },
    );
  }
}
