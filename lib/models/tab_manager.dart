import 'package:flutter/material.dart';

import '../screens/explore_screen.dart';
import '../screens/grocery_screen.dart';
import '../screens/recipe_screen.dart';

class TabManager extends ChangeNotifier {
  int _selectedIndex = 0;

  List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipeScreen(),
    GroceryScreen(),
  ];

  void goToTab(index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
