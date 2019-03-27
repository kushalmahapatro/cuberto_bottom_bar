
# Cuberto Bottom Bar
Cuberto Bottom Bar in flutter
![Cuberto Bottom bar Gif]( "Cuberto Bottom bar Gif")

## Getting Started

Add the plugin (pub coming soon):

```yaml
dependencies:
  ...
  cuberto_bottom_bar: ^0.01.
```

## Limitations
For now this is limited to more than 1 tab, and less than 5. So 2-4 tabs.

## Basic Usage

Adding the widget
```dart
bottomNavigationBar: FancyBottomNavigation(
    tabs: [
        TabData(iconData: Icons.home, title: "Home"),
        TabData(iconData: Icons.search, title: "Search"),
        TabData(iconData: Icons.shopping_cart, title: "Basket")
    ],
    onTabChangedListener: (position) {
        setState(() {
        currentPage = position;
        });
    },
)
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

## Programmatic Selection

To select a tab programmatically you will need to assign a GlobalKey to the widget. When you want to change tabs you will need to access the State using this key, and then call `setPage(position)`.<br/>
See example project, main.dart, line 75 for an example.

## Showcase
Using this package in a live app, let me know and I'll add you app here.


## Inspiration

This package was inspired by a design on dribbble bySourabh Gupta and the faded backgorund style from Aurelien Salomon:<br/>
https://github.com/sourabhgupta811/CubertoBottomBar <br/>
https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern <br/>
https://www.instagram.com/p/BtyUbSkBlnF/ <br/>
## Contributing

Contributions are welcome, please submit a PR :)
