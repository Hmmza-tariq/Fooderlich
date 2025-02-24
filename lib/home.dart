import 'package:flutter/material.dart';

import 'components/components.dart';
import 'models/models.dart';
import 'screens/explore_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    // TODO: Replace with ExploreScreen
    // Container(color: Colors.white),
    ExploreScreen(),
    // TODO: Replace with RecipesScreen
    // Container(color: Colors.green),
    Card2(
      recipe: ExploreRecipe(
        id: '2',
        cardType: RecipeCardType.card2,
        title: 'Recipe Title',
        subtitle: 'Smoothie',
        message: 'Let\'s start by making a smoothie',
        authorName: 'Sam',
        role: 'Chef',
        backgroundImage: 'assets/magazine_pics/mag2.png',
        profileImage: 'assets/profile_pics/author.png',
      ),
    ),

    // Container(color: Colors.blue),
    Card3(
      recipe: ExploreRecipe(
        id: '3',
        cardType: RecipeCardType.card3,
        title: 'Recipe Title',
        subtitle: 'Smoothie',
        message: 'Let\'s start by making a smoothie',
        authorName: 'Sam',
        role: 'Chef',
        backgroundImage: 'assets/magazine_pics/mag3.png',
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
  }
}
