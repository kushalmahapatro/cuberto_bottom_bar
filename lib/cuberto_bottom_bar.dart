library cuberto_bottom_bar;

import 'package:cuberto_bottom_bar/internal/cuberto_drawer.dart';
import 'package:cuberto_bottom_bar/internal/tab_data.dart';
import 'package:cuberto_bottom_bar/internal/tab_item.dart';
import 'package:flutter/material.dart';

const int kAnimationDuration = 300;

typedef OnTabChangedListener = Function(
    int position, String title, Color? tabColor);

class CubertoBottomBar extends StatefulWidget {
  /// The callback that will be executed each time the tab is changed
  final OnTabChangedListener onTabChangedListener;

  /// This color is used to show that the tab is inactive i.e not selected
  final Color? inactiveIconColor;

  /// This color is used to specify the tab color
  final Color? tabColor;

  /// This color is used to specify the color of text in the tab
  final Color? textColor;

  /// This color is used to set up the background color of the bottom bar
  final Color? barBackgroundColor;

  /// List of [TabData] to set up the bottom nav bar
  final List<TabData> tabs;

  /// [BorderRadius] to add border to the bottom bar.
  final BorderRadius? barBorderRadius;

  /// This int value is used to programmatically change the index of the tabs
  final int selectedTab;

  /// To add a navigation drawer of [CubertoDrawer] type
  final CubertoDrawer? drawer;

  /// [CubertoTabStyle] to be defined as required, by default it will be [CubertoTabStyle.styleNormal]
  final CubertoTabStyle? tabStyle;

  /// The inner padding of the [CubertoBottomBar]
  final EdgeInsets? padding;

  /// The list of shadows of the [CubertoBottomBar]
  final List<BoxShadow>? barShadow;

  const CubertoBottomBar({
    Key? key,
    required this.tabs,
    required this.onTabChangedListener,
    this.selectedTab = 0,
    this.inactiveIconColor,
    this.textColor,
    this.tabColor,
    this.barBackgroundColor,
    this.barBorderRadius,
    this.drawer,
    this.tabStyle,
    this.padding,
    this.barShadow,
  })  : assert(tabs.length > 1 && tabs.length < 5),
        super(key: key);

  @override
  CubertoBottomBarState createState() => CubertoBottomBarState();
}

class CubertoBottomBarState extends State<CubertoBottomBar> {
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;
  int currentSelected = 0;
  double _circleAlignX = 0;
  Color? circleColor;
  Color? activeIconColor;
  Color? inactiveIconColor;
  Color? barBackgroundColor;
  Color? textColor;
  Color? tabColor;
  CubertoDrawerStyle? drawerStyle;
  CubertoTabStyle? tabStyle;
  Icon? drawerIcon;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    activeIcon = widget.tabs[currentSelected].iconData;
    barBackgroundColor = (widget.barBackgroundColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? const Color(0xFF212121)
            : Colors.white
        : widget.barBackgroundColor;
    textColor = (widget.textColor == null) ? Colors.white : widget.textColor;
    inactiveIconColor = (widget.inactiveIconColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor
        : widget.inactiveIconColor;

    tabColor = (widget.tabColor == null) ? activeIconColor : widget.tabColor;
  }

  @override
  void initState() {
    super.initState();
    // If widget.drawer is null then set CubertoDrawerStyle.noDrawer where no drawer will be added to screen
    if (widget.drawer == null) {
      drawerStyle = CubertoDrawerStyle.noDrawer;
      drawerIcon = Icon(
        Icons.menu,
        color: inactiveIconColor,
      );
    } else {
      if (widget.drawer?.style != null) {
        drawerStyle = widget.drawer?.style ?? CubertoDrawerStyle.noDrawer;
      } else {
        drawerStyle = CubertoDrawerStyle.noDrawer;
      }

      if (widget.drawer?.icon != null) {
        drawerIcon = widget.drawer?.icon ?? const Icon(Icons.menu);
      } else {
        drawerIcon = Icon(
          Icons.menu,
          color: inactiveIconColor,
        );
      }
    }
    if (widget.tabStyle == null) {
      tabStyle = CubertoTabStyle.styleNormal;
    } else {
      tabStyle = widget.tabStyle;
    }
    _setSelected(widget.tabs[widget.selectedTab].key);
  }

  void _setSelected(Key? key) {
    int selected = widget.tabs
        .indexWhere((tabData) => tabData.key.toString() == key.toString());
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
    // method to make a particular tab selected
    _setSelected(widget.tabs[widget.selectedTab].key);
    void handleDrawerButton() {
      Scaffold.of(context).openDrawer();
    }

    // method to handle the drawer button
    void handleDrawerButtonEnd() {
      Scaffold.of(context).openEndDrawer();
    }

    Widget actions;
    // set action as drawerStyle
    if (drawerStyle != CubertoDrawerStyle.noDrawer) {
      actions = IconButton(
        icon: drawerIcon ?? const Icon(Icons.menu),
        onPressed: (widget.drawer?.style ?? CubertoDrawerStyle.noDrawer) ==
                CubertoDrawerStyle.endDrawer
            ? handleDrawerButtonEnd
            : handleDrawerButton,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }
    // when no drawerStyle is set then a blank Container is set as action
    else {
      actions = const SizedBox.shrink();
    }
    return Container(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
      decoration: BoxDecoration(
        color: barBackgroundColor,
        borderRadius: widget.barBorderRadius,
        boxShadow: widget.barShadow ??
            <BoxShadow>[
              const BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -1),
                blurRadius: 8,
              ),
            ],
      ),
      child: setUpTabs(
        drawerStyle ?? CubertoDrawerStyle.noDrawer,
        widget.tabs,
        widget.onTabChangedListener,
        actions,
      ),
    );
  }

  Widget rowTabs(
    List<TabData> tabs,
    Function(int position, String title, Color? tabColor) onTabChangedListener,
  ) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tabs
            .map(
              (t) => TabItem(
                key: t.key,
                tabStyle: tabStyle,
                selected: t.key == tabs[currentSelected].key,
                iconData: t.iconData,
                title: t.title,
                iconColor: inactiveIconColor ?? Colors.black,
                textColor: textColor ?? Colors.black,
                backGroundGradientColor: t.tabGradient,
                tabColor: t.tabColor ?? inactiveIconColor ?? Colors.black,
                borderRadius: t.borderRadius,
                callbackFunction: (uniqueKey) {
                  int selected = tabs.indexWhere((tabData) =>
                      tabData.key.toString() == uniqueKey.toString());
                  _setSelected(uniqueKey);
                  _initAnimationAndStart(_circleAlignX, 1);
                  onTabChangedListener(
                      selected, t.title, inactiveIconColor ?? Colors.black);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget setUpTabs(
    CubertoDrawerStyle drawerStyle,
    List<TabData> tabs,
    Function(int position, String title, Color? tabColor) onTabChangedListener,
    Widget actions,
  ) {
    Widget widget;
    if (drawerStyle == CubertoDrawerStyle.endDrawer) {
      widget = Row(
        children: <Widget>[
          Expanded(
            child: rowTabs(tabs, onTabChangedListener),
          ),
          actions,
        ],
      );
    } else if (drawerStyle == CubertoDrawerStyle.startDrawer) {
      widget = Row(
        children: <Widget>[
          actions,
          Expanded(
            child: rowTabs(tabs, onTabChangedListener),
          ),
        ],
      );
    } else {
      widget = rowTabs(tabs, onTabChangedListener);
    }
    return widget;
  }

  void _initAnimationAndStart(double from, double to) {
    Future.delayed(const Duration(milliseconds: kAnimationDuration ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(
          const Duration(milliseconds: (kAnimationDuration ~/ 5 * 3)), () {
        setState(() {});
      });
    });
  }
}
