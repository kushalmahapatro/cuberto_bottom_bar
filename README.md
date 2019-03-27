
# Cuberto Bottom Bar
Cuberto Bottom Bar in flutter<br/>
## Cuberto Bottom bar Gif- Default Style<br/>
![Cuberto Bottom bar Gif- Default Style](https://media.giphy.com/media/5RSvz7q2sj5HmmzVf1/giphy.gif "Cuberto Bottom bar Gif- Default Style") <br/>

## Cuberto Bottom bar Gif- Faded Style<br/>
![Cuberto Bottom bar Gif- Faded Style](https://media.giphy.com/media/8Twd7w3GZi12XFAPEQ/giphy.gif "Cuberto Bottom bar Gif- Faded Style") <br/>

## Getting Started

```yaml
dependencies:
  ...
  cuberto_bottom_bar: ^0.0.1
```

## Limitations
For now this is limited to more than 1 tab, and less than 5. So 2-4 tabs.

## Basic Usage

Adding the widget
```dart
bottomNavigationBar: CubertoBottomBar(
        inactiveIconColor: inactiveColor,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND, // By default its CubertoTabStyle.STYLE_NORMAL
        initialSelection: 0, // By default its 0
        drawer: CubertoDrawer.NO_DRAWER, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
        tabs: [
          TabData(
              iconData: Icons.home,
              title: "Home",
              tabColor: Colors.deepPurple),
          TabData(
              iconData: Icons.search,
              title: "Search",
              tabColor: Colors.pink),
          TabData(
              iconData: Icons.access_alarm,
              title: "Alarm",
              tabColor: Colors.amber),
          TabData(
              iconData: Icons.settings,
              title: "Settings",
              tabColor: Colors.teal),
        ],
        onTabChangedListener: (position, title, color) {
          setState(() {
            currentPage = position;
            currentTitle = title;
            currentColor = color;
          });
        },
      ),
```

## TabData
**iconData** -> Icon to be used for the tab<br/>
**title** -> String to be used for the tab<br/>
**onClick** -> Optional function to be used when the circle itself is clicked, on an active tab

## Attributes
### required
**tabs** -> List of `TabData` objects<br/>
**onTabChangedListener** -> Function to handle a tap on a tab, receives `int position`

### optional
**initialSelection** -> Defaults to 0<br/>
**activeIconColor** -> Defaults to null, derives from `Theme`<br/>
**inactiveIconColor** -> Defaults to null, derives from `Theme`<br/>
**textColor** -> Defaults to null, derives from `Theme`<br/>
**barBackgroundColor** -> Defaults to null, derives from `Theme`<br/>
**key** -> Defaults to null<br/>

## Theming

The bar will attempt to use your current theme out of the box, however you may want to theme it. Here are the attributes:


![Cuberto Bottom Bar Theming]( "Cuberto Bottom Bar Theming")

## Showcase
Using this package in a live app, let me know and I'll add you app here.


## Inspiration

This package was inspired by a design on dribbble by Sourabh Gupta and the faded backgorund style from Aurelien Salomon:<br/>
https://github.com/sourabhgupta811/CubertoBottomBar <br/>
https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern <br/>
https://www.instagram.com/p/BtyUbSkBlnF/ <br/>
## Contributing

Contributions are welcome, please submit a PR :)
