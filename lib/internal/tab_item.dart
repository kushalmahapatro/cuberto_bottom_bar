import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;

class TabItem extends StatefulWidget {
  TabItem(
      {@required this.uniqueKey,
      @required this.selected,
      @required this.iconData,
      @required this.title,
      @required this.callbackFunction,
      @required this.textColor,
      @required this.iconColor,
      @required this.tabColor,
      this.borderRadius,
      this.backGroundGradientColor,
      this.tabStyle});

  final UniqueKey uniqueKey;
  final String title;
  final IconData iconData;
  final bool selected;
  final Function(UniqueKey uniqueKey) callbackFunction;
  final Color textColor;
  final Color iconColor;
  final Color tabColor;
  final Gradient backGroundGradientColor;
  final BorderRadius borderRadius;

  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;
  final GlobalKey stickyKey = GlobalKey();
  final CubertoTabStyle tabStyle;

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
              ? widget.backGroundGradientColor
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
        duration: Duration(milliseconds: ANIM_DURATION),
        decoration: BoxDecoration(
            // color: widget.backGroundGradientColor != null ? Colors.transparent : finalColor,
            gradient: backGradient,
            borderRadius:
                widget.borderRadius ?? BorderRadius.all(Radius.circular(20.0))),
        child: AnimatedContainer(
          duration: Duration(milliseconds: ANIM_DURATION),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.iconData,
                color: iconColor,
              ),
              SizedBox(width: 8.0),
              AnimatedContainer(
                duration: Duration(milliseconds: ANIM_DURATION),
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
        widget.callbackFunction(widget.uniqueKey);
      },
    );
  }
}
