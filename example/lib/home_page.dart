import 'package:example/bottom_bar_with_drawer.dart';
import 'package:example/bottom_bar_with_end_drawer.dart';
import 'package:example/bottom_bar_with_faded_background.dart';
import 'package:example/bottom_bar_with_normal_style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuberto Bottom Bar Examples')),
      body: Column(
        children: [
          _ExampleListTile(
            title: 'Bottom bar with normal style',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomBarWithNormalStyle(),
                ),
              );
            },
          ),
          _ExampleListTile(
            title: 'Bottom bar with faded background',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomBarWithFadedBackground(),
                ),
              );
            },
          ),
          _ExampleListTile(
            title: 'Bottom bar with drawer',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomBarWithDrawer(),
                ),
              );
            },
          ),
          _ExampleListTile(
            title: 'Bottom bar with end drawer',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomBarWithEndDrawer(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExampleListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ExampleListTile({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
