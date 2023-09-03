import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink, brightness: Brightness.light),
      home: Scaffold(
        body: const Placeholder(),
        bottomNavigationBar: child,
      ),
    );
  }

  testWidgets('Correct styling for tabs', (WidgetTester tester) async {
    CubertoBottomBar fn = CubertoBottomBar(
      tabs: <TabData>[
        TabData(iconData: Icons.home, title: 'Home'),
        TabData(iconData: Icons.search, title: 'Search'),
      ],
      onTabChangedListener: (_, __, ___) {},
      tabStyle: CubertoTabStyle.styleFadedBackground,
    );

    await tester.pumpWidget(makeTestableWidget(child: fn));

    final homeFinder = find.text('Home');
    final homeIconFinder = find.byIcon(Icons.home);
    final searchFinder = find.text('Search');
    final searchIconFinder = find.byIcon(Icons.search);

    expect(homeFinder, findsOneWidget);
    expect(homeIconFinder, findsOneWidget);
    expect(searchFinder, findsNothing);
    expect(searchIconFinder, findsOneWidget);
  });

  testWidgets('Clicking icon moves selected icon', (WidgetTester tester) async {
    await tester.pumpWidget(_TestApp());

    final homeFinder = find.text('Home');
    final homeIconFinder = find.byIcon(Icons.home);
    final searchFinder = find.text('Search');
    final searchIconFinder = find.byIcon(Icons.search);

    expect(homeFinder, findsOneWidget);
    expect(homeIconFinder, findsOneWidget);
    expect(searchFinder, findsNothing);
    expect(searchIconFinder, findsOneWidget);

    await tester.tap(searchIconFinder);
    await tester.pump(const Duration(milliseconds: kAnimationDuration));

    expect(homeFinder, findsNothing);
    expect(homeIconFinder, findsOneWidget);
    expect(searchFinder, findsOneWidget);
    expect(searchIconFinder, findsOneWidget);

    await tester.tap(homeIconFinder);
    await tester.pump(const Duration(milliseconds: kAnimationDuration));

    expect(homeFinder, findsOneWidget);
    expect(homeIconFinder, findsOneWidget);
    expect(searchFinder, findsNothing);
    expect(searchIconFinder, findsOneWidget);
  });
}

class _TestApp extends StatefulWidget {
  @override
  __TestAppState createState() => __TestAppState();
}

class __TestAppState extends State<_TestApp> {
  late int _selected;
  @override
  void initState() {
    super.initState();
    _selected = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Placeholder(),
        bottomNavigationBar: CubertoBottomBar(
          onTabChangedListener: (int position, _, __) {
            setState(() {
              _selected = position;
            });
          },
          selectedTab: _selected,
          tabs: <TabData>[
            TabData(iconData: Icons.home, title: 'Home'),
            TabData(iconData: Icons.search, title: 'Search')
          ],
        ),
      ),
    );
  }
}
