library cuberto_bottom_bar;

import 'package:cuberto_bottom_bar/internal/tab_item.dart';
import 'package:cuberto_bottom_bar/internal/tab_item_new.dart';

import 'package:flutter/material.dart';


const double BAR_HEIGHT = 60;
const int ANIM_DURATION = 300;

class CubertoBottomBar extends StatefulWidget {
  final Function(int position, String title, Color tabColor) onTabChangedListener;
  final Color circleColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color tabColor;
  final Color textColor;
  final Color barBackgroundColor;
  final List<TabData> tabs;
  final int initialSelection;
  final CubertoDrawer drawer;
  final CubertoTabStyle tabStyle;

  final Key key;
  CubertoBottomBar(
      {@required this.tabs,
      @required this.onTabChangedListener,
      this.key,
      this.initialSelection = 0,
      this.circleColor,
      this.activeIconColor,
      this.inactiveIconColor,
      this.textColor,
      this.tabColor,
      this.barBackgroundColor,
      this.drawer,
      this.tabStyle})
      : assert(onTabChangedListener != null),
        assert(tabs != null),
        assert(tabs.length > 1 && tabs.length < 5);

  @override
  CubertoBottomBarState createState() => CubertoBottomBarState();
}

class CubertoBottomBarState extends State<CubertoBottomBar>
    with TickerProviderStateMixin, RouteAware {
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 0;
  double _circleAlignX = 0;

  Color circleColor;
  Color activeIconColor;
  Color inactiveIconColor;
  Color barBackgroundColor;
  Color textColor;
  Color tabColor;

  CubertoDrawer drawer;
  CubertoTabStyle tabStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeIcon = widget.tabs[currentSelected].iconData;

    circleColor = (widget.circleColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor
        : widget.circleColor;

    activeIconColor = (widget.activeIconColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white
        : widget.activeIconColor;

    barBackgroundColor = (widget.barBackgroundColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Color(0xFF212121)
            : Colors.white
        : widget.barBackgroundColor;
    textColor = (widget.textColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black54
        : widget.textColor;
    inactiveIconColor = (widget.inactiveIconColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor
        : widget.inactiveIconColor;

    tabColor =
        (widget.tabColor == null) ? activeIconColor : widget.tabColor;
  }

  @override
  void initState() {
    super.initState();
    if (widget.drawer == null) {
      drawer = CubertoDrawer.NO_DRAWER;
    } else {
      drawer = widget.drawer;
    }
    if (widget.tabStyle == null) {
      tabStyle = CubertoTabStyle.STYLE_NORMAL;
    } else {
      tabStyle = widget.tabStyle;
    }
    _setSelected(widget.tabs[widget.initialSelection].key);
  }

  _setSelected(UniqueKey key) {
    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);

    if (mounted) {
      setState(() {
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].iconData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void _handleDrawerButton() {
      Scaffold.of(context).openDrawer();
    }

    void _handleDrawerButtonEnd() {
      Scaffold.of(context).openEndDrawer();
    }

    Widget actions;
    if (drawer != CubertoDrawer.NO_DRAWER) {
      actions = IconButton(
        icon: Icon(
          Icons.menu,
          color: inactiveIconColor,
        ),
        onPressed: widget.drawer == CubertoDrawer.END_DRAWER
            ? _handleDrawerButtonEnd
            : _handleDrawerButton,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    } else {
      actions = Container();
    }
    return Stack(
      overflow: Overflow.clip,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
          height: BAR_HEIGHT,
          decoration: BoxDecoration(color: barBackgroundColor, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]),
          child: setUptabs(
              widget.drawer, widget.tabs, widget.onTabChangedListener, actions),
        ),
      ],
    );
  }

  rowTabs(List<TabData> tabs, Function(int position, String title, Color tabColor) onTabChangedListener) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: tabs
          .map((t) => tabStyle == CubertoTabStyle.STYLE_NORMAL
              ? TabItem(
                  uniqueKey: t.key,
                  selected: t.key == tabs[currentSelected].key,
                  iconData: t.iconData,
                  title: t.title,
                  iconColor: inactiveIconColor,
                  textColor: textColor,
                  tabColor: t.tabColor == null ? inactiveIconColor : t.tabColor,
                  callbackFunction: (uniqueKey) {
                    int selected =
                        tabs.indexWhere((tabData) => tabData.key == uniqueKey);
                    onTabChangedListener(selected, t.title, inactiveIconColor);
                    _setSelected(uniqueKey);
                    _initAnimationAndStart(_circleAlignX, 1);
                  })
              : TabItemNew(
                  uniqueKey: t.key,
                  selected: t.key == tabs[currentSelected].key,
                  iconData: t.iconData,
                  title: t.title,
                  iconColor: inactiveIconColor,
                  textColor: textColor,
                  tabColor: t.tabColor == null ? inactiveIconColor : t.tabColor,
                  callbackFunction: (uniqueKey) {
                    int selected =
                        tabs.indexWhere((tabData) => tabData.key == uniqueKey);
                    onTabChangedListener(selected , t.title, t.tabColor);
                    _setSelected(uniqueKey);
                    _initAnimationAndStart(_circleAlignX, 1);
                  }))
          .toList(),
    );
  }

  setUptabs(CubertoDrawer drawer, List<TabData> tabs,
      Function(int position, String title, Color tabColor) onTabChangedListener, Widget actions) {
    Widget widget;
    if (drawer == CubertoDrawer.END_DRAWER) {
      widget = Row(children: <Widget>[
        Expanded(
          child: rowTabs(tabs, onTabChangedListener),
        ),
        actions,
      ]);
    } else if (drawer == CubertoDrawer.START_DRAWER) {
      widget = Row(children: <Widget>[
        actions,
        Expanded(
          child: rowTabs(tabs, onTabChangedListener),
        ),
      ]);
    } else {
      widget = rowTabs(tabs, onTabChangedListener);
    }
    return widget;
  }

  _initAnimationAndStart(double from, double to) {

    Future.delayed(Duration(milliseconds: ANIM_DURATION ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(Duration(milliseconds: (ANIM_DURATION ~/ 5 * 3)), () {
        setState(() {
        });
      });
    });
  }

}

class TabData {
  TabData(
      {@required this.iconData,
      @required this.title,
      this.onclick,
      this.tabColor});
  IconData iconData;
  String title;
  Function onclick;
  Color tabColor;
  final UniqueKey key = UniqueKey();
}

enum CubertoDrawer { START_DRAWER, END_DRAWER, NO_DRAWER }

enum CubertoTabStyle { STYLE_NORMAL, STYLE_FADED_BACKGROUND }
