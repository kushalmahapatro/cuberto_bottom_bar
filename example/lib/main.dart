import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  String currentTitle = "Home";
  Color currentColor = Colors.deepPurple;
  Color inactiveColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: currentColor),
        child: Center(
            child: Text(
          currentTitle,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        )),
      ),
      drawer: new Container(
          width: 250.0,
          margin: EdgeInsets.only(bottom: 60.0),
          color: Colors.blue,
          child: ListView(
            children: <Widget>[Text("Hello"), Text("World")],
          )),
      endDrawer: new Container(
          width: 250.0,
          margin: EdgeInsets.only(bottom: 60.0),
          color: Colors.blue,
          child: ListView(
            children: <Widget>[Text("Hello"), Text("World")],
          )),
      bottomNavigationBar: CubertoBottomBar(
        inactiveIconColor: inactiveColor,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        initialSelection: 0,
//        drawer: CubertoDrawer(style: CubertoDrawerStyle.END_DRAWER, icon: Icon(Icons.sort)),
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "Home",
            tabColor: Colors.deepPurple,
          ),
          TabData(
            iconData: Icons.search,
            title: "Search",
            tabColor: Colors.pink,
          ),
          TabData(
            iconData: Icons.access_alarm,
            title: "Alarm",
            tabColor: Colors.amber,
          ),
          TabData(
            iconData: Icons.settings,
            title: "Settings",
            tabColor: Colors.teal,
          ),
        ],
        onTabChangedListener: (position, title, color) {
          setState(() {
            currentPage = position;
            currentTitle = title;
            currentColor = color;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
