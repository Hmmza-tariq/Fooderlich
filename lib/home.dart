import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/tab_manager.dart';
import 'screens/explore_screen.dart';
import 'screens/grocery_screen.dart';
import 'screens/recipe_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipeScreen(),
    GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Fooderlich',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            elevation: 2,
            centerTitle: true,
          ),
          body: tabManager.pages[tabManager.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: tabManager.selectedIndex,
            onTap: (index) {
              tabManager.goToTab(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy',
              ),
            ],
          ),
        );
      },
    );
  }
}
