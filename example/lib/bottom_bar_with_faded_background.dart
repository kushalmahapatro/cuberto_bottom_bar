import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:example/gradient_color.dart';
import 'package:flutter/material.dart';

class BottomBarWithFadedBackground extends StatefulWidget {
  const BottomBarWithFadedBackground({super.key});

  @override
  State<BottomBarWithFadedBackground> createState() =>
      _BottomBarWithFadedBackgroundState();
}

class _BottomBarWithFadedBackgroundState
    extends State<BottomBarWithFadedBackground> {
  List<TabData> tabs = [];
  final Color _inactiveColor = Colors.lightBlue;
  Color _currentColor = Colors.blue;
  int _currentPage = 0;
  late String _currentTitle;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabData(
        iconData: Icons.home,
        title: "Home",
        tabColor: Colors.deepPurple,
        tabGradient: getGradient(Colors.deepPurple),
      ),
      TabData(
        iconData: Icons.search,
        title: "Search",
        tabColor: Colors.pink,
        tabGradient: getGradient(Colors.pink),
      ),
      TabData(
        iconData: Icons.alarm,
        title: "Alarm",
        tabColor: Colors.amber,
        tabGradient: getGradient(Colors.amber),
      ),
      TabData(
        iconData: Icons.settings,
        title: "Settings",
        tabColor: Colors.teal,
        tabGradient: getGradient(Colors.teal),
      ),
    ];
    _currentTitle = tabs[0].title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faded Background Style Demo"),
      ),
      body: Center(
        child: Text(
          _currentTitle,
          style: TextStyle(fontWeight: FontWeight.bold, color: _currentColor),
        ),
      ),
      bottomNavigationBar: CubertoBottomBar(
        key: const Key("BottomBar"),
        inactiveIconColor: _inactiveColor,
        tabStyle: CubertoTabStyle.styleFadedBackground,
        selectedTab: _currentPage,
        tabs: tabs
            .map(
              (value) => TabData(
                key: Key(value.title),
                iconData: value.iconData,
                title: value.title,
                tabColor: value.tabColor,
                tabGradient: value.tabGradient,
              ),
            )
            .toList(),
        onTabChangedListener: (position, title, color) {
          setState(() {
            _currentPage = position;
            _currentTitle = title;
            if (color != null) {
              _currentColor = color;
            }
          });
        },
      ),
    );
  }
}
