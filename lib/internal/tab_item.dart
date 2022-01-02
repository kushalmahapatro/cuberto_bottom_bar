import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;

class TabItem extends StatefulWidget {
  /// This title is used in the Tab as text
  final String title;

  /// This icon is used as Tab icon
  final IconData iconData;

  /// This bool is used to know if the respective tab is selected or not
  final bool selected;

  /// This callbackFunction is called when the Tab is clicked
  final Function(Key? uniqueKey) callbackFunction;

  /// This color is used fot the text inside the Tab
  final Color textColor;

  /// This color is used as the icon color of the Tab
  final Color iconColor;

  /// This color is used as the Tab background color
  final Color tabColor;

  /// This gradient is used a the background gradient color of the Tab
  final Gradient? backGroundGradientColor;

  /// This radius is used the borderRadius of the Tab
  final BorderRadius? borderRadius;

  /// This value is used to YAlignment of the icon of the Tab
  final double iconYAlign = ICON_ON;

  /// This value is used to YAlignment of the text of the Tab
  final double textYAlign = TEXT_OFF;

  /// This value is used as the alpha of the icon of the Tab
  final double iconAlpha = ALPHA_ON;

  /// This value is used as a GlobalKey of the Tab
  final GlobalKey stickyKey = GlobalKey();

  /// This style is used to set the tabStyle
  final CubertoTabStyle? tabStyle;

  TabItem(
      {required this.selected,
      required this.iconData,
      required this.title,
      required this.callbackFunction,
      required this.textColor,
      required this.iconColor,
      required this.tabColor,
      this.borderRadius,
      this.backGroundGradientColor,
      this.tabStyle: CubertoTabStyle.STYLE_NORMAL,
      Key? key})
      : super(key: key);

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    Gradient backGradient = LinearGradient(
        colors: [Colors.transparent, Colors.transparent], stops: [0.0, 0.7]);
    Color iconColor = widget.iconColor;
    if (widget.tabStyle == CubertoTabStyle.STYLE_NORMAL) {
      backGradient = widget.selected
          ? LinearGradient(
              colors: [widget.iconColor, widget.iconColor], stops: [0.0, 0.7])
          : LinearGradient(
              colors: [Colors.transparent, Colors.transparent],
              stops: [0.0, 0.7]);
      iconColor = widget.selected ? widget.textColor : widget.iconColor;
    } else {
      backGradient = widget.selected
          ? widget.backGroundGradientColor != null
              ? widget.backGroundGradientColor ??
                  LinearGradient(
                      colors: [Colors.transparent, Colors.transparent],
                      stops: [0.0, 0.7])
              : LinearGradient(colors: [
                  widget.tabColor.withOpacity(0.1),
                  widget.tabColor.withOpacity(0.1)
                ], stops: [
                  0.0,
                  0.7
                ])
          : LinearGradient(
              colors: [Colors.transparent, Colors.transparent],
              stops: [0.0, 0.7]);
      iconColor = widget.selected ? widget.tabColor : widget.iconColor;
    }

    return InkWell(
      child: AnimatedContainer(
        padding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
        duration: Duration(milliseconds: kAnimationDuration),
        decoration: BoxDecoration(
            gradient: backGradient,
            borderRadius:
                widget.borderRadius ?? BorderRadius.all(Radius.circular(20.0))),
        child: AnimatedContainer(
          duration: Duration(milliseconds: kAnimationDuration),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.iconData,
                color: iconColor,
              ),
              SizedBox(width: 8.0),
              AnimatedContainer(
                duration: Duration(milliseconds: kAnimationDuration),
                padding: widget.selected
                    ? EdgeInsets.only(left: 3.0, right: 3.0)
                    : EdgeInsets.all(0.0),
                child: Text(
                  widget.selected ? widget.title : "",
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
        widget.callbackFunction(widget.key);
      },
    );
  }
}
