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

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin  {
  int currentPage ;
  Color currentColor = Colors.deepPurple;
  Color inactiveColor = Colors.black;
  TabController tabBarController;
  List<Tabs> tabs = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = 0;
    tabs.add(Tabs(Icons.home, "Home", Colors.deepPurple));
    tabs.add(Tabs(Icons.search, "Search", Colors.pink));
    tabs.add(Tabs(Icons.alarm, "Alarm", Colors.amber));
    tabs.add(Tabs(Icons.settings, "Settings", Colors.teal));
    tabBarController =
    new TabController(initialIndex: currentPage, length: 4, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: TabBarView(
        controller: tabBarController,
        physics: NeverScrollableScrollPhysics(),
        children: {2,3,1,0}.map((index) => Container(
          decoration: BoxDecoration(color: tabs[currentPage].color),
          child: InkWell(
              child: Center(
                  child:
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        tabs[currentPage].title ,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Click here to Change the tab To "+tabs[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ],
                  )),
              onTap: () {
                setState(() {
                  currentPage = index;
                  tabBarController.animateTo(currentPage);
                });
              }),
        ),).toList()
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
        selectedTab: currentPage, /// initial Selection has been renames to selectedTab, setting the index value to this will change the tab
        tabs: tabs.map((value) => TabData(
          iconData: value.icon,
          title: value.title,
          tabColor: value.color,
        )).toList(),
        onTabChangedListener: (position, title, color) {
          setState(() {
            tabBarController.animateTo(position);
            currentPage = position;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }
}

class Tabs{
  final IconData icon;
  final String title;
  final Color color;

  Tabs(this.icon, this.title, this.color);
}