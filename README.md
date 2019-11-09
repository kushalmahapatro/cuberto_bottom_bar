
# Cuberto Bottom Bar
`CubertoBottomBar` widget in Flutter.
## CubertoBottomBar - Default Style
![CubertoBottomBar - Default Style](https://media.giphy.com/media/5RSvz7q2sj5HmmzVf1/giphy.gif "Cuberto Bottom bar Gif- Default Style")

## CubertoBottomBar - Faded Style
![CubertoBottomBar - Faded Style](https://media.giphy.com/media/8Twd7w3GZi12XFAPEQ/giphy.gif "Cuberto Bottom bar Gif- Faded Style")

## Getting Started

```yaml
dependencies:
  ...
  cuberto_bottom_bar: ^1.1.0
```

## Limitations
For now this is limited to more than 1 tab, and less than 5. So 2-4 tabs.
textColor will only be applied in the case of STYLE_NORMAL,
in case of STYLE_FADED_BACKGROUND the tabColor will be set as textColor,(if tabColor is not set inactiveColor will be set)

manually drawer or endDrawer has to be added and then respective drawer has to be added in CubertoBottomBar (
CubertoDrawer.NO_DRAWER for no drawer, CubertoDrawer.START_DRAWER for drawer and CubertoDrawer.END_DRAWER for endDrawer)

By default the drawer overlaps the CubertoBottomBar, for that margin: EdgeInsets.only(bottom: 60.0) has been added. (Please check with the example)

The values in onTabChangedListener: (position, title, color) (position, title and color are null at the beginning), but gets the value once the tab is clicked.
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
**iconData** -> Icon to be used for the tab
**title** -> String to be used for the tab
**tabColor:** -> Colors to be used for background and label when `STYLE_FADED_BACKGROUND` is chosen
**onClick** -> Optional function to be used when the circle itself is clicked, on an active tab

## Attributes
### Required
* **tabs** -> List of `TabData` objects
* **onTabChangedListener** -> Function to handle a tap on a tab, receives `int position`, `String title` and `Color tabColor` (if not set will return `inactiveIconColor` in both `STYLE_NORMAL` and `STYLE_FADED_BACKGROUND`)

### Optional
* **initialSelection** -> Defaults to `0`
* **inactiveIconColor** -> Defaults to `null`, derives from `Theme`
* **textColor** -> Defaults to `Colors.white`
* **barBackgroundColor** -> Defaults to `null`, derives from `Theme`
* **barBorderRadius** -> Default to null (`Scaffold`'s background color must be different than `barBackgroundColor`)
* **tabStyle** -> Defaults to `CubertoTabStyle.STYLE_NORMAL`
* **drawer** -> Defaults to `CubertoDrawer.NO_DRAWER` (can be set as `CubertoDrawer.START_DRAWER` or `CubertoDrawer.END_DRAWER` as per the need for the placement of drawer icon)
* **key** -> Defaults to `null`
* **padding** -> Defaults to `EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)`. Modifies the inner padding of the bar.
* **barShadow** -> By default, adds a shadow to the bar. Can be disabled with an empty list, or modified with the desired `BoxShadow`.

## Theming
The bar will attempt to use your current theme out of the box, however you may want to theme it. Here are the attributes:

## CubertoBottom BarTheming - STYLE_FADED_BACKGROUND
![Cuberto Bottom Bar Theming - STYLE_FADED_BACKGROUND](https://github.com/kushalmahapatro/cuberto_bottom_bar/blob/master/image1.png "Cuberto Bottom Bar Theming - STYLE_FADED_BACKGROUND")

## Cuberto Bottom Bar Theming - STYLE_NORMAL
![Cuberto Bottom Bar Theming - STYLE_NORMAL](https://github.com/kushalmahapatro/cuberto_bottom_bar/blob/master/image2.png "Cuberto Bottom Bar Theming - STYLE_NORMAL")

## Showcase
If using this package in a live app, let me know and I'll add you app here.

## Inspiration
This package was inspired by a design on dribbble by Sourabh Gupta and the faded background style from Aurelien Salomon:
https://github.com/sourabhgupta811/CubertoBottomBar
https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern
https://www.instagram.com/p/BtyUbSkBlnF/

## Contributing
Contributions are welcome, please submit a PR :)
